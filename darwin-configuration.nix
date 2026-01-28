{ pkgs, username, ... }:

{
  environment.systemPackages = [
    pkgs.vim
    pkgs.git
    pkgs.curl
  ];

  nix = {
    # Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";
    # Don't let nix-darwin manage Nix - use existing installation
    enable = false;
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  # macOS System Settings
  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    stateVersion = "4";
    primaryUser = username;

    defaults = {
      controlcenter.BatteryShowPercentage = true;

      dock = {
        autohide = true;
        orientation = "left";
        show-recents = false; # don't show recent apps
        static-only = false; # show only running apps

        wvous-tl-corner = 2; # top-left - Mission Control
        wvous-tr-corner = 1; # top-right - Disabled
        wvous-bl-corner = 13; # bottom-left - Lock Screen
        wvous-br-corner = 4; # bottom-right - Desktop
      };

      finder = {
        AppleShowAllExtensions = true;  # Shows file extensions
        FXPreferredViewStyle = "Nlsv";  # List View default
        _FXShowPosixPathInTitle = true; # Shows path in title
        _FXSortFoldersFirst = true;     # Sort folders first
      };

      menuExtraClock = {
        ShowAMPM = false;
        ShowDate = 2; # Never
        ShowSeconds = true;
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";                 # Dark mode
        InitialKeyRepeat = 15;                        # Key repeat rate
        KeyRepeat = 2;                                # Key repeat delay
        AppleMeasurementUnits = "Centimeters";        # Metric units
        AppleMetricUnits = 1;
        AppleTemperatureUnit = "Celsius";             # Metric temperature
        NSAutomaticCapitalizationEnabled = false;     # Disable autocapitalization
        NSAutomaticDashSubstitutionEnabled = false;   # Disable autodashes
        NSAutomaticPeriodSubstitutionEnabled = false; # Disable autoperiods
        NSAutomaticQuoteSubstitutionEnabled = false;  # Disable autoquotes
        NSAutomaticSpellingCorrectionEnabled = false; # Disable spellchecking
      };

      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;  # Avoid creating .DS_Store files on network volumes
          DSDontWriteUSBStores = true;      # Avoid creating .DS_Store files on USB volumes
        };
      };

      trackpad = {
        Clicking = true;                   # Clicking enabled
        TrackpadThreeFingerDrag = true;    # Three-finger drag enabled
        TrackpadRightClick = true;         # enable two finger right click
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;       # Remap Caps Lock to Escape
    };
  };

  # Services
  services.yabai = {
    # configuration is handled by home-manager
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

      yabai -m rule --add app="^FortiClient$" manage=off sub-layer=above
      yabai -m rule --add app="^System Preferences$" sub-layer=above manage=off
      yabai -m rule --add app="^Karabiner-Elements$" sub-layer=above manage=off
      yabai -m rule --add app="^Karabiner-EventViewer$" sub-layer=above manage=off
      yabai -m rule --add app="^Finder$" sub-layer=above manage=off
      yabai -m rule --add app="^Disk Utility$" sub-layer=above manage=off
      yabai -m rule --add app="^System Information$" sub-layer=above manage=off
      yabai -m rule --add app="^Activity Monitor$" manage=off sub-layer=above
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

      # yabai -m signal --add event=window_focused app="^Obsidian$" action="yabai -m config normal_window_opacity 0.60"
      # When any other app gains focus, reset both active and background window opacity to fully visible
      # yabai -m signal --add event=window_focused app!="^Obsidian" action="yabai -m config active_window_opacity 1.0"
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

  services.skhd = {
    enable = true;
    # configuration is handled by home-manager
  };

  services.jankyborders = {
    enable = true;
    active_color = "0xffe1e3e4";
    inactive_color = "0xff494d64";
    width = 5.0;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    nerd-fonts.fira-code
    nerd-fonts.inconsolata
    nerd-fonts.iosevka
    karla
    (stdenvNoCC.mkDerivation {
      name = "custom-fonts";
      src = ./files/fonts;
      dontConfigure = true;
      dontBuild = true;
      installPhase = ''
        mkdir -p $out/share/fonts/opentype
        mkdir -p $out/share/fonts/truetype
        mkdir -p $out/share/fonts/pcf
        find $src -name "*.otf" -exec cp {} $out/share/fonts/opentype \;
        find $src -name "*.ttf" -exec cp {} $out/share/fonts/truetype \;
        find $src -name "*.pcf" -exec cp {} $out/share/fonts/pcf \;
      '';
    })
  ];
}
