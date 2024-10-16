# General
alias cl='clear'
alias q='exit'
alias et='exit'
alias mkdir='mkdir -p'
alias clera='clear'
alias clea='clear'
alias chmox='chmod'

# Tmux
alias tm='tmux'
alias tn='tmux new -s $(pwd | sed "s/.*\///g")'
alias ta='tmux attach -t'
alias tl='tmux list-sessions'

alias bg='batgrep'
alias wt="curl -4 wttr.in/avadi"
alias sz="du -hsx * | sort -rh | head -10"

alias lg='lazygit'

alias cd='z'
alias rm='trash'
alias trs='trash-restore'
alias tl='trash-list'
alias mv="mv -iv"
alias cp='cp -iv'
alias ..='cd ..'
alias ...='cd ../../'
alias v="$EDITOR"
alias vim="$EDITOR"
alias g='git'
alias gs='git status'
alias gc='git commit -m'
alias gl='g lg'
alias nup='pushd ~/.config/nix ; sudo nixos-rebuild switch --flake .#laptop ; popd'
alias nfu='pushd ~/.config/nix ; nix flake update ; popd'
alias ncl='sudo nix-collect-garbage -d'
alias yl='yt-dlp'

# ----------------NODE-------------------
alias ns='npm start'
alias nrd='npm run dev'
alias nr='npm run'

# use batman if available
if command -q batman
    alias man batman
end

# use exa if available
if command -q exa
    alias l 'exa --icons -lF --extended -l --group-directories-first'
    alias ll 'exa --icons -F --extended -l --group-directories-first'
    alias ls 'exa --icons -F --extended --group-directories-first'
    alias llt 'exa --icons -lTF --extended'
else
    alias ls "ls -Fh $colorflag --group-directories-first"
    alias ll "ls -lFh $colorflag --group-directories-first"
    alias l "ll"
end

if command -q xclip
    alias copy 'xclip -selection clipboard'
end

if command -q wl-copy
    alias copy 'wl-copy'
end

if command -q clip.exe
    alias copy 'clip.exe'
end
