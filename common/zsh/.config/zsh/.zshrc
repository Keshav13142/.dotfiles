if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -x "$(command -v compinit)" ]]; then
  compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
fi

# Adding stuff to path
if ! [[ -x "$(command -v nixos-version)" ]]; then
	path+=("$XDG_DATA_HOME/fnm")
  path+=("$HOME/softwares/apache-maven-3.9.2/bin")
fi
path+=("$ANDROID_HOME/emulator")
path+=("$ANDROID_HOME/tools")
path+=("$ANDROID_HOME/platform-tools")
path+=("$HOME/.local/bin")
path+=("$XDG_CONFIG_HOME/tmux/plugins/t-smart-tmux-session-manager/bin")
path+=("/usr/local/go/bin")
path+=("$HOME/go/bin")
path+=("$HOME/.local/.cargo/bin")
export PATH

if [[ -x "$(command -v fnm)" ]]; then
  eval "$(fnm env --use-on-cd)"
fi

if [[ -x "$(command -v zoxide)" ]]; then
  eval "$(zoxide init zsh)"
fi

# Use lunarvim or fallback to neovim
if [ "$(command -v lvim)" ]; then
	export EDITOR="lvim"
else
	export EDITOR="nvim"
fi
export SUDO_EDITOR="$EDITOR"
export GIT_EDITOR="$EDITOR";

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

bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '^X' backward-kill-word
bindkey '^j' beginning-of-line
bindkey '^k' end-of-line
autopair-init

source "$ZDOTDIR/options.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/functions.zsh"

[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
