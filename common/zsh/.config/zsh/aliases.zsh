# General
alias cl='clear'
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
	alias l='exa --icons -alF --extended -l'
	alias ll='exa --icons -aF --extended -l'
	alias ls='exa --icons -F --extended'
	alias llt='exa --icons -alTF --extended'
else
	alias l="ls -lah ${colorflag}"
	alias ll="ls -lFh ${colorflag}"
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
alias nixup='pushd ~/.config/nix ; sudo nixos-rebuild switch --flake .#laptop ; popd'
alias nixcl='sudo nix-collect-garbage -d'

# Edit config files
alias vz="$EDITOR ~/.config/zsh/.zshrc"
alias vi="$EDITOR ~/.config/i3/config"
alias vp="$EDITOR ~/.config/polybar/config.ini"
alias vs="$EDITOR ~/.config/sxhkd/sxhkdrc"
alias vt="$EDITOR ~/.config/tmux/tmux.conf"
alias va="$EDITOR ~/.config/alacritty/alacritty.yml"

bindkey -s ^f "tmux-sessionizer\n"

# ----------------NODE-------------------
alias ns='npm start'
alias nrd='npm run dev'
alias nr='npm run'
