#!/bin/bash

mkdir -p ~/programming/programs/

# Install a spotify dependency
if [ ! -d "~/programming/programs/polybar-spotify" ]; then
    git clone https://github.com/Jvanrhijn/polybar-spotify ~/programming/programs/polybar-spotify
fi

