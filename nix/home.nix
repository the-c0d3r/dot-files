{ config, pkgs, lib, system, username, ... }:

{
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
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
    vscodium
    kitty
    obsidian
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".aliases".source = ../files/zsh/aliases;
    ".linuxrc".source = ../files/zsh/linuxrc;
    ".dockerrc".source = ../files/zsh/dockerrc;
    ".functionsrc".source = ../files/zsh/functionsrc;
    ".gitrc".source = ../files/zsh/gitrc;
    ".pythonrc".source = ../files/zsh/pythonrc;
    ".macrc".source = ../files/zsh/macrc;
    ".gitignore_global".source = ../files/zsh/gitignore_global;
    # ".p10k.zsh".source = ../files/zsh/p10k.zsh;

    ".tmux.conf.local".source = ../files/tmux/tmux.conf.local;

    ".config/nvim".source = ../files/nvim;
    ".config/kitty/kitty.conf".source = ../files/kitty/kitty.conf;
    # ".config/atuin/config.toml".source = ../files/atuin/config.toml;
  };

  # You can also manage environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Force creation of Atuin config, as it would automatically create it
  xdg.configFile."atuin/config.toml".force = lib.mkForce true;

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      enter_accept = true;
      keymap_mode = "auto";
    };
    flags = [ "--disable-up-arrow" ]; 
  };

  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      pain-control
      yank
    ];
    extraConfig = ''
      # Source your existing tmux.conf content
      source-file ${../files/tmux/tmux.conf}
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ../files/starship/starship.toml);
  };

  # Specific program configurations can go here
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 999999999;
      save = 999999999;
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      share = false;
    };
    setOptions = [
      # ignore all the duplicated command consecutively
      "HIST_IGNORE_ALL_DUPS" 
      # Do not display a line previously found
      "HIST_FIND_NO_DUPS"    
      # Dont write duplicate entries in the history file
      "HIST_SAVE_NO_DUPS"    
    ];

    initExtra = ''
      source ${../files/zsh/zshrc}
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" "sudo" "docker" "python" "tmux" "vi-mode" "autojump" 
        "colored-man-pages"
      ];
      theme = "robbyrussell";
    };
  };
}
