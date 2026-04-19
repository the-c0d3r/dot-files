# home/default.nix — Shared home-manager base for all platforms
#
# Sets up the user environment: username, paths, session variables.
# Imported by every platform entry point (linux.nix, darwin.nix, server.nix, kali.nix).
# Does not include packages or program configs — those live in home/programs/.

{ config, pkgs, lib, username, isNixOS ? false, ... }:

{
  home.username = username;
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else if username == "root" then "/root" else "/home/${username}";

  # Do not change this value — it pins home-manager behaviour, not the NixOS version.
  home.stateVersion = "23.11";

  # Only needed on non-NixOS Linux to enable desktop file symlinking, session
  # variable sourcing, etc. NixOS handles this natively via the HM module.
  targets.genericLinux.enable = pkgs.stdenv.isLinux && !isNixOS;

  home.sessionVariables = {
    # Editor & Terminal
    EDITOR = "nvim";
    TERM = "xterm-256color";
    HIST_STAMPS = "%d/%m/%y %T";

    # Locale
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  programs.home-manager.enable = true;
}
