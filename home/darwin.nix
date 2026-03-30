# home/darwin.nix — macOS-specific home-manager config
#
# Imports home/default.nix for the shared base, then adds macOS-specific
# packages, dotfiles, and shell config.
#
# Applied via: darwinConfigurations."mac-arm" / "mac-intel" in flake.nix

{ config, pkgs, username, system, ... }:

{
  imports = [ ./default.nix ];

  # macOS-specific dotfiles (WM, hotkeys, keyboard remapping)
  home.file = {
    ".config/karabiner/karabiner.json".source = ../files/karabiner/karabiner.json;
    ".config/yabai/scripts".source            = ../files/yabai/scripts;
  };

  home.sessionVariables = {
    # Prevent tar from creating ._ metadata files on network/USB volumes
    # https://superuser.com/a/260264/146350
    COPYFILE_DISABLE = "1";
  };

  home.packages = with pkgs; [
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
    shortcat          # shortcut everything
  ];
}
