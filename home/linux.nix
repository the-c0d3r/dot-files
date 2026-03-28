# home/linux.nix — Shared config for all Linux environments (NixOS + generic)
#
# Imported by:
#   - homeConfigurations."linux" in flake.nix
#   - homeConfigurations."kali" in flake.nix
#   - nixosConfigurations (alongside home/default.nix)

{ config, pkgs, ... }:

let
  sharedFonts = import ../fonts { inherit pkgs; };
in
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Linux utilities
    vicinae   # app launcher (rofi replacement)
    xclip     # clipboard tool
    ticktick  # task manager
    nload     # network monitor
  ] ++ sharedFonts;

  # Enable fontconfig to ensure fonts are properly recognized
  fonts.fontconfig.enable = true;
}
