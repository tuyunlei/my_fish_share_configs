set ROOT (status dirname)

alias duf   'duf -only-mp "/"'
alias la    'eza -a --icons'
alias ll    'eza -lh --icons'
alias lla   'eza -lah --icons'
alias groot 'git rev-parse --show-toplevel'

alias vabbr "vim $ROOT/abbrs.fish"
alias sabbr "source $ROOT/abbrs.fish"
alias vconf "vim $__fish_config_dir/config.fish"
alias sconf "source $__fish_config_dir/config.fish"
