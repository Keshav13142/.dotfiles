if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# add fnm to path if not on nixos
if ! [[ -x "$(command -v nixos-version)" ]]; then
  path+=('/home/keshav/.local/share/fnm')
fi
eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh)"

setopt NO_BG_NICE
setopt NO_HUP # don't kill background jobs when the shell exits
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt PROMPT_SUBST

# history
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY     # write the history file in the ":start:elapsed;command" format.
setopt HIST_REDUCE_BLANKS   # remove superfluous blanks before recording entry.
setopt SHARE_HISTORY        # share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS # delete old recorded entry if new entry is a duplicate.

setopt COMPLETE_ALIASES
setopt autocd # Automatically cd into typed directory.
setopt interactive_comments

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

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
# Android
path+=('/home/keshav/.local/Android/Sdk/tools')
path+=('/home/keshav/.local/Android/Sdk/platform-tools')

path+=('/home/keshav/.local/bin')
path+=('/home/keshav/.config/tmux/plugins/t-smart-tmux-session-manager/bin')
path+=('/usr/local/go/bin')
path+=('/home/keshav/go/bin')
path+=('/home/keshav/softwares/apache-maven-3.9.2/bin')
fpath=(/home/keshav/.config/zsh/plugins/zsh-completions/src/ $fpath)

export PATH

# ------------GENERAL----------------
alias cl='clear'
alias tm='tmux'
alias tn='tmux new -s $(pwd | sed "s/.*\///g")'
alias et='exit'
alias cat='bat -p'
alias man='batman'
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
alias ...='cd ...'
# Edit config files
alias vz='v ~/.config/zsh/.zshrc'
alias vi='v ~/.config/i3/config'
alias vp='v ~/.config/polybar/config.ini'
alias vs='v ~/.config/sxhkd/sxhkdrc'
alias vt='v ~/.config/tmux/tmux.conf'
alias va='v ~/.config/alacritty/alacritty.yml'

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
# # ex - archive extractor
# # usage: ex <file>
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
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

# Plugins
source ~/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.config/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
source ~/.config/zsh/plugins/zsh-autopair/autopair.plugin.zsh
source ~/.config/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# source ~/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

autopair-init
# history substring search options
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
