{ config, pkgs, ... }:

{
  home.file = {
    ".local/share/fonts".source = ../files/fonts;
    ".config/i3/config".source = ../files/i3/config;
    ".config/polybar".source = ../files/polybar;
    ".config/rofi/config".source = ../files/rofi/config;
    ".local/share/rofi/themes".source = ../files/rofi/themes;
  };

  home.packages = with pkgs; [
    i3
    polybar
    rofi
    xclip # Linux-specific clipboard tool
    
    # From install-centos.sh
    nload
  ];
}
