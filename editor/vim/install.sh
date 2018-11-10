#!/bin/bash

# Make config directory for Neovim's init.vim
echo '[*] Preparing Neovim config directory ...' &&\
mkdir -p ~/.config/nvim &&\

# Install virtualenv to containerize dependencies
echo '[*] Pip installing virtualenv to containerize Neovim dependencies (instead of installing them onto your system) ...' &&\
python3 -m pip install virtualenv &&\
python3 -m virtualenv -p python3 ~/.config/nvim/env &&\

# Install pip modules for Neovim within the virtual environment created
echo '[*] Activating virtualenv and pip installing Neovim (for Python plugin support), libraries for async autocompletion support (jedi, psutil, setproctitle), and library for pep8-style formatting (yapf) ...' &&\
source ~/.config/nvim/env/bin/activate &&\
pip install neovim jedi psutil setproctitle yapf &&\
deactivate &&\

# Install vim-plug plugin manager
echo '[*] Downloading vim-plug, the best minimalistic vim plugin manager ...' &&\
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&\

# (Optional but recommended) Install a nerd font for icons and a beautiful airline bar (https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts) (I'll be using Roboto Mono for Powerline)
echo "[*] Downloading patch font into ~/.local/share/fonts ..." &&\
curl -fLo ~/.local/share/fonts/Roboto\ Mono\ Nerd\ Font\ Complete.ttf --create-dirs https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf &&\

# Enter Neovim and install plugins using a temporary init.vim, which avoids warnings about missing colorschemes, functions, etc
echo -e '[*] Running :PlugInstall within nvim ...' &&\
sed '/call plug#end/q' init.vim > ~/.config/nvim/init.vim &&\
nvim -c ':PlugInstall' -c ':qall' &&\
rm ~/.config/nvim/init.vim &&\

echo -e '[*] Neovim setup have been completed'
