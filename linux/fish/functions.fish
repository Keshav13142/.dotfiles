# ----------------FZF-------------------
function share
    curl -sF"file=@$argv[1]" https://0x0.st | copy
end

# fbr - checkout git branch (including remote branches)
function fbr
    set branches (git branch --all | grep -v HEAD)
    set branch (echo "$branches" | fzf-tmux -d (math 2 + (echo "$branches" | wc -l)) +m)
    git checkout (echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
end

# fkill - kill processes - list only the ones you can kill
function fkill
    if test "$UID" != "0"
        set pid (ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        set pid (ps -ef | sed 1d | fzf -m | awk '{print $2}')
    end

    if test -n "$pid"
        echo $pid | xargs kill -$argv[1]
    end
end

# fh - repeat history
function fh
    history | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | read -l result
    and commandline -- $result
end

# f mv # To move files. You can write the destination after selecting the files.
function f
    set -l sels (fd $fd_default $argv[2..] | fzf)
    test -n "$sels"; and echo "$argv[1] $sels" | read -l result
    and commandline -- $result
end

# b - browse chrome bookmarks
function b
    set -l bookmarks_path ~/.config/BraveSoftware/Brave-Browser/Default/Bookmarks
    set -l jq_script 'def ancestors: while(. | length >= 2; del(.[-1,-2]));
    . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'

    jq -r "$jq_script" < "$bookmarks_path" | \
    sed -E 's/(.*)\t(.*)/\1\t\x1b[36m\2\x1b[m/g' | \
    fzf --ansi | \
    cut -d\t -f2 | \
    read -l result
    and commandline -- "open $result"
end

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" $argv'
set -l _gitLogLineToHash "echo {} | grep -o '[a-f0-9]\\{7\\}' | head -1"
set -l _viewGitLogLine "$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

# git commit browser with previews
function fgc
    git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" $argv | \
    fzf --no-sort --reverse --height=100% --tiebreak=index --no-multi \
    --ansi --preview="$_viewGitLogLine" \
    --header "enter to view, alt-y to copy hash" \
    --bind "enter:execute:$_viewGitLogLine   | less -R" \
    --bind "alt-y:execute:$_gitLogLineToHash | xclip"
end

# Create useful gitignore files
function fgi
    function __gi
        curl -L -s https://www.gitignore.io/api/$argv
    end

    if test (count $argv) -eq 0
        __gi list | tr "," "\n" | fzf --multi | tr "\n" "," | read -l result
        and __gi $result >> .gitignore
    else
        __gi $argv
    end
end

# fstash - easier way to deal with stashes
function fstash
    set -l out (git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" | \
    fzf --ansi --no-sort --query="$argv" --print-query \
    --expect=ctrl-d,ctrl-b)
    set -l q (echo $out[1])
    set -l k (echo $out[2])
    set -l sha (echo $out[-1] | grep -o '[a-f0-9]\{7\}')

    if test -n "$sha"
        if test "$k" = 'ctrl-d'
            git diff $sha
        else if test "$k" = 'ctrl-b'
            git stash branch "stash-$sha" $sha
            return
        else
            git stash show -p $sha
        end
    end
end

# fgst - pick files from `git status -s`
function is_in_git_repo
    git rev-parse HEAD > /dev/null 2>&1
end

# open modified files in a git dir
function fgm
    is_in_git_repo; or return

    set -l cmd (set -q FZF_CTRL_T_COMMAND; and echo $FZF_CTRL_T_COMMAND; or echo "command git status -s")

    eval $cmd | \
    FZF_DEFAULT_OPTS="--height $FZF_TMUX_HEIGHT:-40% --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" \
    fzf -m $argv | awk '{print $2}' | xargs $EDITOR
end

# tmux switch pane
function ftpane
    set -l panes (tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
    set -l current_pane (tmux display-message -p '#I:#P')
    set -l current_window (tmux display-message -p '#I')

    echo "$panes" | grep -v "$current_pane" | fzf +m --reverse | read -l target
    or return

    set -l target_window (echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
    set -l target_pane (echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

    if test $current_window -eq $target_window
        tmux select-pane -t $target_window.$target_pane
    else
        tmux select-pane -t $target_window.$target_pane
        and tmux select-window -t $target_window
    end
end

# run npm script (requires jq)
function fns
    if test -f "package.json"
        jq -r '.scripts | keys[]' package.json | sort | fzf | read -l script
        and npm run $script
    else
        echo "You are not in a node project.... Exiting!!!"
    end
end

function fcd
    find . -type d | fzf | read -l dir
    and cd $dir
end

# ----------------FUNCTIONS-------------------
function un
    if test -f $argv[1]
        switch $argv[1]
        case '*.tar.bz2'
            tar xjf $argv[1]
        case '*.tar.gz'
            tar xzf $argv[1]
        case '*.tar.xz'
            tar xJf $argv[1]
        case '*.bz2'
            bunzip2 $argv[1]
        case '*.rar'
            unrar x $argv[1]
        case '*.gz'
            gunzip $argv[1]
        case '*.tar'
            tar xf $argv[1]
        case '*.tbz2'
            tar xjf $argv[1]
        case '*.tgz'
            tar xzf $argv[1]
        case '*.zip'
            unzip $argv[1]
        case '*.Z'
            uncompress $argv[1]
        case '*.7z'
            7zz x $argv[1]
        case '*'
            echo "'$argv[1]' cannot be extracted via un()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

# Use lf to switch directories and bind it to ctrl-o
function lfcd
    set tmp (mktemp -uq)
    lf -last-dir-path=$tmp $argv
    if test -f "$tmp"
        set dir (cat $tmp)
        rm -f $tmp
        if test -d "$dir" -a "$dir" != (pwd)
            cd $dir
        end
    end
end

# Make CTRL-Z background things and unbackground them.
function fg-bg
    if test (count (commandline -b)) -eq 0
        fg
    else
        commandline -f push-line
    end
end

bind \cz fg-bg

function sesh-sessions
    set session (sesh list | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    if test -n "$session"
        sesh connect $session
    end
end

bind \cf sesh-sessions

function y
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file=$tmp
    set -l cwd (cat -- $tmp)
    rm -f -- $tmp
    if test -n "$cwd" -a "$cwd" != "$PWD"
        cd -- $cwd
    end
end
