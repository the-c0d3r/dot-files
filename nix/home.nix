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
    # kitty   # BUG: why when I use kitty installed by nix, it has segfault?
    obsidian
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".pythonrc".source = ../files/zsh/pythonrc;

    ".tmux.conf".source = ../files/tmux/tmux.conf;
    ".tmux.conf.local".source = ../files/tmux/tmux.conf.local;

    ".config/nvim".source = ../files/nvim;
  };

  # You can also manage environment variables
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
    # TODO: fix the import issues
    enable = true;
    # plugins = with pkgs.tmuxPlugins; [
    #   sensible
    #   pain-control
    #   yank
    # ];
    extraConfig = ''
      # Source your existing tmux.conf content
      source-file ${../files/tmux/tmux.conf}
    '';
  };

  programs.git = {
    enable = true;
    ignores = [
      ".idea"
      "**/.idea"
      "logs/*/"
      "logs/*.log"
      "logs/*.log.*"
      "__pycache__"
      "**/__pycache__"
      "env/"
      ".venv/"
      ".DS_Store"
      "**/.DS_Store"
    ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ../files/starship/starship.toml);
  };

  programs.kitty = {
    enable = true;
    settings = {
      # Fonts
      font_family = "Cartograph CF Regular";
      bold_font = "Cartograph CF Bold";
      italic_font = "Cartograph CF Regular Italic";
      bold_italic_font = "Cartograph CF Bold Italic";
      font_features = "FiraCodeNerdFontComplete-Retina +zero +ss06";
      font_size = "13.0";

      # Window
      initial_window_width = 640;
      initial_window_height = 400;
      window_logo_position = "bottom-right";
      window_logo_alpha = "0.5";
      hide_window_decorations = "yes"; # Kept as it might be preferred

      # Tab Bar
      tab_bar_style = "fade";
      tab_powerline_style = "angled";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}";
      active_tab_font_style = "bold-italic";

      # MacOS
      macos_option_as_alt = "no";
      linux_display_server = "auto";

      symbol_map = let
        mappings = [
          "U+E5FA-U+E62B" # Seti-UI + Custom
          "U+E700-U+E7C5" # Devicons
          "U+F000-U+F2E0" # Font Awesome
          "U+E200-U+E2A9" # Font Awesome Extension
          "U+F500-U+FD46" # Material Design Icons
          "U+E300-U+E3EB" # Weather
          "U+F400-U+F4A8,U+2665,U+26A1,U+F27C" # Octicons
          "U+E0A3,U+E0B4-U+E0C8,U+E0CC-U+E0D2,U+E0D4" # Powerline Extra Symbols
          "U+23FB-U+23FE,U+2b58" # IEC Power Symbols
          "U+F300-U+F313" # Font Logos
          "U+E000-U+E00D" # Pomicons
        ];
      in (builtins.concatStringsSep "," mappings) + " Symbols Nerd Font";
    };
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
    shellAliases = {
      # system aliases
      l = "ls -lah --color=auto";
      ll = "ls -l";

      # program aliases
      lg = "lazygit";

      # vim aliases
      v = "nvim";
      vi = "nvim";
      vim = "nvim";

      # tmux aliases
      tmls = "tmux ls";
      tmat = "tmux attach -t";
      tmns = "tmux new -s";
      tmkl = "tmux kill-session -t";

      # git aliases
      gs = "git status";
      ga = "git add";
      gdh = "git diff HEAD";     # see what's the uncommited changes
      gdhp = "git diff HEAD^";   # see what's the previous commit changes
      gdm = "git diff master";
      gp = "git push";
      gcan = "git commit --amend --no-edit";
      gamd = "git commit --amend";
    };

    initContent = ''
      # === Extra files to be sourced
      source ~/.pythonrc
      # file_source ~/.secrets

      function wsyncd() {
          usage="Usage: wsyncd dirname sshpath"
          if [ -z "$1" ] && [ -z "$2" ]; then
              echo "$usage"
              return
          fi

          dirname="$1"
          sshpath="$2"

          fswatch -o "$dirname" | while read f; do rsync -av "$dirname/" "$sshpath/"; done;
      }

      # Explicitly bind Ctrl-R to Atuin, in case vi-mode overwrites it
      bindkey '^r' atuin-search
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
