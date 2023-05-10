if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------ZSH----------------
ZSH_THEME="robbyrussell"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' '^ulfcd\n'

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# ------------PATH----------------
path+=('/home/keshav/.local/bin')

# Android
export ANDROID_HOME=/home/keshav/.local/Android/Sdk
path+=('/home/keshav/.local/Android/Sdk/tools')
path+=('/home/keshav/.local/Android/Sdk/platform-tools')

# Rust
export CARGO_HOME=/home/keshav/.local/.cargo
export RUSTUP_HOME=/home/keshav/.local/.rustup

path+=('/usr/local/go/bin')
path+=('/home/keshav/.local/share/fnm')

export PATH

# ------------GENERAL----------------
alias cl='clear'
alias t='tmux'
alias et='exit'
alias l='exa -a --icons' 
alias ll='exa -al --icons'
alias ls='exa -a --icons'
alias lg='lazygit'
alias cat='batcat -p'
alias clip='xclip -selection clipboard'
alias sf='shutter -f -e'
alias ss='shutter -s -e'
alias sw='shutter -w -e'
alias cd='z'
alias tr='trash'
alias trr='trash-restore'
alias tl='trash-list'
alias ..='cd ..'
alias ...='cd ...'

eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd)"

bindkey -s ^f "tmux-sessionizer\n"

# ------------------NEOVIM----------------
alias nvim=~/softwares/neovim/build/bin/nvim
alias vi='lvim'
alias v='lvim'
alias vim='lvim'
export EDITOR="lvim"
export VISUAL="lvim"

# ------------------GIT----------------
alias g='git' 
alias ga='git add' 
alias gp='git push' 
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

# Plugins
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme

# history substring search options
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
