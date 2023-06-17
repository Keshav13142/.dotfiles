if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set env and path vars if not on nixos
if ! [[ -x "$(command -v nixos-version)" ]]; then
  path+=('/home/keshav/.local/share/fnm')

  export ANDROID_HOME=/home/keshav/.local/Android/Sdk
  export CARGO_HOME=/home/keshav/.local/.cargo
  export RUSTUP_HOME=/home/keshav/.local/.rustup
  export VISUAL=code-insiders
  export BROWSER=brave-browser-beta
else
  export BROWSER=brave
  export VISUAL=code
fi

# Use lunarvim or fallback to neovim
if [ $(command -v lvim) ]; then
  export EDITOR=$(which lvim)
else
  export EDITOR=$(which nvim)
fi
alias vim=$EDITOR
alias v=$EDITOR
export SUDO_EDITOR=$EDITOR

export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'

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

# ----------------FZF-------------------
# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fkill - kill processes - list only the ones you can kill
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# f mv # To move files. You can write the destination after selecting the files.
f() {
    sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
    test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}

# b - browse chrome bookmarks
b() {
  bookmarks_path=~/.config/BraveSoftware/Brave-Browser-Beta/Default/Bookmarks

  jq_script='
    def ancestors: while(. | length >= 2; del(.[-1,-2]));
    . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'

  jq -r "$jq_script" < "$bookmarks_path" \
    | sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' \
    | fzf --ansi \
    | cut -d$'\t' -f2 \
    | xargs "$BROWSER"
}

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

# git commit browser with previews
fshow() {
  git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@" |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
      --ansi --preview="$_viewGitLogLine" \
      --header "enter to view, alt-y to copy hash" \
      --bind "enter:execute:$_viewGitLogLine   | less -R" \
      --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

# Create useful gitignore files
fgi() {
	__gi() {
		cmd="$@"
		curl -L -s https://www.gitignore.io/api/"$cmd"
	}

	if [ "$#" -eq 0 ]; then
		IFS+=","
		for item in $(__gi list); do
			echo "$item"
		done | fzf --multi --ansi | paste -s -d "," - |
			{ read -r result && __gi "$result"; } >>.gitignore
	else
		__gi "$@"
	fi
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

# fgst - pick files from `git status -s`
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fgst() {
  # "Nothing to see here, move along"
  is_in_git_repo || return

  local cmd="${FZF_CTRL_T_COMMAND:-"command git status -s"}"

  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -m "$@" | while read -r item; do
    echo "$item" | awk '{print $2}'
  done
  echo
}

# tmux switch pane
ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}

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
