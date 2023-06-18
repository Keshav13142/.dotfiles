# Set env and path vars if not on nixos
if ! [[ -x "$(command -v nixos-version)" ]]; then
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
export SUDO_EDITOR=$EDITOR

export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'
