# programs/obsidian.nix — Obsidian installation with Linux Wayland/GPU fixes

{ config, pkgs, lib, ... }:

{
  home.packages = [
    (if pkgs.stdenv.isLinux then
      # Linux: override with Wayland and GPU sandbox fixes
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
      # macOS: use plain version
      pkgs.obsidian)
  ];
}
