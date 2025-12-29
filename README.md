# dot-files
My dot-files repository which uses **Nix** (via Home Manager and nix-darwin) for fully declarative and reproducible configuration.

# Installation

## The Quick Way
To bootstrap a fresh system (Linux or macOS) with Nix and these dotfiles, run:
```bash
curl -sSL https://raw.githubusercontent.com/the-c0d3r/dot-files/master/bootstrap.sh | bash
```
This script will:
- Install Nix (if not present)
- Clone the repository
- Detect your OS (Linux/macOS) and Architecture
- Apply the correct configuration

## Manual Installation
If you prefer to install manually or need to debug:

### 1. Requirements
- **Nix**: [Install Nix](https://nixos.org/download.html) (Determinate Systems installer recommended).
- **Flakes**: Ensure `experimental-features = nix-command flakes` is in your `nix.conf`.

### 2. Apply Configuration

**macOS (Apple Silicon & Intel)**
```bash
# First run (bootstrapping)
nix run --impure nix-darwin -- switch --flake .

# Subsequent updates
darwin-rebuild switch --flake .
```

**Linux (Generic & Kali)**
```bash
# Generic Linux
nix run --impure ./nix#homeConfigurations.linux.activationPackage

# Kali Linux
nix run --impure ./nix#homeConfigurations.kali.activationPackage
```

> [!NOTE]
> Once installed, you can also use `home-manager switch --flake .` on Linux if you have `home-manager` in your path.

# Profiles defined in [`flake.nix`](nix/flake.nix)

- **linux**: Standard Linux setup with terminal tools + i3 window manager environment (i3, polybar, rofi).
- **kali**: Build on top of `linux` profile, adding Kali-specific configurations.
- **mac-arm / mac-intel**: macOS system settings (Dock, Finder, etc.) + terminal tools.

# Programs & Configs

## Shared (Mac & Linux)
- **Neovim**: Customized vim configuration.
- **Tmux**: Terminal multiplexer.
- **Zsh**: Shell config (replaces `oh-my-zsh` management) with Powerlevel10k.
- **Kitty**: GPU-accelerated terminal.
- **Starship**: Cross-shell prompt.
- **Atuin**: Shell history sync.
- **Ripgrep**, **FD**: Modern search tools.
- **Htop**, **Ncdu**, **Jq**: System utilities.

## Linux Only (Desktop)
- **i3**: Tiling window manager.
- **Polybar**: Status bar.
- **Rofi**: Application launcher.
- **Dunst**: Notification daemon.

## macOS Only
- **Nix-Darwin**: System configuration management.
- **Yabai**: Tiling window manager (service).
- **Skhd**: Hotkey daemon (service).
