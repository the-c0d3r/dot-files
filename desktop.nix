{ config, pkgs, inputs, ... }:

let
  customPkgs = import ./packages { inherit pkgs; };
in
{
  imports = [
    ./linux.nix
    ./programs/kitty.nix
    inputs.vicinae.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    # Dev / Build (Linux Desktop Only)
    # gcc          # C compiler
    # gnumake      # make utility
    # cmake        # cross-platform build system generator
    nmap         # network scanner

    # Multimedia
    pv           # pipe viewer
    syncthing    # continuous file synchronization
    
    # GUI Apps
    xclip        # Linux-specific clipboard tool
    discord      # chat
    keepassxc    # password manager
    vscodium     # code editor
    ticktick     # task manager
    vicinae      # raycast alternative for Linux
    
    customPkgs.obsidian  # Platform-aware Obsidian
    
    # AI tools (optional, from original home.nix)
    antigravity
  ];

  home.file = {
    ".local/share/fonts".source = ./files/fonts;
  };

  xdg.configFile."vicinae/settings.json".force = true;

  programs.zsh = {
    initContent = ''
      # Keyboard key repeat speed
      # xset r rate [delay] [rate]
      [ -x "$(command -v xset)" ] && xset r rate 300 15
    '';
  };

  services.vicinae = {
    package = pkgs.vicinae;
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
      environment = {
        USE_LAYER_SHELL = "1";
      };
    };
    settings = {
      close_on_focus_loss = true;
      consider_preedit = true;
      pop_to_root_on_close = true;
      favicon_service = "twenty";
      search_files_in_root = true;
      font = {
        normal = {
          size = 12;
          normal = "Cartograph CF Regular";
        };
      };
      theme = {
        light = {
          name = "vicinae-light";
          icon_theme = "default";
        };
        dark = {
          name = "vicinae-dark";
          icon_theme = "default";
        };
      };
      launcher_window = {
        opacity = 0.98;
      };
    };
    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      bluetooth
      nix
      power-profile
    ];
  };
}
