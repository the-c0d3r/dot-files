# programs/obsidian.nix — Obsidian with Linux GPU fixes (Linux only, imported by home/linux.nix)
# macOS gets Obsidian as a Homebrew cask (hosts/darwin/configuration.nix) so it can self-update.

{ pkgs, ... }:

{
  home.packages = [
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
