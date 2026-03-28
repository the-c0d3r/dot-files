# programs/syncthing.nix — Syncthing file synchronization

{ config, pkgs, lib, ... }:

{
  # Syncthing runs as a user service (systemd on Linux, launchd on macOS)
  # Currently only enabled on Linux
  services.syncthing = {
    enable = pkgs.stdenv.isLinux;
    settings = {
      devices = {
        "Thus-MacBook-Pro.local" = { id = "6DQWVMC-AUX6QMC-2EV6OWS-RU67KYA-BZCFJMD-O3BHL7H-CXPDRMF-H3BLSQB"; };
        "codelab-nas"            = { id = "HAHND7O-I7PP2PI-NOVCINC-BJHJHKA-EYGNI4E-AIC3AXI-H7ENVWL-LPLXZAK"; };
        "Z Fold 6"               = { id = "66PF7CU-2XJTPGA-YPI2HPD-TLZH25H-NNI7C5V-JV37Y3X-OMLIXEJ-3AZRLAG"; };
      };
      folders = {
        "Documents" = {
          id = "pcibl-josuz";
          path = "${config.home.homeDirectory}/syncthing/Documents";
          devices = [ "codelab-nas" "Z Fold 6" "Thus-MacBook-Pro.local" ];
        };
        "shared" = {
          id = "jotgl-p9lwk";
          path = "${config.home.homeDirectory}/syncthing/shared";
          devices = [ "codelab-nas" "Z Fold 6" "Thus-MacBook-Pro.local" ];
        };
      };
    };
  };
}
