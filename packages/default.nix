{ pkgs }:

{
  obsidian = if pkgs.stdenv.isLinux then
    pkgs.obsidian.overrideAttrs (oldAttrs: {
      installPhase = oldAttrs.installPhase + ''
        wrapProgram $out/bin/obsidian \
          --add-flags "--disable-gpu-sandbox" \
          --add-flags "--disable-software-rasterizer" \
          --add-flags "--enable-features=UseOzonePlatform" \
          --add-flags "--ozone-platform=wayland" \
          --add-flags "--enable-wayland-ime"
      '';
    })
  else
    pkgs.obsidian;  # macOS uses plain version
}
