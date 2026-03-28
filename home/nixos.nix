{ config, pkgs, username, system, isNixOS, ... }:

{
  imports = [ ./default.nix ];

  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    # NixOS/KDE-specific packages
    kdePackages.kate
    xclip
  ];

  # VSCodium with extensions + settings
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
      ];
      userSettings = {
        "workbench.colorTheme" = "Default Light Modern";
        "claudeCode.preferredLocation" = "panel";
        "workbench.list.openMode" = "doubleClick";
        "claudeCode.claudeProcessWrapper" = "/run/current-system/sw/bin/claude";
      };
    };
  };
}
