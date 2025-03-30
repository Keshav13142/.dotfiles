function is_wsl
    if test -n "$WSL_DISTRO_NAME"
        return 0
    else
        return 1
    end
end

source $HOME/.config/fish/exports.fish

if status is-interactive
    set -g fish_greeting # Disable greeting

    # Adding stuff to PATH
    if not type -q nixos-version
        set -gx PATH $XDG_DATA_HOME/fnm $PATH
        set -gx PATH $HOME/softwares/apache-maven-3.9.2/bin $PATH
    end

    if is_wsl
        set -gx PATH $HOME/.nix-profile/bin $PATH
        set -gx PATH /nix/var/nix/profiles/default/bin $PATH
    end

    set -gx PATH $HOME/.local/bin $PATH
    set -gx PATH $XDG_CONFIG_HOME/tmux/plugins/t-smart-tmux-session-manager/bin $PATH
    set -gx PATH /usr/local/go/bin $PATH
    set -gx PATH $HOME/go/bin $PATH
    set -gx PATH $XDG_DATA_HOME/cargo/bin $PATH
    set -gx PATH $XDG_DATA_HOME/go/bin $PATH
    set -gx PATH $XDG_DATA_HOME/npm/bin $PATH
    set -gx PATH $ANDROID_HOME/emulator $PATH
    set -gx PATH $ANDROID_HOME/tools $PATH
    set -gx PATH $ANDROID_HOME/platform-tools $PATH

    set -g windows_user skesh

    if grep -q microsoft /proc/version
        set -gx PATH /mnt/c/Windows/System32 $PATH
        set -gx PATH /mnt/c/Windows/SysWOW64 $PATH
        set -gx PATH /mnt/c/Program\ Files/Neovim/bin $PATH
        set -gx PATH /mnt/c/Users/$windows_user/AppData/Local/Programs/Microsoft\ VS\ Code/bin $PATH
    end

    # Initialize fnm if available
    if type -q fnm
        fnm env --use-on-cd --shell fish | source
    end

    # Initialize zoxide if available
    if type -q zoxide
        zoxide init fish | source
    end

    # Initialize direnv if available
    if type -q direnv
        direnv hook fish | source
    end

    # Initialize batpipe if available
    if type -q batpipe
        eval (batpipe)
    end

    # Use LunarVim or fallback to Neovim
    if type -q lvim
        set -gx EDITOR lvim
    else
        set -gx EDITOR nvim
    end

    set -gx SUDO_EDITOR $EDITOR
    set -gx GIT_EDITOR $EDITOR

    source $XDG_CONFIG_HOME/fish/aliases.fish
    source $XDG_CONFIG_HOME/fish/functions.fish

    # Emulates vim's cursor shape behavior
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    set fish_cursor_external line
    set fish_cursor_visual block

    bind -M insert \ca beginning-of-line
    bind -M insert \ce end-of-line
    bind -M insert \cr _fzf_search_history
    bind -M insert \cp history-search-backward
    bind -M insert \cn history-search-forward
    # bind -M insert \cc kill-whole-line repaint

    # ctrl+alt+v -> variables
    # ctrl+f -> dir
    # ctrl+r -> history
    # ctrl+alt+p -> processes
    # ctrl+g -> git status
    # ctrl+l -> git log
    fzf_configure_bindings --directory=\cf --variables=\e\cv --git_status=\cg
    set fzf_diff_highlighter diff-so-fancy
    # set fzf_diff_highlighter delta --paging=never --width=20
    set fzf_history_time_format %d-%b-%y %I:%M %p

    function fish_mode_prompt
        # Disabling the vi mode indicator
    end
end
