#!/bin/bash

# The base path for the dotfile's vim directory
BASE_PATH=editor/vim

# Make config directory for Neovim's init.vim
mkdir -p ~/.config/nvim

# Install virtualenv to containerize dependencies
python3 -m pip install virtualenv
python3 -m virtualenv -p python2 ~/.config/nvim/.p2
python3 -m virtualenv -p python3 ~/.config/nvim/.p3

# Install pip modules for Neovim within the virtual environment created
source ~/.config/nvim/.p2/bin/activate
pip install neovim jedi psutil setproctitle yapf
deactivate

source ~/.config/nvim/.p3/bin/activate
pip install neovim jedi psutil setproctitle yapf
deactivate

# Install vim-plug plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Enter Neovim and install plugins using a temporary init.vim, which avoids warnings about missing colorschemes, functions, etc
sed '/call plug#end/q' $BASE_PATH/init.vim > $BASE_PATH/temp.vim
nvim -u $BASE_PATH/temp.vim -c ':PlugInstall' -c ':qall'
rm $BASE_PATH/temp.vim

