{ pkgs, ... }:

{
  imports = [
    ./cli.nix
    ./fonts.nix
    ./git.nix
    ./kitty.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    # CLI tools
    nmap # network scanner
    netcat # raw network utility
    fswatch # file change watcher
    gdb # debugger
    python3

    # Desktop apps
    keepassxc # password manager
    google-chrome # browser

    # communication tools
    discord
    signal-desktop
    telegram-desktop

    # AI coding
    claude-code
    docker-sbx # sandboxed agents
  ];
}
