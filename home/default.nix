# home/default.nix — Shared home-manager config for all platforms
#
# Imported by every platform config. Contains packages, dotfiles, env vars,
# and programs that are universal (NixOS, macOS, generic Linux).
#
# Platform-specific additions:
#   NixOS        → flake.nix also imports home/linux.nix
#   macOS        → home/darwin.nix imports this file
#   Generic Linux→ home/linux.nix imports home/linux-common.nix (WM + shared Linux packages)
#   Kali         → home/kali.nix adds pentesting tools on top

{ config, pkgs, lib, username, isNixOS ? false, isServer ? false, ... }:

{
  imports = [
    ../programs  # shared program configs (zsh, git, tmux, kitty, obsidian, etc.)
  ];

  home.username = username;
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else if username == "root" then "/root" else "/home/${username}";

  # Do not change this value — it pins home-manager behaviour, not the NixOS version.
  home.stateVersion = "23.11";

  # Packages installed to the user profile.
  # Programs with dedicated modules (atuin, tmux, kitty, starship, vscodium)
  # are omitted here — their modules handle installation.
  home.packages = with pkgs; [
    # Nix tools
    nvd            # Nix Version Diff - shows what changed between rebuilds

    # CLI tools
    autojump       # jump to directories by 'j'
    fd             # find files
    htop           # interactive process viewer
    jq             # command-line JSON processor
    lazygit        # git repository viewer
    ncdu           # ncurses disk usage analyzer
    pre-commit     # pre-commit hooks
    ripgrep        # command-line search tool
    watch          # watch files
    lsd            # ls replacement
    bat            # cat replacement
    nnn            # cli file explorer
    nload          # network utilisation chart
    sd             # sed alternative

    # dev tools
    uv             # python virtual environment manager
    docker         # container
    docker-compose # container compose
  ] ++ lib.optionals (!isServer) [
    nmap           # network scanner
    netcat         # raw network utility / exfil vector
    fswatch

    # Desktop apps
    keepassxc         # password manager
    ticktick          # task manager

    # communication tools
    discord
    signal-desktop
    telegram-desktop
  ];

  # Only needed on non-NixOS Linux to enable desktop file symlinking, session
  # variable sourcing, etc. NixOS handles this natively via the HM module.
  targets.genericLinux.enable = pkgs.stdenv.isLinux && !isNixOS;

  home.sessionVariables = {
    # Editor & Terminal
    EDITOR = "nvim";
    TERM = "xterm-256color";
    HIST_STAMPS = "%d/%m/%y %T";

    # Locale
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  programs.home-manager.enable = true;
}
