{ config, pkgs, username, system, ... }:

{
  imports = [ ./home.nix ];

  home.file = {
    # "Library/Fonts" = {
    #   source = ./files/fonts;
    #   recursive = true;
    # };
    ".config/karabiner/karabiner.json".source = ./files/karabiner/karabiner.json;
    ".config/yabai/yabairc".source = ./files/yabai/yabairc;
    ".config/yabai/scripts".source = ./files/yabai/scripts;
    ".config/skhd/skhdrc".source = ./files/skhd/skhdrc;
  };
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "23.11";

  home.sessionVariables = {
    # disables ._ files in tar file. https://superuser.com/a/260264/146350
    COPYFILE_DISABLE = "1";
  };

  home.packages = with pkgs; [
    # Yabai and skhd are usually better managed via nix-darwin services
    # but we can add them here as packages if needed.
    yabai
    skhd
    coreutils
    gnutls
    gnused
    gnutar
    gnugrep
    # Adding tools that was in Brewfile but are more Mac-centric in this context
    iproute2mac

    # gui apps
    raycast    # productivity app, spotlight alternative
    itsycal    # menubar mini calendar
    tailscale  # SDN software
    slack      # chat
  ];

  programs.zsh = {
    shellAliases = {
      # additional aliases for macOS
      hidedesktop = "defaults write com.apple.finder CreateDesktop false && killall Finder";
      unhidedesktop = "defaults write com.apple.finder CreateDesktop true && killall Finder";

    };
    initContent = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
