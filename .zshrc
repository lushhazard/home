#pokeget random --hide-name
#fastfetch

export PATH="$PATH:/home/lush/scripts"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.config/zsh/custom

plugins=(git)

source $ZSH/oh-my-zsh.sh

export LANG=ja_JP.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

#bindkey -v
#export KEYTIMEOUT=1
#
fastfetch

eval "$(starship init zsh)"
