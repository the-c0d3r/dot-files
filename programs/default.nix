{ config, pkgs, lib, ... }:

{
  imports = [
    ./atuin.nix
    ./git.nix
    ./kitty.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ];
}
