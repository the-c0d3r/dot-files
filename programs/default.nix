{ config, pkgs, lib, ... }:

{
  imports = [
    ./atuin.nix
    ./git.nix
    ./kitty.nix
    ./obsidian.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ];
}
