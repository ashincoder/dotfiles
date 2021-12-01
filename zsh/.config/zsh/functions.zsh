# Custom FZF Commands
ndot() { du -a ~/.config/nvim/ | awk '{print $2}' | fzf | xargs -r $EDITOR; }
zdot() { du -a ~/.config/zsh/ | awk '{print $2}' | fzf | xargs -r $EDITOR; }
edot() { du -a ~/.config/doom/ | awk '{print $2}' | fzf | xargs -r $EDITOR; }

### Function extract for common file formats ###
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function extract {
	if [ -z "$1" ]; then
		# display usage if no parameters given
		echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
		echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
	else
		for n in "$@"; do
			if [ -f "$n" ]; then
				case "${n%,}" in
				*.cbt | *.tar.bz2 | *.tar.gz | *.tar.xz | *.tbz2 | *.tgz | *.txz | *.tar)
					tar xvf "$n"
					;;
				*.lzma) unlzma ./"$n" ;;
				*.bz2) bunzip2 ./"$n" ;;
				*.cbr | *.rar) unrar x -ad ./"$n" ;;
				*.gz) gunzip ./"$n" ;;
				*.cbz | *.epub | *.zip) unzip ./"$n" ;;
				*.z) uncompress ./"$n" ;;
				*.7z | *.arj | *.cab | *.cb7 | *.chm | *.deb | *.dmg | *.iso | *.lzh | *.msi | *.pkg | *.rpm | *.udf | *.wim | *.xar)
					7z x ./"$n"
					;;
				*.xz) unxz ./"$n" ;;
				*.exe) cabextract ./"$n" ;;
				*.cpio) cpio -id <./"$n" ;;
				*.cba | *.ace) unace x ./"$n" ;;
				*)
					echo "extract: '$n' - unknown archive method"
					return 1
					;;
				esac
			else
				echo "'$n' - file does not exist"
				return 1
			fi
		done
	fi
}

### Added by Zinit's installer
if [[ ! -f $HOME/.config/zsh/.zinit/bin/zinit.zsh ]]; then
	print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
	command mkdir -p "$HOME/.config/zsh/.zinit" && command chmod g-rwX "$HOME/.config/zsh/.zinit"
	command git clone https://github.com/zdharma-continuum/zinit "$HOME/.config/zsh/.zinit/bin" &&
		print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" ||
		print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

### End of Zinit's installer chunk
