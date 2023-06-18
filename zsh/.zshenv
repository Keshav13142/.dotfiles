export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZIM_HOME="$XDG_DATA_HOME/zim"
export REPORTTIME=10
export KEYTIMEOUT=1 # 10ms delay for key sequences

export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}"/npm/npmrc
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history

# Use lunarvim or fallback to neovim
if [ $(command -v lvim) ]; then
	export EDITOR=$(which lvim)
else
	export EDITOR=$(which nvim)
fi
export SUDO_EDITOR="$EDITOR"

export TERMINAL="alacritty"
export TERMINAL_PROG="alacritty"
