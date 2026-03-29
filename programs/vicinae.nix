# programs/vicinae.nix — Vicinae app launcher (rofi replacement)

{ config, pkgs, lib, ... }:

{
  home.packages = lib.mkIf pkgs.stdenv.isLinux [
    pkgs.vicinae
  ];

  # Autostart vicinae on Linux
  systemd.user.services.vicinae = lib.mkIf pkgs.stdenv.isLinux {
    Unit = {
      Description = "Vicinae app launcher";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.vicinae}/bin/vicinae";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
