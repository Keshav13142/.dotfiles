# ------------ZSH----------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

# ------------PATH----------------
path+=('/home/keshav/.local/bin')

# Android
export ANDROID_HOME=$HOME/Android/Sdk
path+=('/home/keshav/Android/Sdk/emulator')
path+=('/home/keshav/Android/Sdk/platform-tools')

path+=('/usr/local/go/bin')

export PATH

# ------------GENERAL----------------
alias cl='clear'
alias t='tmux'
alias et='exit'
alias ls='exa'
alias ll='exa -al'
alias cat='batcat -p'
alias clip='xclip -selection clipboard'
alias sf='shutter -f -e'
alias ss='shutter -s -e'
alias sw='shutter -w -e'
alias grep='rg'
eval "$(zoxide init zsh)"
alias cd='z'

bindkey -s ^f "tmux-sessionizer\n"

# ------------------NEOVIM----------------
alias nvim=~/softwares/neovim/build/bin/nvim
alias vi='nvim'
alias v='nvim'
alias vim='nvim'
alias lv='lvim'
export EDITOR="nvim"
export VISUAL="nvim"

# ------------------GIT----------------
alias ga='git add' 
alias gpm='git push origin master'
alias gi='git init'
alias gs='git status'
alias gr='git remote add origin'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gcn='git commit --amend --no-edit'
alias grv='git remote -v'
alias gb='git branch -a'
alias gco='git checkout'
alias gl='git log'
alias gr='git reflog'

# ----------------NODE-------------------
alias ns='npm start'
alias nrd='npm run dev'
alias nr='npm run'
