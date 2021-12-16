#
# ~/.bash_profile
#
[ -f /usr/share/bash-completion/bash-completion ] && . /usr/share/bash-completion/bash_completion

[[ -f ~/.bashrc ]] && . ~/.bashrc

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export PKG_CONFIG_PATH=/usr/share/pkgconfig
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export DBUS_SESSION_BUSS_ADDRESS=/tmp/
export HISTFILE="${XDG_DATA_HOME}/history/bash_history"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export LESSHISTFILE="-"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export SUDO_ASKPASS="$HOME/.local/bin/dm-pass"
# export TERMINFO="$XDG_DATA_HOME/terminfo"
# export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
export PF_SEP=""
export PF_INFO="ascii title os kernel wm shell uptime pkgs memory palette"

export USERXSESSION="$XDG_CACHE_HOME/X11/xsession"
export USERXSESSIONRC="$XDG_CACHE_HOME/X11/xsessionrc"
export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f'
export PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"
export READER="zathura"
export VIDEO="mpv"
export TERMINAL="st"
export BROWSER="brave"
export PAGER="bat"

if [ -e /home/ashin/.nix-profile/etc/profile.d/nix.sh ]; then
	. /home/ashin/.nix-profile/etc/profile.d/nix.sh
fi
