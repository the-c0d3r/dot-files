# dot-files
My dot-files repository which uses dotbot to deploy the dots

# Usage
There are 2 ways to install the configurations. First way is to install with profiles. Profiles are under `/meta/profiles`, every program inside the profile file will be installed.

`./install-profile mac`

Second way is to use `install-standalone` scrip to install individually. You can look at what configs/programs are available to install under `/meta/configs`.

`./install-standalone zsh`


# Programs & configs

## Mac OS & Linux
- vim : actually neovim configs
    - Requires `python3`, `pip`, and `virtualenv` to be installed
- tmux : terminal multiplexer. Config from https://github.com/gpakosz/.tmux
- zsh : oh-my-zsh shell config (WARNING: this will remove your existing ~/.zshrc file)
- alacritty : fast terminal powered by GPU

## Linux
- i3 : tiling window manager
- rofi : spotlight app search thing for linux
- polybar : the menu bar replacement for tiling window managers
- termite : a terminal emulator, color configs
- dunst : simple, configurable notification daemon

## Mac OS
- chunkwm : tiling window manager for Mac
- skhd : keyboard hotkey daemon for chunkwm

# Profiles

## arch
- installs all the archlinux i3 setup.

## linux
- install only terminal apps like vim, zsh, tmux

## mac
- installs mac related tools like chunkwm, skhd

