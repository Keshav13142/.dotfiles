# General
alias cl='clear'
alias q='exit'
alias et='exit'
alias mkdir='mkdir -p'
alias clera='clear'
alias clea='clear'
alias chmox='chmod'

# Tmux
alias tm='tmux'
alias tn='tmux new -s $(pwd | sed "s/.*\///g")'
alias ta='tmux attach -t'
alias tl='tmux list-sessions'

# use batman if available
if [[ -x "$(command -v batman)" ]]; then
	alias man='batman'
fi

alias bg='batgrep'
alias wt="curl -4 wttr.in/avadi"
# Get largest files/folder in current dir
alias sz="du -hsx * | sort -rh | head -10"

# use exa if available
if [[ -x "$(command -v exa)" ]]; then
	alias l='exa --icons -alF --extended -l --group-directories-first'
	alias ll='exa --icons -aF --extended -l --group-directories-first'
	alias ls='exa --icons -F --extended --group-directories-first'
	alias llt='exa --icons -alTF --extended'
else
	alias ls="ls -Fh ${colorflag} --group-directories-first"
	alias ll="ls -lFh ${colorflag} --group-directories-first"
  alias l="ll"
fi

alias lg='lazygit'

if [[ -x "$(command -v xclip)" ]]; then
	alias copy='xclip -selection clipboard'
fi
if [[ -x "$(command -v wl-copy)" ]]; then
	alias copy='wl-copy'
fi
if [[ -x "$(command -v clip.exe)" ]]; then
	alias copy='clip.exe'
fi

share() {
	curl -sF"file=@$1" https://0x0.st | copy
}

alias cd='z'
alias rm='trash'
alias trs='trash-restore'
alias tl='trash-list'
alias mv="mv -iv"
alias cp='cp -iv'
alias ..='cd ..'
alias ...='cd ../../'
alias v="$EDITOR"
alias vim="$EDITOR"
alias g='git'
alias gs='git status'
alias gc='git commit -m'
alias nup='pushd ~/.config/nix ; sudo nixos-rebuild switch --flake .#laptop ; popd'
alias nfu='pushd ~/.config/nix ; nix flake update ; popd'
alias ncl='sudo nix-collect-garbage -d'
alias yl='yt-dlp'

bindkey -s ^f "tmux-sessionizer\n"

# ----------------NODE-------------------
alias ns='npm start'
alias nrd='npm run dev'
alias nr='npm run'
