# - general configs

set ROOT (status dirname)
set -a fish_function_path "$ROOT/functions"

set -x LESS '--mouse'
set -x HOMEBREW_NO_ENV_HINTS
set -x RUST_BACKTRACE 1

source $ROOT/abbrs.fish
source $ROOT/aliases.fish

# - custom configs

set fish_greeting ""
bind --mode insert \cq 'beginning-of-line' 'nextd-or-forward-word' 'backward-kill-line'
bind --mode insert \cp _fish_ai_codify_or_explain
bind --mode insert \co _fish_ai_autocomplete_or_fix

set -x CARGO_REGISTRIES_CRATES_IO_PROTOCOL sparse

# set -gx LDFLAGS "-L/opt/homebrew/opt/libpq/lib"
# set -gx CPPFLAGS "-I/opt/homebrew/opt/libpq/include"

fzf_configure_bindings --directory=\ct

if status is-interactive
    # Commands to run in interactive sessions can go here
    if test "$TERM_PROGRAM" = "iTerm.app"
        source ~/.iterm2_shell_integration.fish
    end

    set -gx GPG_TTY (tty)

    zoxide init fish | source
    vfox activate fish | source
    rbenv init - fish | source
    jenv init - fish | source
    pyenv init - fish | source
    # pyenv virtualenv-init - fish | source

    # if not set -q DISABLE_ZELLIJ
    #     eval (zellij setup --generate-auto-start fish | string collect)
    #     and exit
    # end
end
