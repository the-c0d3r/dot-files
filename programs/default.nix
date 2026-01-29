{ config, pkgs, lib, ... }:

{
  imports = [
    ./cli.nix
    ./kitty.nix
  ];
}
