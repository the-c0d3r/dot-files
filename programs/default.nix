{ config, pkgs, lib, isServer ? false, ... }:

{
  imports = [
    # CLI programs — always included
    ./atuin.nix
    ./git.nix
    ./neovim.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ] ++ lib.optionals (!isServer) [
    # GUI / desktop programs — excluded in server mode
    ./i3.nix
    ./kitty.nix
    ./obsidian.nix
    ./syncthing.nix
    ./vicinae.nix
    ./vscode.nix
  ];
}
