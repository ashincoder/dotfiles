# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# path
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
fi

HISTFILE=$HOME/.local/share/history/bash_history

# Prompt
# PS1="\n\[\033[32m\]  \[\033[37m\]\[\033[34m\]\w \[\033[0m\]"
# PS2="\[\033[32m\]  > \[\033[0m\]"

# starship init
eval "$(starship init bash)"

# zoxide init
eval "$(zoxide init bash)"

## ALIASES ##

alias cat='bat'
alias open='xdg-open'
alias ls='exa --icons'
alias repo='cd ~/Repos/'
alias rsync='rsync -avh'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

## devour alias
alias zathura='devour zathura'
alias mpv='devour mpv'
alias nsxiv='devour nsxiv'

## Git Aliases ##
alias lg='lazygit'
