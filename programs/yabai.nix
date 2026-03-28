# programs/yabai.nix — Yabai tiling window manager (macOS only)

{ config, pkgs, lib, ... }:

{
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    extraConfig = ''
      sudo yabai --load-sa
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
      yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"
      yabai -m signal --add event=window_created action="sketchybar --trigger windows_on_spaces"
      yabai -m signal --add event=window_destroyed action="sketchybar --trigger windows_on_spaces"
      yabai -m config --space 1 layout bsp

      # laptop display to use stack to maximise space and for stackline
      yabai -m config --space 3 layout stack

      yabai -m rule --add app="^FortiClient$" sub-layer=above manage=off
      yabai -m rule --add app="^KeePassXC$" sub-layer=above manage=off
      yabai -m rule --add app="^System Preferences$" sub-layer=above manage=off
      yabai -m rule --add app="^Karabiner-Elements$" sub-layer=above manage=off
      yabai -m rule --add app="^Karabiner-EventViewer$" sub-layer=above manage=off
      yabai -m rule --add app="^Finder$" sub-layer=above manage=off
      yabai -m rule --add app="^Disk Utility$" sub-layer=above manage=off
      yabai -m rule --add app="^System Information$" sub-layer=above manage=off
      yabai -m rule --add app="^Activity Monitor$" sub-layer=above manage=off

      yabai -m rule --add app="^KeyCastr$" sub-layer=above manage=off
      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^Archive Utility$" manage=off
      yabai -m rule --add app="^Calculator$" sub-layer=above manage=off
      yabai -m rule --add app="^Hammerspoon" sub-layer=above manage=off
      yabai -m rule --add app="^Raycast" sub-layer=above manage=off
      yabai -m rule --add app="^superwhisper" sub-layer=above manage=off
      yabai -m rule --add app="^Music$" manage=off
      yabai -m rule --add app="^Docker" manage=off

      # External monitor (index 1): fullscreen targets
      yabai -m rule --add app="^Obsidian$" display=1 manage=on opacity=0.85
      yabai -m rule --add app="^Zen$" display=1 manage=on native-fullscreen=on
      yabai -m rule --add app="^kitty$" display=1 manage=on native-fullscreen=on
      yabai -m rule --add app="^VSCodium$" display=1 manage=on native-fullscreen=on

      # Laptop monitor (index 2)
      yabai -m rule --add app="^Slack$" display=2 manage=on opacity=0.95
    '';

    config = {
      external_bar                 = "off:40:0";
      menubar_opacity              = 0.7;
      mouse_follows_focus          = "off";
      focus_follows_mouse          = "autofocus";
      display_arrangement_order    = "default";
      window_origin_display        = "default";
      window_placement             = "second_child";
      window_zoom_persist          = "on";
      window_shadow                = "on";
      window_animation_duration    = 0;
      window_animation_easing      = "ease_out_circ";
      window_opacity_duration      = 0.0;
      active_window_opacity        = 0.9;
      normal_window_opacity        = 0.70;
      window_opacity               = "on";
      insert_feedback_color        = "0xffd75f5f";
      split_ratio                  = 0.50;
      split_type                   = "auto";
      auto_balance                 = "off";
      top_padding                  = 10;
      bottom_padding               = 5;
      left_padding                 = 10;
      right_padding                = 10;
      window_gap                   = 15;
      layout                       = "bsp";
      mouse_modifier               = "fn";
      mouse_action1                = "move";
      mouse_action2                = "resize";
      mouse_drop_action            = "swap";
    };
  };
}
