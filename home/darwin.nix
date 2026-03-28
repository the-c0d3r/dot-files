# home/darwin.nix — macOS-specific home-manager config
#
# Imports home/default.nix for the shared base, then adds macOS-specific
# packages, dotfiles, and shell config.
#
# Applied via: darwinConfigurations."mac-arm" / "mac-intel" in flake.nix

{ config, pkgs, username, system, ... }:

{
  imports = [ ./default.nix ];

  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "23.11";

  # macOS-specific dotfiles (WM, hotkeys, keyboard remapping)
  home.file = {
    ".config/karabiner/karabiner.json".source = ../files/karabiner/karabiner.json;
    ".config/yabai/scripts".source            = ../files/yabai/scripts;
    ".config/skhd/skhdrc".source              = ../files/skhd/skhdrc;
  };

  home.sessionVariables = {
    # Prevent tar from creating ._ metadata files on network/USB volumes
    # https://superuser.com/a/260264/146350
    COPYFILE_DISABLE = "1";
  };

  home.packages = with pkgs; [
    # Window management
    jankyborders      # window border highlights
    yabai             # tiling window manager
    skhd              # hotkey daemon

    # GNU utils (macOS ships BSD variants)
    coreutils         # gnu coreutils
    gnutls            # gnu tls
    gnused            # gnu sed
    gnutar            # gnu tar
    gnugrep           # gnu grep
    iproute2mac       # ip command shim

    # GUI apps
    raycast           # spotlight replacement
    itsycal           # menubar calendar
    tailscale         # SDN / VPN
    slack             # chat
    mos               # smooth scroll + reverse direction
  ];

  programs.zsh = {
    shellAliases = {
      hidedesktop   = "defaults write com.apple.finder CreateDesktop false && killall Finder";
      unhidedesktop = "defaults write com.apple.finder CreateDesktop true && killall Finder";
    };
    # Homebrew init moved to programs/zsh.nix (platform-specific)
  };
}
