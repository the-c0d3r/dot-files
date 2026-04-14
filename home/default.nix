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
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";

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
    dos2unix       # convert files from DOS to UNIX format
    fd             # find files
    htop           # interactive process viewer
    jq             # command-line JSON processor
    lazygit        # git repository viewer
    ncdu           # ncurses disk usage analyzer
    pre-commit     # pre-commit hooks
    pv             # pipe viewer
    ripgrep        # command-line search tool
    tree           # directory tree viewer
    watch          # watch files
    wget           # download files
    lsd            # ls replacement
    bat            # cat replacement
    nnn            # cli file explorer

    # dev tools
    uv             # python virtual environment manager
    docker         # container
    docker-compose # container compose
  ] ++ lib.optionals (!isServer) [
    # CIS L2 violations — prohibited on hardened servers
    # Network recon / raw socket tools (CIS L2: "remove network scanning tools")
    nmap           # network scanner
    netcat         # raw network utility / exfil vector
    # Compilers / build tools (CIS L2: "remove development tools from production")
    # NOTE: installed via Nix these are invisible to dpkg/rpm scans — extra risk
    gcc
    gnumake
    cmake

    # Unnecessary on servers (no violation, just bloat)
    ffmpeg
    fswatch

    # Desktop apps — no GUI on servers
    discord
    telegram-desktop
    keepassxc
    antigravity
  ];

  # Only needed on non-NixOS Linux to enable desktop file symlinking, session
  # variable sourcing, etc. NixOS handles this natively via the HM module.
  targets.genericLinux.enable = pkgs.stdenv.isLinux && !isNixOS;

  home.sessionVariables = {
    # Editor & Terminal
    EDITOR = "nvim";
    TERM = "xterm-256color";

    # Locale
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";

    # Oh-My-Zsh
    DISABLE_UNTRACKED_FILES_DIRTY = "true";
    DISABLE_UPDATE_PROMPT = "true";
    DISABLE_AUTO_UPDATE = "true";
    HIST_STAMPS = "%d/%m/%y %T";

    # Ansible
    ANSIBLE_FORCE_COLOR = "true";
    ANSIBLE_STDOUT_CALLBACK = "yaml";
  };

  programs.home-manager.enable = true;
}
