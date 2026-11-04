# programs/vscode.nix — VSCodium with extensions and settings

{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Install tinymist (Typst language server) system-wide
  home.packages = with pkgs; [
    tinymist
  ];

  programs.vscodium = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions =
        with pkgs.vscode-extensions;
        [
          vscodevim.vim # vim emulation plugin
          myriad-dreamin.tinymist # typst plugin
          jnoortheen.nix-ide # nix language support
          ms-python.python # python
          ms-python.debugpy # python debugger
          redhat.vscode-yaml # yaml
          tamasfe.even-better-toml # toml
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            # rpm spec syntax, not in nixpkgs
            publisher = "laurenttreguier";
            name = "rpm-spec";
            version = "0.3.2";
            hash = "sha256-akDVmN+nL70wVx4u3wVAUwkkoP+r2uPaPq8MsmL5bBY=";
          }
          {
            # everforest theme, matching kitty and nvim
            # theme files are read-only in the store, so its contrast settings can't apply
            publisher = "sainnhe";
            name = "everforest";
            version = "0.3.0";
            hash = "sha256-nZirzVvM160ZTpBLTimL2X35sIGy5j2LQOok7a2Yc7U=";
          }
        ];
      userSettings = {
        "workbench.colorTheme" = "Everforest Light"; # fallback before OS theme is detected
        "window.autoDetectColorScheme" = true; # follow macOS light/dark appearance
        "workbench.preferredDarkColorTheme" = "Everforest Dark";
        "workbench.preferredLightColorTheme" = "Everforest Light";
        "workbench.list.openMode" = "doubleClick";
        "workbench.startupEditor" = "none"; # skip welcome tab on launch

        # claude code configs
        "claudeCode.preferredLocation" = "sidebar";
        # no claudeCode.claudeProcessWrapper: pinning the Nix CLI breaks the extension's
        # auth check once the manually updated extension gets ahead of it (2026-11)
        "claudeCode.mcpServers" = {
          "nixos" = {
            "command" = "uvx";
            "args" = [ "mcp-nixos" ];
          };
        };

        # tinymist configs
        "tinymist.serverPath" = "${pkgs.tinymist}/bin/tinymist";
        "tinymist.formatterMode" = "typstfmt"; # use typstfmt for formatting
        "tinymist.preview.scrollSync" = "onSelectionChange"; # sync preview to cursor
        "tinymist.preview.invertColors" = "auto"; # preview follows system/browser dark mode

        # typst word boundaries: excludes - and _ so identifiers select as whole words
        "[typst]"."editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";
        "[typst-code]"."editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";

        "files.autoSave" = "afterDelay";
        "terminal.integrated.stickyScroll.enabled" = false;
        "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
        "editor.wordWrap" = "on";
        "editor.stickyScroll.enabled" = false;
        "editor.fontFamily" = "SFMono Nerd Font";
        "editor.fontSize" = 13;
        "editor.minimap.autohide" = "mouseover"; # hide minimap until hovered
        "editor.accessibilitySupport" = "off";
        "explorer.confirmDragAndDrop" = false; # no confirmation on drag-drop

        "diffEditor.ignoreTrimWhitespace" = false; # show whitespace diffs

        "vim.useSystemClipboard" = true; # vim to copy to system clipboard
      };
    };
  };
}
