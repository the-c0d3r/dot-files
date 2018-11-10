# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/zack/.oh-my-zsh"

# Themes = agnoster, abaykan
ZSH_THEME="agnoster"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="mm/dd/yyyy"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  colored-man-pages
)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $ZSH/oh-my-zsh.sh
source ~/.dotfiles/ui/zsh/.aliases
source ~/.dotfiles/ui/zsh/.functionsrc
source ~/.dotfiles/ui/zsh/.linuxrc
source ~/.dotfiles/ui/zsh/.dockerrc
source ~/.dotfiles/ui/zsh/.gitrc
source ~/.dotfiles/ui/zsh/.pythonrc
