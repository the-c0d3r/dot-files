#!/bin/bash

set -Eeuo pipefail

# configure the repos to be online
find /etc/yum.repos.d -name '*.repo' -type f -exec sed -i "s@#baseurl=http://mirror.@baseurl=http://vault.@g" {} \;

sudo yum install -y epel-release
sudo yum install -y nload ncdu tmux python38 zsh git wget libarchive npm
sudo yum install -y gcc gcc-c++ make cmake

# compile and install neovim 0.9
git clone https://github.com/neovim/neovim
cd neovim || exit
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo -j 20
make install

# install pyenv
curl https://pyenv.run | bash


cd ~
git clone https://github.com/the-c0d3r/dot-files
cd dot-files
./install-profile linux

chsh -s /bin/zsh
