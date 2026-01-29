{ config, pkgs, ... }:

let
  customPkgs = import ./packages { inherit pkgs; };
in
{
  imports = [
    ./linux.nix
    ./programs/kitty.nix
  ];

  home.packages = with pkgs; [
    # Dev / Build (Linux Desktop Only)
    gcc          # C compiler
    gnumake      # make utility
    cmake        # cross-platform build system generator
    nmap         # network scanner

    # Multimedia
    ffmpeg       # video processing
    pv           # pipe viewer
    syncthing    # continuous file synchronization
    
    # GUI Apps
    xclip        # Linux-specific clipboard tool
    discord      # chat
    keepassxc    # password manager
    vscodium     # code editor
    ticktick     # task manager
    
    customPkgs.obsidian  # Platform-aware Obsidian
    
    # AI tools (optional, from original home.nix)
    antigravity
  ];

  home.file = {
    ".local/share/fonts".source = ./files/fonts;
  };

  programs.zsh = {
    initContent = ''
      # Keyboard key repeat speed
      # xset r rate [delay] [rate]
      [ -x "$(command -v xset)" ] && xset r rate 300 15
    '';
  };
}
