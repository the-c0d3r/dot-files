{ pkgs, ... }:

{
  imports = [
    ./atuin.nix
    ./neovim.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    # Nix tools
    nvd # Nix Version Diff - shows what changed between rebuilds
    nixfmt # official Nix formatter (pre-commit hook)

    # CLI tools
    autojump # jump to directories by 'j'
    fd # find files
    htop # interactive process viewer
    jq # command-line JSON processor
    lazygit # git repository viewer
    ncdu # ncurses disk usage analyzer
    pre-commit # pre-commit hooks
    ripgrep # command-line search tool
    watch # watch files
    nnn # cli file explorer
    nload # network utilisation chart
    sd # sed alternative

    # dev tools
    uv # python virtual environment manager
    docker # container
    docker-compose # container compose
  ];

  # Themes on the terminal's colours, so they follow kitty's light/dark palette
  programs.bat = {
    enable = true; # cat replacement
    config.theme = "ansi";
  };

  programs.lsd = {
    enable = true; # ls replacement
    # replaces the default theme's fixed 256-colour greys and pastels; unset keys keep lsd's defaults
    colors = {
      user = "dark_yellow";
      group = "dark_cyan";
      permission.no-access = "dark_grey";
      date = {
        hour-old = "dark_green";
        day-old = "dark_cyan";
        older = "dark_blue";
      };
      size = {
        none = "dark_grey";
        small = "dark_green";
        medium = "dark_yellow";
        large = "dark_red";
      };
      inode = {
        valid = "dark_magenta";
        invalid = "dark_grey";
      };
      links = {
        valid = "dark_magenta";
        invalid = "dark_grey";
      };
      tree-edge = "dark_grey";
      git-status = {
        default = "dark_grey";
        unmodified = "dark_grey";
        ignored = "dark_grey";
      };
    };
  };

  programs.btop = {
    enable = true; # resource monitor
    settings = {
      color_theme = "TTY";
      theme_background = false;
      save_config_on_exit = false; # config is read-only in the Nix store
    };
  };
}
