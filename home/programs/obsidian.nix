# programs/obsidian.nix — Obsidian installation with Linux GPU fixes

{ config, pkgs, lib, ... }:

{
  home.packages = [
    (if pkgs.stdenv.isLinux then
      # Linux: override with GPU sandbox fixes
      pkgs.obsidian.overrideAttrs (oldAttrs: {
        installPhase = oldAttrs.installPhase + ''
          wrapProgram $out/bin/obsidian \
            --add-flags "--disable-gpu-sandbox" \
            --add-flags "--disable-software-rasterizer"
        '';
      })
    else
      # macOS: use plain version
      pkgs.obsidian)
  ];
}
