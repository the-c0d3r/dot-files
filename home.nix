{ config, pkgs, lib, system, username, ... }:

let
  customPkgs = import ./packages { inherit pkgs; };
in
{
  imports = [
    ./programs
  ];
  home.username = username;
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # install packages
  home.packages = with pkgs; [
    atuin        # command-line history navigator
    autojump     # jump to directories by 'j'
    dos2unix     # convert files from DOS to UNIX format
    fd           # find files
    ffmpeg       # video processing
    fswatch      # watch file system
    htop         # interactive process viewer
    jq           # command-line JSON processor
    lazygit      # git repository viewer
    ncdu         # ncurses disk usage analyzer
    neovim       # text editor
    netcat       # network utility
    nmap         # network scanner
    gcc          # C compiler
    gnumake      # make utility
    cmake        # cross-platform build system generator
    pre-commit   # pre-commit hooks
    pv           # pipe viewer
    ripgrep      # command-line search tool
    starship     # prompt
    tmux         # terminal multiplexer
    tree         # directory tree viewer
    watch        # watch files
    wget         # download files

    # utils
    syncthing    # continuous file synchronization

    # apps
    kitty        # terminal emulator
    customPkgs.obsidian  # Platform-aware Obsidian with Linux GPU/Wayland fixes
    discord      # chat
    keepassxc # password manager

    # dev tools
    antigravity  # AI text editor
    vscodium     # code editor
    #lmstudio
    # ollama-cuda
    uv           # python virtual environment manager
  ];

  # Enable generic Linux target to allow symlinking desktop files
  targets.genericLinux.enable = pkgs.stdenv.isLinux;

  home.file = {
    ".config/nvim".source = ./files/nvim;
  };

  # manage env variables
  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "xterm-256color";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";

    # Oh-My-Zsh settings
    DISABLE_UNTRACKED_FILES_DIRTY = "true";
    DISABLE_UPDATE_PROMPT = "true";
    DISABLE_AUTO_UPDATE = "true";
    HIST_STAMPS = "%d/%m/%y %T";

    # Ansible settings
    ANSIBLE_FORCE_COLOR = "true";
    ANSIBLE_STDOUT_CALLBACK = "yaml";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
