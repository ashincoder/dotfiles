## Xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export GOPATH="${XDG_DATA_HOME}/go"
export PLTUSERHOME="${XDG_DATA_HOME}/racket"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export HISTFILE="${XDG_DATA_HOME}/history"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
export SUDO_ASKPASS="$HOME/.local/bin/dm-pass"
export LESSHISTFILE="-"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# export TERMINFO="$XDG_DATA_HOME/terminfo"
# export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"

export PF_SEP=""
export PF_INFO="ascii title os kernel wm shell uptime pkgs memory palette"

export USERXSESSION="$XDG_CACHE_HOME/X11/xsession"
export USERXSESSIONRC="$XDG_CACHE_HOME/X11/xsessionrc"
export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--ansi
--color=fg:-1,bg:-1,border:#4B5164,hl:#d19a66
--color=fg+:#f7f7f7,bg+:#2c323d,hl+:#e5c07b
--color=info:#828997,prompt:#e06c75,pointer:#45cdff
--color=marker:#98c379,spinner:#e06c75,header:#98c379'

export LS_COLORS="${LS_COLORS}:su=30;41:ow=30;42:st=30;44:"

# Default Apps
export EDITOR="nvim"
export READER="zathura"
export VISUAL="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export VIDEO="mpv"
export IMAGE="sxiv"
export OPENER="xdg-open"
export PAGER="bat"

startx ~/.config/x11/xinitrc
