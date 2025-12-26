{ config, pkgs, system, username, ... }:

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
    ".p10k.zsh".source = ../files/zsh/p10k.zsh;

    ".tmux.conf.local".source = ../files/tmux/tmux.conf.local;

    ".config/nvim".source = ../files/nvim;
    ".config/kitty/kitty.conf".source = ../files/kitty/kitty.conf;
    ".config/atuin/config.toml".source = ../files/atuin/config.toml;
  };

  # You can also manage environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Specific program configurations can go here
  programs.zsh = {
    enable = true;
    # oh-my-zsh is handled better via Nix if we want it declarative
    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" "sudo" "docker" "python" "tmux" "vi-mode" "autojump" 
        "colored-man-pages" "zsh-autosuggestions" "zsh-syntax-highlighting" 
      ];
      theme = "robbyrussell";
    };
    initContent = ''
      # Source your existing zshrc content, but filter out the manual Oh-My-Zsh setup
      # to avoid conflicts with Home Manager's management.
      source <(sed -e 's|^source \$ZSH/oh-my-zsh.sh|: # OMZ handled by Nix|' \
                   -e 's|^export ZSH=.*|: # Path handled by Nix|' \
                   ${../files/zsh/zshrc})

      # Source your local rc files if they aren't already sourced by zshrc
      [ -f ~/.aliases ] && source ~/.aliases
      [ -f ~/.functionsrc ] && source ~/.functionsrc
    '';
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
}
