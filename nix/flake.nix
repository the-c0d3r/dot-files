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
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }:
    let
      # Runtime username detection (requires --impure)
      # Fallback to "the-coder" if USER is not set
      username = let envUser = builtins.getEnv "USER"; in if envUser != "" then envUser else "the-coder";

      # Use a helper function for home configurations
      mkHome = system: extraModules: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ./home.nix
        ] ++ extraModules;
        extraSpecialArgs = { inherit system username; };
      };

      mkDarwin = system: darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./darwin-configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = {
              imports = [ ./home.nix ./darwin.nix ];
            };
            home-manager.extraSpecialArgs = { inherit system username; };
          }
        ];
        specialArgs = { inherit self username; };
      };
    in {
      # Configs named by OS (generic)
      homeConfigurations."linux" = mkHome "x86_64-linux" [ ./linux.nix ];
      homeConfigurations."kali" = mkHome "x86_64-linux" [ ./linux.nix ./kali.nix ];
      homeConfigurations."mac-intel" = mkHome "x86_64-darwin" [ ./darwin.nix ];
      homeConfigurations."mac-arm" = mkHome "aarch64-darwin" [ ./darwin.nix ];

      darwinConfigurations."mac-arm" = mkDarwin "aarch64-darwin";
      darwinConfigurations."mac-intel" = mkDarwin "x86_64-darwin";
    };
}
