{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  # Enable generic Linux target to allow symlinking desktop files
  # This is crucial for non-NixOS Linux distributions
  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    # Server-specific packages can go here
  ];
}
