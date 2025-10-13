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

alias litellm.start 'launchctl bootstrap gui/(id -u) ~/Library/LaunchAgents/com.xclz.lhz.litellm.plist'
alias litellm.stop  'launchctl bootout gui/(id -u) ~/Library/LaunchAgents/com.xclz.lhz.litellm.plist'
alias litellm.restart 'launchctl kickstart -k gui/(id -u)/com.xclz.lhz.litellm'

