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
    nvd            # Nix Version Diff - shows what changed between rebuilds

    # CLI tools
    autojump       # jump to directories by 'j'
    fd             # find files
    htop           # interactive process viewer
    jq             # command-line JSON processor
    lazygit        # git repository viewer
    ncdu           # ncurses disk usage analyzer
    pre-commit     # pre-commit hooks
    ripgrep        # command-line search tool
    watch          # watch files
    lsd            # ls replacement
    bat            # cat replacement
    nnn            # cli file explorer
    nload          # network utilisation chart
    sd             # sed alternative

    # dev tools
    uv             # python virtual environment manager
    docker         # container
    docker-compose # container compose
  ];
}
