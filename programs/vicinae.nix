# programs/vicinae.nix — Vicinae app launcher (rofi replacement)
# Self-contained config using nixpkgs package + manual config file

{ config, pkgs, lib, ... }:

{
  home.packages = lib.mkIf pkgs.stdenv.isLinux [
    pkgs.vicinae
  ];

  # Vicinae config file
  xdg.configFile."vicinae/config.toml" = lib.mkIf pkgs.stdenv.isLinux {
    text = ''
      close_on_focus_loss = true
      consider_preedit = true
      pop_to_root_on_close = true
      favicon_service = "twenty"
      search_files_in_root = true
    '';
  };

  # Autostart vicinae on Linux
  systemd.user.services.vicinae = lib.mkIf pkgs.stdenv.isLinux {
    Unit = {
      Description = "Vicinae app launcher";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.vicinae}/bin/vicinae";
      Environment = [ "USE_LAYER_SHELL=1" ];
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
