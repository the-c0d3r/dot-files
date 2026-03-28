# programs/vscode.nix — VSCodium with extensions and settings

{ config, pkgs, lib, ... }:

{
  # Install tinymist (Typst language server) system-wide
  home.packages = with pkgs; [
    tinymist
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim             # vim emulation plugin
        myriad-dreamin.tinymist   # typst plugin
      ];
      userSettings = {
        "workbench.colorTheme" = "Default Light Modern";
        "workbench.list.openMode" = "doubleClick";

        # claude code configs
        "claudeCode.preferredLocation" = "sidebar";
        "claudeCode.claudeProcessWrapper" = "${pkgs.claude-code}/bin/claude";

        # tinymist configs
        "tinymist.serverPath" = "${pkgs.tinymist}/bin/tinymist";

        "files.autoSave" = "afterDelay";
        "terminal.integrated.stickyScroll.enabled" = false;
        "editor.wordWrap" = "on";
        "editor.stickyScroll.enabled" = false;
      };
    };
  };
}
