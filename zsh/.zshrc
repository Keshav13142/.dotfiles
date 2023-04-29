# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------ZSH----------------
ZSH_THEME="robbyrussell"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.config/zsh/zsh-you-should-use/you-should-use.plugin.zsh
source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# history substring search options
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# options
unsetopt menu_complete
unsetopt flowcontrol

setopt prompt_subst
setopt always_to_end
setopt append_history
setopt auto_menu
setopt complete_in_word
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

autoload -U compinit 
compinit

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

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
alias l='exa'
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
alias ..='cd ..'
alias ...='cd ...'

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
source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
