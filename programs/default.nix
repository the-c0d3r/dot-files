{ config, pkgs, lib, isServer ? false, ... }:

{
  imports = [
    # CLI programs — always included
    ./atuin.nix
    ./neovim.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ] ++ lib.optionals (!isServer) [
    # GUI / desktop programs — excluded in server mode
    ./git.nix    # git has my own config, which shouldn't apply on server.
    ./i3.nix
    ./kitty.nix
    ./obsidian.nix
    ./syncthing.nix
    ./vicinae.nix
    ./vscode.nix
  ];
}
