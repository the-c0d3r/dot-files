# home/linux.nix — Shared config for all Linux environments (NixOS + generic)
#
# Imported by:
#   - homeConfigurations."linux" in flake.nix
#   - homeConfigurations."kali" in flake.nix
#   - nixosConfigurations (alongside home/default.nix)
#
# Note: allowUnfree is handled at the flake level, not here

{ config, pkgs, inputs, system, ... }:

let
  sharedFonts = import ../fonts { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    # Linux utilities
    vicinae   # app launcher (rofi replacement)
    xclip     # clipboard tool
    ticktick  # task manager
    nload     # network monitor

    # Browser
    inputs.zen-browser.packages.${system}.default
  ] ++ sharedFonts;

  # Enable fontconfig to ensure fonts are properly recognized
  fonts.fontconfig.enable = true;
}
