{ pkgs, username, ... }:

{
  imports = [
    ../../programs/yabai.nix
    ../../programs/skhd.nix
    ../../programs/jankyborders.nix
  ];

  nix = {
    settings.experimental-features = "nix-command flakes";
    enable = false; # Determinate manages Nix daemon
  };

  # Scheduled GC (weekly, Sunday 3am) - separate from nix module since Determinate manages Nix
  launchd.daemons.nix-gc = {
    serviceConfig = {
      ProgramArguments = [
        "/nix/var/nix/profiles/default/bin/nix-collect-garbage"
        "--delete-older-than" "30d"
      ];
      StartCalendarInterval = [{ Weekday = 0; Hour = 3; Minute = 0; }];
      StandardOutPath = "/var/log/nix-gc.log";
      StandardErrorPath = "/var/log/nix-gc.err";
    };
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
        expose-group-apps = true; # group windows by app in Mission Control
        minimize-to-application = true; # minimize into app icon
        mru-spaces = false; # don't reorder Spaces based on recent use

        wvous-tl-corner = 2; # top-left - Mission Control
        wvous-tr-corner = 1; # top-right - Disabled
        wvous-bl-corner = 13; # bottom-left - Lock Screen
        wvous-br-corner = 4; # bottom-right - Desktop
      };

      finder = {
        AppleShowAllExtensions = true;  # Shows file extensions
        AppleShowAllFiles = true;       # Show hidden files
        FXPreferredViewStyle = "Nlsv";  # List View default
        ShowStatusBar = true;           # Show status bar
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
        ApplePressAndHoldEnabled = false;             # Disable press-and-hold for accents (better for vim)
        AppleShowAllExtensions = true;                # Show file extensions globally
        InitialKeyRepeat = 25;                        # Initial key repeat delay
        KeyRepeat = 2;                                # Key repeat rate
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
