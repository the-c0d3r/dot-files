# programs/neovim.nix — Neovim text editor

{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.neovim
  ];

  home.file.".config/nvim".source = ../../files/nvim;
}
