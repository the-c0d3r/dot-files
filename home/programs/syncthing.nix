# programs/syncthing.nix — Syncthing file synchronization

{ config, pkgs, lib, ... }:

{
  # Syncthing runs as a user service (systemd on Linux, launchd on macOS)
  # Currently only enabled on Linux
  services.syncthing = {
    enable = pkgs.stdenv.hostPlatform.isLinux;
    settings = {
      devices = {
        "Thus-MacBook-Pro.local" = { id = "6DQWVMC-AUX6QMC-2EV6OWS-RU67KYA-BZCFJMD-O3BHL7H-CXPDRMF-H3BLSQB"; };
        "codelab-nas"            = { id = "HAHND7O-I7PP2PI-NOVCINC-BJHJHKA-EYGNI4E-AIC3AXI-H7ENVWL-LPLXZAK"; };
        "ZFold8"                 = { id = "J2MNING-IUXZX45-FGCWG72-SUZZKYQ-SEXFXTQ-RVIRATL-NFKMWTN-L2HWNAP"; };
      };
      folders = {
        "Documents" = {
          id = "pcibl-josuz";
          path = "${config.home.homeDirectory}/syncthing/Documents";
          devices = [ "codelab-nas" "ZFold8" "Thus-MacBook-Pro.local" ];
        };
        "shared" = {
          id = "jotgl-p9lwk";
          path = "${config.home.homeDirectory}/syncthing/shared";
          devices = [ "codelab-nas" "ZFold8" "Thus-MacBook-Pro.local" ];
        };
        "claude-config" = {
          id = "claude-config";
          path = "${config.home.homeDirectory}/.claude";
          devices = [ "codelab-nas" "Thus-MacBook-Pro.local" ];
        };
        "tools" = {
          id = "tools";
          path = "${config.home.homeDirectory}/syncthing/tools";
          devices = [ "codelab-nas" "ZFold8" "Thus-MacBook-Pro.local" ];
        };

      };
    };
  };
}
