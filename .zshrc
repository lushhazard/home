#pokeget random --hide-name
#fastfetch
#
n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}

# aliases
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias zshalias='v ~/.config/zsh/custom/aliases.zsh'
alias pmain='poetry run python main.py'
alias ytdl='yt-dlp'
alias n='n -deA'

alias wine="LANG=EN wine"

alias h='hyprland'

#eza
alias e="eza -l --time-style '+%Y年%m月%d日 %H:%M'"
alias eg="eza -l --git --git-repos --time-style '+%Y年%m月%d日 %H:%M'"
alias ez='eza'

export PATH="$PATH:/home/lush/scripts"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="fishy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.config/zsh/custom

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
#fastfetch

#eval "$(starship init zsh)"
