#!/bin/bash

mkdir -p $HOME/programming/programs/

# Install a spotify dependency
if [ ! -d "$HOME/programming/programs/polybar-spotify" ]; then
    git clone https://github.com/Jvanrhijn/polybar-spotify ~/programming/programs/polybar-spotify
fi

