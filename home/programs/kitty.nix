{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    # Using extraConfig to inline theme colors (themeFile include wasn't working)
    extraConfig = ''
      # Catppuccin Mocha
      foreground              #CDD6F4
      background              #1E1E2E
      selection_foreground    #1E1E2E
      selection_background    #F5E0DC
      cursor                  #F5E0DC
      cursor_text_color       #1E1E2E
      url_color               #F5E0DC
      active_border_color     #B4BEFE
      inactive_border_color   #6C7086
      bell_border_color       #F9E2AF
      active_tab_foreground   #11111B
      active_tab_background   #CBA6F7
      inactive_tab_foreground #CDD6F4
      inactive_tab_background #181825
      tab_bar_background      #11111B
      mark1_foreground        #1E1E2E
      mark1_background        #B4BEFE
      mark2_foreground        #1E1E2E
      mark2_background        #CBA6F7
      mark3_foreground        #1E1E2E
      mark3_background        #74C7EC
      color0                  #45475A
      color8                  #585B70
      color1                  #F38BA8
      color9                  #F38BA8
      color2                  #A6E3A1
      color10                 #A6E3A1
      color3                  #F9E2AF
      color11                 #F9E2AF
      color4                  #89B4FA
      color12                 #89B4FA
      color5                  #F5C2E7
      color13                 #F5C2E7
      color6                  #94E2D5
      color14                 #94E2D5
      color7                  #BAC2DE
      color15                 #A6ADC8
    '';
    settings = {
      # Fonts
      font_family = "Cartograph CF Regular";
      bold_font = "Cartograph CF Bold";
      italic_font = "Cartograph CF Regular Italic";
      bold_italic_font = "Cartograph CF Bold Italic";
      font_features = "FiraCodeNerdFontComplete-Retina +zero +ss06";
      font_size = "11.0";

      # Window
      initial_window_width = 640;
      initial_window_height = 400;
      window_logo_position = "bottom-right";
      window_logo_alpha = "0.5";
      hide_window_decorations = "no";
      background_opacity = "0.7";
      confirm_os_window_close = 0;

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
}
