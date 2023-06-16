if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set env and path vars if not on nixos
if ! [[ -x "$(command -v nixos-version)" ]]; then
  path+=('/home/keshav/.local/share/fnm')

  export ANDROID_HOME=/home/keshav/.local/Android/Sdk
  export CARGO_HOME=/home/keshav/.local/.cargo
  export RUSTUP_HOME=/home/keshav/.local/.rustup
  export EDITOR=nvim
  export VISUAL=code-insiders
  export BROWSER=brave-browser-beta
else
  export BROWSER=brave
  export VISUAL=code
fi

eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh)"

# history
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY     # write the history file in the ":start:elapsed;command" format.
setopt HIST_REDUCE_BLANKS   # remove superfluous blanks before recording entry.
setopt SHARE_HISTORY        # share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS # delete old recorded entry if new entry is a duplicate.

setopt NO_HUP # don't kill background jobs when the shell exits
setopt COMPLETE_ALIASES
setopt autocd # Automatically cd into typed directory.
setopt interactive_comments

bindkey -s '^o' '^ulfcd\n'
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Use lf to switch directories and bind it to ctrl-o
lfcd() {
	tmp="$(mktemp -uq)"
	trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
	lf -last-dir-path="$tmp" "$@"
	if [ -f "$tmp" ]; then
		dir="$(cat "$tmp")"
		[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
	fi
}

# ------------PATH----------------
# Android
path+=('/home/keshav/.local/Android/Sdk/tools')
path+=('/home/keshav/.local/Android/Sdk/platform-tools')

path+=('/home/keshav/.local/bin')
path+=('/home/keshav/.config/tmux/plugins/t-smart-tmux-session-manager/bin')
path+=('/usr/local/go/bin')
path+=('/home/keshav/go/bin')
path+=('/home/keshav/softwares/apache-maven-3.9.2/bin')
path+=('/home/keshav/.local/.cargo/bin')

export PATH

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

# ------------------NEOVIM----------------
alias lv='lvim'
alias nv='nvim'

# ------------------GIT----------------
alias ga='git add'
alias gp='git push'
alias gi='git init'
alias gs='git status'
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

# ----------------FUNCTIONS-------------------
un() {
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2) tar xjf $1 ;;
		*.tar.gz) tar xzf $1 ;;
		*.tar.xz) tar xJf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar x $1 ;;
		*.gz) gunzip $1 ;;
		*.tar) tar xf $1 ;;
		*.tbz2) tar xjf $1 ;;
		*.tgz) tar xzf $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7zz x $1 ;;
		*) echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# ----------------ZSH PLUGINS-------------------
zstyle ':zim:zmodule' use 'degit'

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
autopair-init

[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
