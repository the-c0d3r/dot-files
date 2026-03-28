# home/linux-common.nix — Shared config for all Linux environments (NixOS + generic)
#
# Imported by:
#   NixOS  → flake.nix (alongside home/default.nix)
#   Others → home/linux.nix imports this

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Linux utilities
    vicinae   # app launcher (rofi replacement)
    xclip     # clipboard tool
    ticktick  # task manager
    nload     # network monitor

    # Fonts (shared across all Linux systems)
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    nerd-fonts.fira-code
    nerd-fonts.inconsolata
    nerd-fonts.iosevka
    karla

    # Custom fonts from files/fonts directory (CartographCF + icomoon-feather)
    (pkgs.stdenvNoCC.mkDerivation {
      name = "custom-fonts";
      src = ../files/fonts;
      dontConfigure = true;
      dontBuild = true;
      installPhase = ''
        mkdir -p $out/share/fonts/opentype
        mkdir -p $out/share/fonts/truetype
        mkdir -p $out/share/fonts/pcf
        find $src -name "*.otf" -exec cp {} $out/share/fonts/opentype \;
        find $src -name "*.ttf" -exec cp {} $out/share/fonts/truetype \;
        find $src -name "*.pcf" -exec cp {} $out/share/fonts/pcf \;
      '';
    })
  ];

  # Enable fontconfig to ensure fonts are properly recognized
  fonts.fontconfig.enable = true;

  programs.zsh = {
    initContent = ''
      # Set keyboard key repeat speed (delay=300ms, rate=15 repeats/sec)
      [ -x "$(command -v xset)" ] && xset r rate 300 15
    '';
  };
}
