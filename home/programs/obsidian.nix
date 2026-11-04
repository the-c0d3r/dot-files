# programs/obsidian.nix — Obsidian installation with Linux GPU fixes
# macOS gets Obsidian as a Homebrew cask (hosts/darwin/configuration.nix) so it can self-update.

{ config, pkgs, lib, ... }:

{
  home.packages = lib.optionals pkgs.stdenv.hostPlatform.isLinux [
    # override with GPU sandbox fixes
    (pkgs.obsidian.overrideAttrs (oldAttrs: {
      installPhase = oldAttrs.installPhase + ''
        wrapProgram $out/bin/obsidian \
          --add-flags "--disable-gpu-sandbox" \
          --add-flags "--disable-software-rasterizer"
      '';
    }))
  ];
}
