# - general configs

set ROOT (status dirname)
set -a fish_function_path "$ROOT/functions"

source $ROOT/abbrs.fish
source $ROOT/aliases.fish

# - custom configs

set fish_greeting ""
bind \cq 'beginning-of-line' 'nextd-or-forward-word' 'backward-kill-line'

