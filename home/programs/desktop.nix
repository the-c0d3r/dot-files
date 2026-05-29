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
    gdb

    # Desktop apps
    keepassxc         # password manager

    # communication tools
    discord
    signal-desktop
    telegram-desktop

    # AI coding
    claude-code
    python3
    google-chrome
  ];
}
