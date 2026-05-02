# home/kali/default.nix — Kali Linux entry point
#
# CLI base + pentest tools, without the full Linux desktop stack.
# Applied via: homeConfigurations."kali" in flake.nix

{ ... }:

{
  imports = [
    ../default.nix
    ../programs/cli.nix
    ./tools.nix
  ];
}
