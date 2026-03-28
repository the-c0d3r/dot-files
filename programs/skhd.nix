# programs/skhd.nix — Simple hotkey daemon (macOS only)

{ config, pkgs, lib, ... }:

{
  services.skhd = {
    enable = true;
    # configuration is handled by home-manager via files/skhd/skhdrc
  };
}
