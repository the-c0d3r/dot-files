{ config, pkgs, lib, ... }:

{
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
}
