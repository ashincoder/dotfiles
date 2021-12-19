## ALIASES ##

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
alias sxiv='devour sxiv'

## LazyGit
alias lg='lazygit'

# Doom Emacs
alias em="/usr/bin/emacs -nw"
alias doomsync="~/.emacs.d/bin/doom sync"
alias doomdoctor="~/.emacs.d/bin/doom doctor"
alias doomupgrade="~/.emacs.d/bin/doom upgrade"
alias doompurge="~/.emacs.d/bin/doom purge"
alias doomhelp="~/.emacs.d/bin/doom help"

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist-arch"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist-arch"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist-arch"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist-arch"

