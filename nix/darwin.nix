{ config, pkgs, ... }:

{
  home.file = {
    "Library/Fonts".source = ../files/fonts;
    ".config/karabiner/karabiner.json".source = ../files/karabiner/karabiner.json;
    ".config/yabai/yabairc".source = ../files/yabai/yabairc;
    ".config/yabai/scripts".source = ../files/yabai/scripts;
    ".config/skhd/skhdrc".source = ../files/skhd/skhdrc;
  };

  home.packages = with pkgs; [
    # Yabai and skhd are usually better managed via nix-darwin services
    # but we can add them here as packages if needed.
    yabai
    skhd
    coreutils
    gnutls
    gnused
    gnutar
    gnugrep
    # Adding tools that was in Brewfile but are more Mac-centric in this context
    iproute2mac 
  ];
}
