# fonts/default.nix — Shared font packages for all platforms
#
# Returns a list of font packages including nerd fonts and custom fonts.
# Used by:
#   - home/linux-common.nix (via home.packages)
#   - hosts/darwin/configuration.nix (via fonts.packages)

{ pkgs }:

with pkgs; [
  # Nerd fonts
  nerd-fonts.jetbrains-mono
  nerd-fonts.symbols-only
  nerd-fonts.fira-code
  nerd-fonts.inconsolata
  nerd-fonts.iosevka
  karla

  # Custom fonts from files/fonts directory (CartographCF + icomoon-feather)
  (stdenvNoCC.mkDerivation {
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
]
