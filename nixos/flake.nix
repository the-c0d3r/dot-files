{
  description = "My NixOS system with Zen Browser";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.codelab-nix = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix

          # add Zen Browser to system packages
          ({ pkgs, ... }: {
            environment.systemPackages = [
              inputs.zen-browser.packages.${pkgs.system}.default
            ];
          })
        ];
      };
    };
}
