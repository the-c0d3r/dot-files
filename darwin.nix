{ config, pkgs, username, system, ... }:

{
  imports = [ ./home.nix ];

  home.file = {
    ".config/karabiner/karabiner.json".source = ./files/karabiner/karabiner.json;
    ".config/yabai/scripts".source = ./files/yabai/scripts;
    ".config/skhd/skhdrc".source = ./files/skhd/skhdrc;
  };
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "23.11";

  home.sessionVariables = {
    # disables ._ files in tar file. https://superuser.com/a/260264/146350
    COPYFILE_DISABLE = "1";
  };

  home.packages = with pkgs; [
    # wm management
    jankyborders  # border management
    yabai         # window management
    skhd          # hotkey management

    # utils
    coreutils     # utils for bash
    gnutls        # ls utils
    gnused        # sed utils
    gnutar        # tar utils
    gnugrep       # grep utils
    iproute2mac   # utils for bash

    # gui apps
    raycast       # productivity app, spotlight alternative
    itsycal       # menubar mini calendar
    tailscale     # SDN software
    slack         # chat
  ];

  programs.zsh = {
    shellAliases = {
      # additional aliases for macOS
      hidedesktop = "defaults write com.apple.finder CreateDesktop false && killall Finder";
      unhidedesktop = "defaults write com.apple.finder CreateDesktop true && killall Finder";
    };
    initContent = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
