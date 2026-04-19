# home/linux.nix — Shared config for all Linux environments (NixOS + generic)
#
# Imported by:
#   - homeConfigurations."linux" in flake.nix
#   - homeConfigurations."kali" in flake.nix
#   - nixosConfigurations (alongside home/default.nix)
#
# Note: allowUnfree is handled at the flake level, not here

{ config, pkgs, lib, inputs, system, isNixOS ? false, ... }:

{
  home.packages = with pkgs; [
    # Linux utilities
    xclip     # clipboard tool

    # Browser
    inputs.zen-browser.packages.${system}.default

    # virtualisation
    vagrant

    # development
    nodejs_24

    libreoffice  # office
    vlc          # media player
  ] ++ lib.optionals (!isNixOS) [
    # on NixOS, VirtualBox is provided by virtualisation.virtualbox.host in configuration.nix
    virtualbox
  ];
}
