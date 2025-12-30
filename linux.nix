{ config, pkgs, ... }:

{
  home.file = {
    ".local/share/fonts".source = ./files/fonts;
    ".config/i3/config".source = ./files/i3/config;
    ".config/polybar".source = ./files/polybar;
    ".config/rofi/config".source = ./files/rofi/config;
    ".local/share/rofi/themes".source = ./files/rofi/themes;
  };

  home.packages = with pkgs; [
    i3
    polybar
    rofi
    xclip # Linux-specific clipboard tool
    ticktick  # task manager

    # From install-centos.sh
    nload
  ];

  programs.zsh = {
    initContent = ''
      # Keyboard key repeat speed
      # xset r rate [delay] [rate]
      [ -x "$(command -v xset)" ] && xset r rate 300 15
    '';
  };
}
