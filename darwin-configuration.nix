{ pkgs, username, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim
    pkgs.git
    pkgs.curl
  ];

  nixpkgs.config.allowUnfree = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Don't let nix-darwin manage Nix - use existing installation
  nix.enable = false;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  # macOS System Settings
  system = {
    stateVersion = "4";
    primaryUser = username;
    defaults = {
      dock = {
        autohide = true;
        orientation = "left";
        show-recents = false;
      };
      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
      };
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
      };
      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
      };
      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
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
