{ config, pkgs, lib, system, username, isNixOS ? false, ... }:

let
  customPkgs = import ../packages { inherit pkgs; };
in
{
  imports = [
    ../programs
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
  # Note: atuin, tmux, kitty, starship are managed via programs.* in programs/
  home.packages = with pkgs; [
    # CLI tools
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
    tree         # directory tree viewer
    watch        # watch files
    wget         # download files

    # apps
    customPkgs.obsidian  # Platform-aware Obsidian with Linux GPU/Wayland fixes
    discord      # chat
    keepassxc    # password manager

    # dev tools
    antigravity  # AI text editor
    vscodium     # code editor
    uv           # python virtual environment manager
  ];

  # Enable generic Linux target to allow symlinking desktop files
  # Not needed on NixOS — it's only for non-NixOS Linux systems
  targets.genericLinux.enable = pkgs.stdenv.isLinux && !isNixOS;

  home.file = {
    ".config/nvim".source = ../files/nvim;
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

  # Syncthing — unified across NixOS, Linux, and macOS
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        "Thus-MacBook-Pro.local" = { id = "6DQWVMC-AUX6QMC-2EV6OWS-RU67KYA-BZCFJMD-O3BHL7H-CXPDRMF-H3BLSQB"; };
        "codelab-nas"            = { id = "HAHND7O-I7PP2PI-NOVCINC-BJHJHKA-EYGNI4E-AIC3AXI-H7ENVWL-LPLXZAK"; };
        "Z Fold 6"               = { id = "66PF7CU-2XJTPGA-YPI2HPD-TLZH25H-NNI7C5V-JV37Y3X-OMLIXEJ-3AZRLAG"; };
      };
      folders = {
        "Documents" = {
          id = "pcibl-josuz";
          path = "${config.home.homeDirectory}/syncthing/Documents";
          devices = [ "codelab-nas" "Z Fold 6" "Thus-MacBook-Pro.local" ];
        };
        "shared" = {
          id = "jotgl-p9lwk";
          path = "${config.home.homeDirectory}/syncthing/shared";
          devices = [ "codelab-nas" "Z Fold 6" "Thus-MacBook-Pro.local" ];
        };
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
