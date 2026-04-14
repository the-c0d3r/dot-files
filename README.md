# dot-files
My dot-files repository which uses **Nix** (via Home Manager and nix-darwin) for fully declarative and reproducible configuration across NixOS, macOS, and generic Linux distributions.

## Repository Structure

```
dot-files/
├── flake.nix              # Main flake defining all configurations
├── apply.sh               # Automatic installation script
├── Vagrantfile            # Rocky Linux 9 VM for testing server config
├── home/                  # Home-manager configurations
│   ├── default.nix        # Shared config for all platforms
│   ├── darwin.nix         # macOS-specific config
│   ├── linux.nix          # Linux-specific config
│   └── kali.nix           # Kali Linux pentesting additions
├── hosts/                 # System-level configurations
│   ├── darwin/            # macOS system settings (nix-darwin)
│   └── nixos/             # NixOS system configuration
├── programs/              # Program-specific configurations
│   ├── atuin.nix          # Shell history sync
│   ├── git.nix            # Git configuration
│   ├── i3.nix             # i3 window manager (Linux)
│   ├── kitty.nix          # Terminal emulator
│   ├── neovim.nix         # Neovim configuration
│   ├── obsidian.nix       # Note-taking app (runtime X11/Wayland detection)
│   ├── starship.nix       # Shell prompt
│   ├── syncthing.nix      # File synchronization (Linux only)
│   ├── tmux.nix           # Terminal multiplexer
│   ├── vicinae.nix        # App launcher + systemd service
│   ├── vscode.nix         # VSCodium with extensions
│   └── zsh.nix            # Shell configuration
├── fonts/                 # Shared font configuration
└── files/                 # Dotfiles and configuration files
```

# Installation

## The Quick Way
### Linux & macOS

Run the following command in your terminal to bootstrap your entire system:

```bash
curl -L https://raw.githubusercontent.com/the-c0d3r/dot-files/master/apply.sh | bash
```

Alternatively, if you've already cloned the repo:

```bash
./apply.sh                  # auto-detects OS and profile
./apply.sh --server         # server mode (CLI tools only, no GUI)
./apply.sh --vm             # build and launch NixOS QEMU test VM
```

> [!IMPORTANT]
> The script automatically generates `vars.nix` with your username before running with sudo. This file is gitignored but must be present for the configuration to build.

> [!NOTE]
> Supported platforms: x86_64 Linux, x86_64 macOS, Apple Silicon macOS. aarch64 Linux is not supported.

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

## Subsequent Updates
To apply any changes to your configuration later, simply run:

```bash
./apply.sh
```

> [!NOTE]
> `apply.sh` automatically detects your OS and distribution to apply the correct configuration (`#linux`, `#kali`, `#codelab-nix`, `#mac-arm`, etc.).

## Manual Build (Advanced)

For NixOS:
```bash
echo "{ username = \"yourusername\"; }" > vars.nix
git add -f vars.nix  # Required for flakes
sudo nixos-rebuild switch --flake .#codelab-nix
```

For generic Linux:
```bash
echo "{ username = \"yourusername\"; }" > vars.nix
git add -f vars.nix
home-manager switch --flake .#linux
```

For macOS:
```bash
echo "{ username = \"yourusername\"; }" > vars.nix
git add -f vars.nix
sudo darwin-rebuild switch --flake .#mac-arm
```

# Profiles

## `linux` - Standalone Linux (home-manager only)
- Terminal tools + desktop environment
- Vicinae app launcher, Syncthing, Zen Browser, Signal, TickTick
- Vagrant + VirtualBox
- Fonts (Nerd Fonts + CartographCF)
- Suitable for: Arch, Ubuntu, Fedora, etc.

## `server` - Headless Linux (home-manager only)
- CLI tools only: Neovim, Tmux, Zsh, Git, Atuin, Starship
- No GUI packages or desktop environment
- Suitable for layering on top of any existing Linux server

## `kali` - Kali Linux
- Builds on `linux` profile
- Adds pentesting tools: nmap, enum4linux, sqlmap, etc.
- Python environment for security scripts

## `codelab-nix` - NixOS
- Full NixOS system configuration (KDE Plasma 6, X11, NVIDIA)
- VirtualBox at system level (kernel modules via `virtualisation.virtualbox.host`)
- System-level services and settings
- Home-manager integrated

## `mac-arm` / `mac-intel` - macOS
- System settings (Dock, Finder, keyboard, trackpad)
- Yabai + skhd for tiling window management
- Homebrew integration
- Fonts at system level

> [!WARNING]
> Applying the macOS configuration **WILL** modify your system settings. This includes Dock arrangement, Finder preferences, keyboard remappings (Caps Lock -> Escape), and trackpad settings. Review [hosts/darwin/configuration.nix](hosts/darwin/configuration.nix) before applying.

# Testing

## NixOS VM (QEMU)
Build and launch a QEMU VM with your full NixOS config applied:
```bash
./apply.sh --vm
```
Login with your username, password: `test`

## Server Config (Vagrant + Rocky Linux 9)
Test the `--server` profile on a Rocky Linux VM:
```bash
vagrant up        # provision and apply --server
vagrant provision # re-run apply.sh after changes
vagrant ssh       # SSH in to test manually
```

# Programs & Configs

## Shared (All Platforms)
- **Neovim**: Customized vim configuration
- **Tmux**: Terminal multiplexer with custom keybindings
- **Zsh**: Shell with oh-my-zsh integration
- **Kitty**: GPU-accelerated terminal
- **Starship**: Cross-shell prompt
- **Atuin**: Shell history sync and search
- **Git**: Version control with custom config
- **VSCodium**: VS Code with vim extension and Claude Code integration
- **Obsidian**: Note-taking app
- **Ripgrep**, **FD**: Modern search tools
- **Htop**, **Ncdu**, **Jq**: System utilities
- **Discord**, **KeePassXC**: Desktop applications
- **Development Tools**: GCC, Make, CMake, pre-commit, uv (Python env manager), antigravity

## Linux Only
- **i3**: Tiling window manager
- **Polybar**: Status bar
- **Vicinae**: Application launcher with systemd daemon (rofi replacement)
- **Syncthing**: File synchronization service
- **Zen Browser**: Privacy-focused browser
- **Vagrant** + **VirtualBox**: Virtualisation (VirtualBox via kernel module on NixOS)
- **Fonts**: Nerd Fonts + CartographCF (via home-manager)

## macOS Only
- **Yabai**: Tiling window manager (system service)
- **Skhd**: Hotkey daemon (system service)
- **JankyBorders**: Window border highlights
- **Raycast**: Spotlight replacement
- **Itsycal**: Menubar calendar
- **Fonts**: Nerd Fonts + CartographCF (system-wide)
- **GNU Utils**: coreutils, gnutls, gnused, gnutar, gnugrep (replaces BSD variants)

## macOS System Settings
The following macOS defaults are declaratively managed via [hosts/darwin/configuration.nix](hosts/darwin/configuration.nix):

- **General**:
    - Dark Mode enabled
    - Metric units (Celsius, cm)
    - Fast key repeat rate (Initial: 15, Repeat: 2)
    - Auto-capitalization/correction/dashes/periods/quotes **DISABLED**
- **Dock**:
    - Auto-hide enabled
    - Positioned on the **Left**
    - Recent apps hidden
    - **Hot Corners**:
        - Top-Left: Mission Control
        - Bottom-Left: Lock Screen
        - Bottom-Right: Desktop
- **Finder**:
    - Show all file extensions
    - Show POSIX path in title bar
    - Default view style: List View
    - Folders sorted first
- **Trackpad**:
    - Tap to click enabled
    - Three-finger drag enabled
    - Two-finger right click enabled
- **Keyboard**:
    - Remap **Caps Lock** to **Escape**
- **Control Center**:
    - Battery percentage shown

## Fonts

All platforms include:
- JetBrains Mono Nerd Font
- Symbols Only Nerd Font
- Fira Code Nerd Font
- Inconsolata Nerd Font
- Iosevka Nerd Font
- Karla
- CartographCF (custom fonts from `files/fonts/`)

Fonts are installed:
- **Linux/NixOS**: via home-manager (`home.packages`)
- **macOS**: system-wide (`fonts.packages` in nix-darwin)
