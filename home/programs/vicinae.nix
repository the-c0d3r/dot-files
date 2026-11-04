# programs/vicinae.nix — Vicinae app launcher (rofi replacement)
# Linux only, imported by home/linux.nix. Uses nixpkgs package + manual config file.

{ pkgs, ... }:

{
  home.packages = [
    pkgs.vicinae
  ];

  # Vicinae config file
  xdg.configFile."vicinae/config.toml".text = ''
    close_on_focus_loss = true
    consider_preedit = true
    pop_to_root_on_close = true
    favicon_service = "twenty"
    search_files_in_root = true
  '';

  # Autostart vicinae
  systemd.user.services.vicinae = {
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
