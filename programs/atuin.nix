{ config, pkgs, lib, ... }:

{
  # Force creation of Atuin config, as it would automatically create it
  xdg.configFile."atuin/config.toml".force = lib.mkForce true;

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      enter_accept = true;
      keymap_mode = "auto";
    };
    flags = [ "--disable-up-arrow" ]; 
  };
}
