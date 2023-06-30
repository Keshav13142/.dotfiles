# ------------GENERAL----------------
alias cl='clear'
alias tm='tmux'
alias tn='tmux new -s $(pwd | sed "s/.*\///g")'
alias et='exit'

# use batman if available
if [[ -x "$(command -v batman)" ]]; then
	alias man='batman'
fi

alias bg='batgrep'
alias wt="curl -4 wttr.in/avadi"

# use exa if available
if [[ -x "$(command -v exa)" ]]; then
	alias l='exa --icons -F --extended -l'
	alias ll='exa --icons -F --extended -l'
	alias ls='exa --icons -F --extended'
	alias llt='exa --icons -F --extended -lT'
else
	alias l="ls -lah ${colorflag}"
	alias ll="ls -lFh ${colorflag}"
fi

alias rmf="rm -rf"
alias lg='lazygit'
alias clip='xclip -selection clipboard'
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
