setopt extendedglob local_options
autoload -Uz compinit
compinit -C -d

# Setting up Zini plugin manager
source "$HOME/.config/zsh/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Syntax highlighting and autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# Load theme
eval "$(starship init zsh)"

# Autopairs
zinit ice wait lucid id-as"auto"
zinit load hlissner/zsh-autopair

# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.

### EXPORT
export HISTCONTROL=ignoredups:erasedups           # no duplicate entries

# "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Lines configured by zsh-newuser-install
HISTFILE=$HOME/.local/share/history/zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Vi mode
bindkey -v

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Enable searching through history
bindkey '^R' history-incremental-pattern-search-backward

# Setting up path
if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.local/share/npm/bin" ] ;
  then PATH="$HOME/.local/share/npm/bin:$PATH"
fi

# Aliases
source "$ZDOTDIR/alias.zsh"
# Functions
source "$ZDOTDIR/functions.zsh"

# Loading zoxide dir jumper
eval "$(zoxide init zsh)"

