export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZIM_HOME="$XDG_DATA_HOME/zim"
export REPORTTIME=10
export KEYTIMEOUT=1 # 10ms delay for key sequences

export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}"/npm/npmrc
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history

export TERMINAL="wezterm"
export TERMINAL_PROG="wezterm"

export ANDROID_HOME="$HOME/Android/Sdk"

if ! [[ -x "$(command -v nixos-version)" ]]; then
	export CARGO_HOME=$HOME/.local/.cargo
	export RUSTUP_HOME=$HOME/.local/.rustup
	export VISUAL=code-insiders
	export BROWSER=brave-browser-beta
else
	export BROWSER=brave
	export VISUAL=code
fi

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export XCOMPOSECACHE="$XDG_CACHE_HOME/X11/xcompose"

export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_DEFAULT_OPTS='--layout=reverse --height 40%'

export JAVA_HOME="${$(readlink -e $(type -p java))%*/bin/java}"
