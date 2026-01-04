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
    enable = true;
    # configuration is handled by home-manager
  };
  services.skhd = {
    enable = true;
    # configuration is handled by home-manager
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
