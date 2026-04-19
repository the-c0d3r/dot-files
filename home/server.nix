# home/server.nix — Server entry point (headless, CLI only)
#
# Used by: homeConfigurations."server", homeConfigurations."server-nixos"

{ ... }:

{
  imports = [
    ./default.nix
    ./programs/cli.nix
  ];
}
