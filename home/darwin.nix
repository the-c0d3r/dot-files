# home/darwin.nix — macOS-specific home-manager config
#
# Imports home/default.nix for the shared base, then adds macOS-specific
# packages, dotfiles, and shell config.
#
# Applied via: darwinConfigurations."mac-arm" / "mac-intel" in flake.nix

{ config, pkgs, username, system, ... }:

let
  cycleLayouts = pkgs.writeShellScript "cycle_layouts" ''
    current_layout=$(yabai -m query --spaces --space | jq -r '.type')
    case "$current_layout" in
      bsp)   next_layout="stack" ;;
      stack) next_layout="float" ;;
      float) next_layout="bsp"   ;;
      *)     next_layout="bsp"   ;;
    esac
    hs -c "hs.alert.show('Yabai Layout: $next_layout')"
    yabai -m space --layout "$next_layout"
  '';

in
{
  imports = [ ./default.nix ./programs/desktop.nix ];

  home.file = {
    ".config/karabiner/karabiner.json".source        = ../files/karabiner/karabiner.json;
    ".config/yabai/scripts/cycle_layouts.sh".source = cycleLayouts;
  };

  home.sessionVariables = {
    # Prevent tar from creating ._ metadata files on network/USB volumes
    # https://superuser.com/a/260264/146350
    COPYFILE_DISABLE = "1";
  };

  home.packages = with pkgs; [
    # GNU utils (macOS ships BSD variants)
    coreutils          # gnu coreutils
    gnused             # gnu sed
    gnutar             # gnu tar
    gnugrep            # gnu grep
    iproute2mac        # ip command shim

    # GUI apps
    raycast            # spotlight replacement
    itsycal            # menubar calendar
    tailscale          # SDN / VPN
    slack              # chat
    mos                # smooth scroll + reverse direction
    shortcat           # shortcut everything
    karabiner-elements # keyboard shortcut editor
  ];
}
