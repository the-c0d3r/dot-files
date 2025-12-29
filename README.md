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

## Installation

### 1. First Run (Bootstrapping)
For any fresh system (Linux, Kali, or macOS), run this to install Nix and bootstrap your dotfiles:

```bash
./bootstrap.sh
```

### 2. Subsequent Updates
To apply any changes to your configuration later, simply run:

```bash
./apply.sh
```

> [!NOTE]
> `apply.sh` automatically detects your OS and distribution to apply the correct fragments (`#linux`, `#kali`, `#mac-arm`, etc.).

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
