{ config, pkgs, lib, username, ... }:

{
  imports = [
    ./programs/cli.nix
  ];

  home.username = username;
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}"
    else if username == "root" then "/root"
    else "/home/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with.
  home.stateVersion = "23.11"; 

  # PURELY ESSENTIAL CLI
  home.packages = with pkgs; [
    # Shell / Nav
    atuin        # command-line history navigator
    autojump     # jump to directories by 'j'
    fd           # find files
    fswatch      # watch file system
    ripgrep      # command-line search tool
    tree         # directory tree viewer
    starship     # prompt
    tmux         # terminal multiplexer

    # System / Mon
    htop         # interactive process viewer
    ncdu         # ncurses disk usage analyzer
    nload        # network traffic monitor

    # Dev
    jq           # command-line JSON processor
    neovim       # text editor
    git          
    lazygit      # git repository viewer

    # Lang / Utils
    uv           # python virtual environment manager
  ];

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
