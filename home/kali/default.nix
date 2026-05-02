# home/kali/default.nix — Kali Linux entry point
#
# CLI base + pentest tools, without the full Linux desktop stack.
# Applied via: homeConfigurations."kali" in flake.nix

{ ... }:

{
  programs.zsh.initContent = ''
    # Source nix on non-NixOS (needed for tmux and other non-login shells)
    if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
      source "$HOME/.nix-profile/etc/profile.d/nix.sh"
    fi
  '';

  imports = [
    ../default.nix
    ../programs/cli.nix
    ./tools.nix
  ];
}
