#!/bin/bash

set -e
rm -rf ~/.zshrc || true
rm -rf ~/.oh-my-zsh

# installs oh-my-zsh plugin manager
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install syntax highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# install auto suggestion plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# install hacker quote
git clone https://github.com/oldratlee/hacker-quotes.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/hacker-quotes
# install powerlevel 10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
# install fzf plugin
git clone https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin

rm ~/.zshrc

# configure git to use the global git ignore file
git config --global core.excludesfile ~/.gitignore_global
