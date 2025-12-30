# dot-files
My dot-files repository which uses **Nix** (via Home Manager and nix-darwin) for fully declarative and reproducible configuration.

# Installation

## The Quick Way
### Linux & macOS

Run the following command in your terminal to bootstrap your entire system:

```bash
curl -L https://raw.githubusercontent.com/the-c0d3r/dot-files/master/apply.sh | bash
```

Alternatively, if you've already cloned the repo:

```bash
./apply.sh
```

## Uninstallation

To remove the configurations and symlinks created by these dotfiles:

```bash
./uninstall.sh
```

To see what would be removed without actually deleting anything:

```bash
./uninstall.sh --dry-run
```

> [!NOTE]
> This script cleans up the dotfiles configuration but does not uninstall Nix itself. Refer to the Nix documentation for full system uninstallation.

### 2. Subsequent Updates
To apply any changes to your configuration later, simply run:

```bash
./apply.sh
```

> [!NOTE]
> `apply.sh` automatically detects your OS and distribution to apply the correct fragments (`#linux`, `#kali`, `#mac-arm`, etc.).

# Profiles defined in [`flake.nix`](flake.nix)

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

# macOS Manual Commands

If you prefer to run home-manager and darwin-rebuild separately (darwin-rebuild requires `sudo`, while home-manager should NOT use `sudo`):

**Step 1: Apply User Configuration (Home Manager)** - no sudo
```bash
home-manager switch --flake ".#mac-arm"  # or .#mac-intel
```

**Step 2: Apply System Configuration (nix-darwin)** - requires sudo
```bash
sudo darwin-rebuild switch --flake ".#mac-arm"  # or .#mac-intel
```

> [!NOTE]
> - Always run home-manager WITHOUT sudo
> - First-time setup will automatically backup `/etc/bashrc` and `/etc/zshrc` to `.before-nix-darwin`
