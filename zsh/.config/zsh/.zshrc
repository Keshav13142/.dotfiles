if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $ZDOTDIR/options.zsh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh

# Adding stuff to path
if ! [[ -x "$(command -v nixos-version)" ]]; then
	path+=("$XDG_DATA_HOME/fnm")
  path+=("$ANDROID_HOME/tools")
  path+=("$ANDROID_HOME/platform-tools")
  path+=("$HOME/softwares/apache-maven-3.9.2/bin")
fi
path+=("$HOME/.local/bin")
path+=("$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin")
path+=("/usr/local/go/bin")
path+=("$HOME/go/bin")
path+=("$HOME/.local/.cargo/bin")
export PATH

eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh)"

# manage plugins using zim
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
