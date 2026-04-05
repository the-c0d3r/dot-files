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
        "workbench.startupEditor" = "none";           # skip welcome tab on launch

        # claude code configs
        "claudeCode.preferredLocation" = "sidebar";
        "claudeCode.claudeProcessWrapper" = "${pkgs.claude-code}/bin/claude";

        # tinymist configs
        "tinymist.serverPath" = "${pkgs.tinymist}/bin/tinymist";
        "tinymist.formatterMode" = "typstfmt";        # use typstfmt for formatting
        "tinymist.preview.scrollSync" = "onSelectionChange"; # sync preview to cursor

        # typst word boundaries: excludes - and _ so identifiers select as whole words
        "[typst]"."editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";
        "[typst-code]"."editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";

        "files.autoSave" = "afterDelay";
        "terminal.integrated.stickyScroll.enabled" = false;
        "editor.wordWrap" = "on";
        "editor.stickyScroll.enabled" = false;
        "editor.fontSize" = 13;
        "editor.minimap.autohide" = "mouseover";      # hide minimap until hovered

        "diffEditor.ignoreTrimWhitespace" = false;    # show whitespace diffs
        "explorer.confirmDragAndDrop" = false;        # no confirmation on drag-drop
      };
    };
  };
}
