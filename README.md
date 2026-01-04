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

> [!WARNING]
> Applying the macOS configuration **WILL** modify your system settings. This includes Dock arrangement, Finder preferences, keyboard remappings (Caps Lock -> Escape), and trackpad settings. Review `darwin-configuration.nix` before applying if you are unsure.

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

### Managed System Settings
The following macOS defaults are declaratively managed via `darwin-configuration.nix`:

- **General**:
    - Dark Mode enabled.
    - Metric units (Celsius, cm).
    - Fast key repeat rate (Initial: 15, Repeat: 2).
    - Auto-capitalization/correction/dashes/periods/quotes **DISABLED**.
- **Dock**:
    - Auto-hide enabled.
    - Positioned on the **Left**.
    - Recent apps hidden.
    - Static-only (shows only running apps).
    - **Hot Corners**:
        - Top-Left: Mission Control.
        - Bottom-Left: Lock Screen.
        - Bottom-Right: Desktop.
- **Finder**:
    - Show all file extensions.
    - Show POSIX path in title bar.
    - Default view style: List View (`Nlsv`).
    - Folders sorted first.
- **Trackpad**:
    - Tap to click enabled.
    - Three-finger drag enabled.
    - Two-finger right click enabled.
- **Keyboard**:
    - Remap **Caps Lock** to **Escape**.
- **Control Center**:
    - Battery percentage shown.
