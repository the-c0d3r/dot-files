# home/linux.nix — Generic (non-NixOS) Linux home-manager config
#
# Used for distros like Ubuntu, Arch, etc. that run home-manager standalone.
# Imports linux-common.nix for shared Linux packages, then adds a tiling WM setup.
#
# Applied via: homeConfigurations."linux" in flake.nix

{ config, pkgs, ... }:

{
  imports = [ ./linux-common.nix ];

  nixpkgs.config.allowUnfree = true;

  # Tiling WM dotfiles
  home.file = {
    ".config/i3/config".source     = ../files/i3/config;
    ".config/polybar".source       = ../files/polybar;
  };

  home.packages = with pkgs; [
    i3       # tiling window manager
    polybar  # status bar
  ];
}
