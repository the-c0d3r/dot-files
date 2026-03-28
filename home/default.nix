# home/default.nix — Shared home-manager config for all platforms
#
# Imported by every platform config. Contains packages, dotfiles, env vars,
# and programs that are universal (NixOS, macOS, generic Linux).
#
# Platform-specific additions:
#   NixOS        → flake.nix also imports home/linux-common.nix
#   macOS        → home/darwin.nix imports this file
#   Generic Linux→ home/linux.nix imports home/linux-common.nix (WM + shared Linux packages)
#   Kali         → home/kali.nix adds pentesting tools on top

{ config, pkgs, lib, system, username, isNixOS ? false, ... }:

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
    discord      # chat
    keepassxc    # password manager

    # dev tools
    antigravity  # AI text editor
    uv           # python virtual environment manager
  ];

  # Only needed on non-NixOS Linux to enable desktop file symlinking, session
  # variable sourcing, etc. NixOS handles this natively via the HM module.
  targets.genericLinux.enable = pkgs.stdenv.isLinux && !isNixOS;

  # Dotfiles managed by home-manager
  home.file = {
    ".config/nvim".source = ../files/nvim;
  };

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

  # Syncthing runs as a user service on all platforms (systemd on Linux, launchd on macOS)
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

  programs.home-manager.enable = true;
}
