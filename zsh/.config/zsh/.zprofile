# Set env and path vars if not on nixos
if ! [[ -x "$(command -v nixos-version)" ]]; then
	export ANDROID_HOME=$HOME/.local/Android/Sdk
	export CARGO_HOME=$HOME/.local/.cargo
	export RUSTUP_HOME=$HOME/.local/.rustup
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
export SUDO_EDITOR=$EDITOR

export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_DEFAULT_OPTS='--layout=reverse --height 40%'
