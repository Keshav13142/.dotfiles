if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Adding stuff to path
if ! [[ -x "$(command -v nixos-version)" ]]; then
  path+=("$XDG_DATA_HOME/fnm")
  path+=("$HOME/softwares/apache-maven-3.9.2/bin")
fi
path+=("$HOME/.local/bin")
path+=("$XDG_CONFIG_HOME/tmux/plugins/t-smart-tmux-session-manager/bin")
path+=("/usr/local/go/bin")
path+=("$HOME/go/bin")
path+=("$XDG_DATA_HOME/cargo/bin")
path+=("$XDG_DATA_HOME/go/bin")
path+=("$XDG_DATA_HOME/npm/bin")

path+=("$ANDROID_HOME/emulator")
path+=("$ANDROID_HOME/tools")
path+=("$ANDROID_HOME/platform-tools")

windows_user="skesh"
if [[ $(grep microsoft /proc/version) ]]; then
  path+=("/mnt/c/Windows/System32")
  path+=("/mnt/c/Windows/SysWOW64")
  path+=("/mnt/c/Program Files/Neovim/bin")
  path+=("/mnt/c/Users/$windows_user/AppData/Local/Programs/Microsoft VS Code/bin")
fi
export PATH

if [[ -x "$(command -v fnm)" ]]; then
  eval "$(fnm env --use-on-cd)"
fi

if [[ -x "$(command -v zoxide)" ]]; then
  eval "$(zoxide init zsh)"
fi

if [[ -x "$(command -v direnv)" ]]; then
  eval "$(direnv hook zsh)"
fi

if [[ -x "$(command -v batpipe)" ]]; then
  eval "$(batpipe)"
fi

# Use lunarvim or fallback to neovim
if [ "$(command -v lvim)" ]; then
	export EDITOR="lvim"
else
	export EDITOR="nvim"
fi
export SUDO_EDITOR="$EDITOR"
export GIT_EDITOR="$EDITOR";

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light zdharma-continuum/history-search-multi-word
zinit light zsh-users/zsh-autosuggestions
zinit light hlissner/zsh-autopair
zinit light jeffreytse/zsh-vi-mode
zinit light wfxr/forgit
zinit light Aloxaf/fzf-tab

zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
