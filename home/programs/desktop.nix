{ pkgs, ... }:

{
  imports = [
    ./cli.nix
    ./fonts.nix
    ./git.nix
    ./kitty.nix
    ./obsidian.nix
    ./syncthing.nix
    ./vicinae.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    nmap              # network scanner
    netcat            # raw network utility
    fswatch

    # Desktop apps
    keepassxc         # password manager
    ticktick          # task manager

    # communication tools
    discord
    signal-desktop
    telegram-desktop
  ];
}
