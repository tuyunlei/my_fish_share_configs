# - general configs

set ROOT (status dirname)
set -a fish_function_path "$ROOT/functions"

set -gx LESS '--mouse'
set -gx HOMEBREW_NO_ENV_HINTS

source $ROOT/abbrs.fish
source $ROOT/aliases.fish

# - custom configs

set fish_greeting ""
bind \cq 'beginning-of-line' 'nextd-or-forward-word' 'backward-kill-line'

