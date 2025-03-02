set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx ZDOTDIR $XDG_CONFIG_HOME/zsh
set -gx ZIM_HOME $XDG_DATA_HOME/zim
set -gx REPORTTIME 10
set -gx KEYTIMEOUT 1 # 10ms delay for key sequences
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx NODE_REPL_HISTORY $XDG_DATA_HOME/node_repl_history
set -gx TERMINAL kitty
set -gx TERMINAL_PROG kitty
set -gx GTK_THEME Dracula:dark
set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx GOPATH $XDG_DATA_HOME/go
set -gx GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc
set -gx LESSHISTFILE $XDG_CACHE_HOME/less/history
set -gx XCOMPOSECACHE $XDG_CACHE_HOME/X11/xcompose
set -gx FZF_DEFAULT_COMMAND 'fd --type f --color=never --hidden'
set -gx FZF_DEFAULT_OPTS '--layout=reverse --height 70%'
set -gx JAVA_HOME (dirname (dirname (readlink -f (command -s java))))
