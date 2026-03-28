# home/linux-common.nix — Shared config for all Linux environments (NixOS + generic)
#
# Imported by:
#   NixOS  → flake.nix (alongside home/default.nix)
#   Others → home/linux.nix imports this

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    vicinae   # app launcher (rofi replacement)
    xclip     # clipboard tool
    ticktick  # task manager
    nload     # network monitor
  ];

  programs.zsh = {
    initContent = ''
      # Set keyboard key repeat speed (delay=300ms, rate=15 repeats/sec)
      [ -x "$(command -v xset)" ] && xset r rate 300 15
    '';
  };
}
