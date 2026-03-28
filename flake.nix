{
  description = "A Modern Nix-based Dotfiles Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, determinate, zen-browser, ... }@inputs:
    let
      # Pure username detection from vars.nix
      vars = import ./vars.nix;
      username = vars.username;

      # Use a helper function for home configurations
      mkHome = system: extraModules: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ./home
        ] ++ extraModules;
        extraSpecialArgs = { inherit system username; };
      };

      mkNixos = system: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs username; };
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home/nixos.nix;
            home-manager.extraSpecialArgs = { inherit system username; isNixOS = true; };
          }
        ];
      };

      mkDarwin = system: darwin.lib.darwinSystem {
        inherit system;
        modules = [
          determinate.darwinModules.default
          ./hosts/darwin/configuration.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home/darwin.nix;
            home-manager.extraSpecialArgs = { inherit system username; };
          }
        ];
        specialArgs = { inherit self username inputs; };
      };
    in {
      determinate = {
        customSettings = {
          experimental-features = "nix-command flakes";
          extra-experimental-features = "parallel-eval";
          lazy-trees = true;
          eval-cores = 0; # Enable parallel evaluation across all cores
          warn-dirty = false;
        };
      };

      # Configs named by OS (generic)
      homeConfigurations."linux" = mkHome "x86_64-linux" [ ./home/linux.nix ];
      homeConfigurations."kali" = mkHome "x86_64-linux" [ ./home/linux.nix ./home/kali.nix ];
      # homeConfigurations."mac-intel" = mkHome "x86_64-darwin" [ ./darwin.nix ];
      # homeConfigurations."mac-arm" = mkHome "aarch64-darwin" [ ./darwin.nix ];

      # NixOS configurations
      nixosConfigurations."codelab-nix" = mkNixos "x86_64-linux";

      # Expose the configuration matching the username/hostname
      darwinConfigurations."mac-arm" = mkDarwin "aarch64-darwin";
      darwinConfigurations."mac-intel" = mkDarwin "x86_64-darwin";

      devShells = let
        mkDevShell = system: let
          pkgs = import nixpkgs { inherit system; };
          darwinConfig = if system == "aarch64-darwin" then "mac-arm" else "mac-intel";
        in {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              (writeShellApplication {
                name = "apply-nix-darwin-configuration";
                runtimeInputs = [ inputs.darwin.packages.${system}.darwin-rebuild ];
                text = ''
                  echo "> Applying nix-darwin configuration..."
                  echo "> Running darwin-rebuild switch as root..."
                  sudo darwin-rebuild switch --flake ".#${darwinConfig}"
                  echo "> darwin-rebuild switch was successful ✅"
                  echo "> macOS config was successfully applied 🚀"
                '';
              })
            ];
          };
        };
      in {
        "x86_64-darwin" = mkDevShell "x86_64-darwin";
        "aarch64-darwin" = mkDevShell "aarch64-darwin";
      };
    };
}
