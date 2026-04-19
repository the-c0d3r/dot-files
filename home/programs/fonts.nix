{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    nerd-fonts.fira-code
    nerd-fonts.inconsolata
    nerd-fonts.iosevka
    karla
  ];

  fonts.fontconfig.enable = true;
}
