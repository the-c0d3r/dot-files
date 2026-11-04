# home/linux.nix — Linux desktop entry point (NixOS + generic Linux)
#
# Used by: homeConfigurations."linux", nixosConfigurations.*

{
  config,
  pkgs,
  lib,
  inputs,
  system,
  isNixOS ? false,
  ...
}:

{
  imports = [
    ./default.nix
    ./programs/desktop.nix
    ./programs/obsidian.nix
    ./programs/syncthing.nix
    ./programs/vicinae.nix
  ];

  home.packages =
    with pkgs;
    [
      # Linux utilities
      xclip # clipboard tool

      # Browser
      inputs.zen-browser.packages.${system}.default

      # virtualisation
      vagrant

      # development
      nodejs_24

      libreoffice # office
      vlc # media player
      ticktick # task manager
    ]
    ++ lib.optionals (!isNixOS) [
      # on NixOS, VirtualBox is provided by virtualisation.virtualbox.host in configuration.nix
      virtualbox
    ];
}
