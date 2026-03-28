# programs/vscode.nix — VSCodium with extensions and settings

{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
      ];
      userSettings = {
        "workbench.colorTheme" = "Default Light Modern";
        "workbench.list.openMode" = "doubleClick";

        "claudeCode.preferredLocation" = "sidebar";
        "claudeCode.claudeProcessWrapper" = "${pkgs.claude-code}/bin/claude";

        "files.autoSave" = "afterDelay";
        "terminal.integrated.stickyScroll.enabled" = false;
        "editor.wordWrap" = "on";
        "editor.stickyScroll.enabled" = false;
      };
    };
  };
}
