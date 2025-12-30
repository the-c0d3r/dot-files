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
    atuin
    autojump
    dos2unix
    fd
    ffmpeg
    fswatch
    htop
    jq
    lazygit
    ncdu
    neovim
    netcat
    nmap
    gcc
    gnumake
    cmake
    pre-commit
    pv
    ripgrep
    starship
    tmux
    tree
    watch
    wget

    # utils
    syncthing

    # apps
    kitty     # if it "Failed to initialize EGL", do `sudo /nix/store/HASH-non-nixos-gpu/bin/non-nixos-gpu-setup`
    customPkgs.obsidian  # Platform-aware Obsidian with Linux GPU/Wayland fixes
    discord   # chat
    keepassxc # password manager

    # dev tools
    antigravity
    vscodium
    #lmstudio
    # ollama-cuda
    uv
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
