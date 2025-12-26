# dot-files
My dot-files repository which uses dotbot to deploy the dots.

# Usage
### The Quick Way (Linux)
If you want to quickly bootstrap a fresh Linux system with Nix and these dotfiles, run:
```bash
curl -sSL https://raw.githubusercontent.com/the-c0d3r/dot-files/master/scripts/install-linux.sh | bash
```

### Nix (The Modern Way)
This repository also supports [Nix](https://nixos.org/) and [Home Manager](https://github.com/nix-community/home-manager) for fully declarative and reproducible dotfiles.

### 1. Requirements
#### Install Nix
The recommended way to install Nix is via the [Determinate Systems Nix Installer](https://github.com/DeterminateSystems/nix-installer):
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

#### Install Home Manager
Once Nix is installed, install Home Manager standalone:
```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

### 2. Activation
Run the following command from the root folder depending on your platform:

**Linux (Generic)**:
```bash
home-manager switch --flake ./nix#linux --impure
```

**Kali Linux**:
```bash
home-manager switch --flake ./nix#kali --impure
```

**macOS (Apple Silicon)**:
```bash
home-manager switch --flake ./nix#mac-arm --impure
```

**macOS (Intel)**:
```bash
home-manager switch --flake ./nix#mac-intel --impure
```

> [!TIP]
> Use the `--impure` flag to automatically detect your current username from the environment.

> [!NOTE]
> If you don't have `home-manager` installed, you can build the activation package and run it manually:
> `nix build ./nix#homeConfigurations.linux.activationPackage --impure && ./result/activate`
`

# OS installers

```
curl -L https://raw.githubusercontent.com/the-c0d3r/dot-files/master/scripts/install-centos.sh | bash
```


# Programs & configs

## Mac OS & Linux
- neovim : vim but better
- tmux : terminal multiplexer. Config from https://github.com/gpakosz/.tmux and customised
- zsh : oh-my-zsh shell config (WARNING: this will remove your existing ~/.zshrc file) with powerlevel10k configuration.
- kitty: fast terminal powered by CPU
- starship : fast cross shell prompt

## Linux
- i3 : tiling window manager
- rofi : spotlight app search thing for linux
- polybar : the menu bar replacement for tiling window managers
- dunst : simple, configurable notification daemon

## Mac OS
- karabiner : key remapping program

# Profiles

## arch
- install all the archlinux i3 setup

## linux
- install only terminal apps like vim, zsh, tmux

## mac
- install linux tools + mac related tools

