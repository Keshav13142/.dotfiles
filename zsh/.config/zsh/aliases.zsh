# ------------GENERAL----------------
alias cl='clear'
alias tm='tmux'
alias tn='tmux new -s $(pwd | sed "s/.*\///g")'
alias et='exit'

# use bat if available
if [[ -x "$(command -v bat)" ]]; then
	alias cat='bat -p'
fi
if [[ -x "$(command -v batcat)" ]]; then
	alias cat='batcat -p'
fi
if [[ -x "$(command -v batman)" ]]; then
	alias man='batman'
fi

alias bg='batgrep'
alias wt="curl -4 wttr.in/avadi"

# use exa if available
if [[ -x "$(command -v exa)" ]]; then
	alias l='exa -al --icons'
	alias ll='exa -al --icons'
	alias ls='exa -a --icons'
else
	alias l="ls -lah ${colorflag}"
	alias ll="ls -lFh ${colorflag}"
fi

alias rmf="rm -rf"
alias lg='lazygit'
alias clip='xclip -selection clipboard'
alias cd='z'
alias rm='trash'
alias tr='trash'
alias trr='trash-restore'
alias tl='trash-list'
alias mv='mv -i'
alias cp='cp -i'
alias ..='cd ..'
alias ...='cd ../../'

# Edit config files
alias vz='nvim ~/.config/zsh/.zshrc'
alias vi='nvim ~/.config/i3/config'
alias vp='nvim ~/.config/polybar/config.ini'
alias vs='nvim ~/.config/sxhkd/sxhkdrc'
alias vt='nvim ~/.config/tmux/tmux.conf'
alias va='nvim ~/.config/alacritty/alacritty.yml'

bindkey -s ^f "tmux-sessionizer\n"

# ------------------GIT----------------
alias ga='git add'
alias gp='git push'
alias gi='git init'
alias gs='git status -s'
alias gra='git remote add origin'
alias gc='commit.sh'
alias gca='git commit --amend'
alias gcn='git commit --amend --no-edit'
alias grv='git remote -v'
alias gb='git branch -a'
alias gco='git checkout'
alias gl='git log'
alias grl='git reflog'
alias gr='git reset'

# ----------------NODE-------------------
alias ns='npm start'
alias nrd='npm run dev'
alias nr='npm run'
