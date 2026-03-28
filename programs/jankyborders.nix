# programs/jankyborders.nix — Window border highlights (macOS only)

{ config, pkgs, lib, ... }:

{
  services.jankyborders = {
    enable = true;
    active_color = "glow(0xffe1e3e4)";
    inactive_color = "0xff494d64";
    width = 5.0;
  };
}
