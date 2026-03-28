{ config, pkgs, lib, ... }:

{
  imports = [
    ./atuin.nix
    ./git.nix
    ./i3.nix
    ./kitty.nix
    ./obsidian.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ];
}
