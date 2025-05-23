$env.config.shell_integration.osc133 = false
$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.config.edit_mode = "vi"
$env.config.cursor_shape.vi_insert = "line"
$env.config.completions.algorithm = "fuzzy"
$env.config.cursor_shape.vi_normal = "block"
$env.config.rm.always_trash = true
$env.config.table.header_on_separator = true
$env.config.datetime_format.normal = "%d/%m/%y %I:%M:%S %p"
$env.config.datetime_format.table = "%d/%m/%y %I:%M:%S %p"

alias et = exit
alias ll = ls -l
alias lg = lazygit
alias cat = bat
alias copy = clip
alias v = nvim
alias vi = nvim
alias vim = nvim
alias gs = git status
alias gc = git commit -m
alias ga = git add
alias gl = git log --oneline
alias man = help
alias reload = exec nu

source ~/.zoxide.nu

alias cd = z

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

fnm env --json | from json | load-env
$env.PATH ++= [($env.FNM_MULTISHELL_PATH)]
