{ config, pkgs, lib, ... }:

{
  imports = [
    ./atuin.nix
    ./git.nix
    ./i3.nix
    ./kitty.nix
    ./neovim.nix
    ./obsidian.nix
    ./starship.nix
    ./syncthing.nix
    ./tmux.nix
    ./vicinae.nix
    ./vscode.nix
    ./zsh.nix
  ];
}
