# History options
export HISTFILE="${XDG_STATE_HOME}/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt EXTENDED_HISTORY     # write the history file in the ":start:elapsed;command" format.
setopt HIST_REDUCE_BLANKS   # remove superfluous blanks before recording entry.
setopt SHARE_HISTORY        # share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS # delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS     # don't add duplicate cmd to hist
setopt HIST_IGNORE_SPACE    # trim spaces

setopt GLOB_DOTS            # tab-complete dotfiles
setopt MENU_COMPLETE        # tab-expand to first option immediately
setopt AUTO_CD              # change dirs without 'cd'
setopt AUTO_REMOVE_SLASH    # remove trailing slash after dir completion
setopt INTERACTIVE_COMMENTS # enable comments in shell commands
setopt COMPLETE_ALIASES
disable r                   # remove irritating alias
setopt NO_HUP               # don't kill background jobs when the shell exits
ZLE_REMOVE_SUFFIX_CHARS=    # keep trailing space after completion
zle_highlight+=(paste:none) # Don't highlight pasted text

bindkey -s '^o' '^ulfcd\n'
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
