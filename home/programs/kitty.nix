{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    # Using extraConfig to inline theme colors (themeFile include wasn't working)
    extraConfig = ''
      # Everforest Light Soft
      foreground              #5C6A72
      background              #F3EAD3
      selection_foreground    #829181
      selection_background    #E1E4BD
      cursor                  #5C6A72
      cursor_text_color       #EAE4CA
      url_color               #3A94C5
      active_border_color     #8DA101
      inactive_border_color   #B9C0AB
      bell_border_color       #F57D26
      active_tab_foreground   #5C6A72
      active_tab_background   #F3EAD3
      inactive_tab_foreground #939F91
      inactive_tab_background #E5DFC5
      tab_bar_background      #EAE4CA
      mark1_foreground        #F3EAD3
      mark1_background        #3A94C5
      mark2_foreground        #F3EAD3
      mark2_background        #D3C6AA
      mark3_foreground        #F3EAD3
      mark3_background        #DF69BA
      color0                  #708089
      color8                  #829181
      color1                  #F85552
      color9                  #E66868
      color2                  #8DA101
      color10                 #93B259
      color3                  #DFA000
      color11                 #DFA000
      color4                  #3A94C5
      color12                 #3A94C5
      color5                  #DF69BA
      color13                 #DF69BA
      color6                  #35A77C
      color14                 #35A77C
      color7                  #939F91
      color15                 #A6B0A0

      # Pass cmd+l (light/dark toggle) to nvim; elsewhere kitty keeps it, as unmapped it sends junk to the shell
      map --when-focus-on var:in_editor cmd+l
    '';
    settings = {
      # Fonts
      font_family = "JetBrainsMono Nerd Font"; # installed by fonts.nix
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
