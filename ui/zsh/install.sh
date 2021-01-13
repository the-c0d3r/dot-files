#!/bin/bash

set -e
# installs oh-my-zsh plugin manager
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install syntax highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# install auto suggestion plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# install hacker quote
git clone https://github.com/oldratlee/hacker-quotes.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/hacker-quotes
# install zsh command architect
git clone https://github.com/psprint/zsh-cmd-architect.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-cmd-architect
# install alias-tips
git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
# install powerlevel 10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k


rm ~/.zshrc

# configure git to use the global git ignore file
git config --global core.excludesfile ~/.gitignore_global
