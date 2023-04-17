set ROOT (status dirname)

alias duf 'duf -only-mp "/"'
alias la 'exa -a --icons'
alias ll 'exa -lh --icons'
alias lla 'exa -lah --icons'
alias groot 'git rev-parse --show-toplevel'

alias vabbr "vim $ROOT/abbrs.fish"
alias sabbr "source $ROOT/abbrs.fish"
alias vconf "vim $__fish_config_dir/config.fish"
alias sconf "source $__fish_config_dir/config.fish"
