#!/bin/bash

# installs oh-my-zsh plugin manager
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install syntax highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# install auto suggestion plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# install autojump program
git clone https://github.com/wting/autojump /tmp
cd /tmp/autojump
python install.py
cd -
rm -rf /tmp/autojump

rm ~/.zshrc

