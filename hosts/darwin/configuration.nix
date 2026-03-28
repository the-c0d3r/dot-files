{ pkgs, username, ... }:

{
  imports = [
    ../../programs/yabai.nix
    ../../programs/skhd.nix
    ../../programs/jankyborders.nix
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
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
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

  fonts.packages = import ../../fonts { inherit pkgs; };
}
