# ------------ZSH----------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-history-substring-search you-should-use)
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
alias lg='lazygit'
alias cat='batcat -p'
alias clip='xclip -selection clipboard'
alias sf='shutter -f -e'
alias ss='shutter -s -e'
alias sw='shutter -w -e'
alias grep='rg'
eval "$(zoxide init zsh)"
alias cd='z'
alias tr='trash'
alias trr='trash-restore'
alias tl='trash-list'

bindkey -s ^f "tmux-sessionizer\n"

# ------------------NEOVIM----------------
alias nvim=~/softwares/neovim/build/bin/nvim
alias vi='lvim'
alias v='lvim'
alias vim='lvim'
export EDITOR="lvim"
export VISUAL="lvim"

# ------------------GIT----------------
alias ga='git add' 
alias gpm='git push origin master'
alias gi='git init'
alias gs='git status'
alias gra='git remote add origin'
alias gc='git commit -m'
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
source /home/keshav/softwares/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
