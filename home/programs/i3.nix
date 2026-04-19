# programs/i3.nix — i3 tiling window manager + polybar
#
# Only enabled on generic (non-NixOS) Linux systems.
# NixOS users typically configure WM at the system level.

{ config, pkgs, lib, ... }:

{
  # Only install on Linux (not macOS, and typically not needed on NixOS)
  home.packages = lib.optionals pkgs.stdenv.isLinux (with pkgs; [
    i3       # tiling window manager
    polybar  # status bar
  ]);

  # Dotfiles for i3 and polybar
  home.file = lib.mkIf pkgs.stdenv.isLinux {
    ".config/i3/config".source = ../files/i3/config;
    ".config/polybar".source   = ../files/polybar;
  };
}
