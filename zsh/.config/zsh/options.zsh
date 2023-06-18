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
