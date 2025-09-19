# - general configs

set ROOT (status dirname)
set -p fish_function_path "$ROOT/functions"

set -x LESS '--mouse'
set -x HOMEBREW_NO_ENV_HINTS
set -x RUST_BACKTRACE 1

source $ROOT/abbrs.fish
source $ROOT/aliases.fish

# - fish prompt
function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

    set -l duration (humanize $CMD_DURATION)
    # Color the duration
    if test $CMD_DURATION -lt 500
        set -f duration_color green   # 快速执行，显示绿色
    else if test $CMD_DURATION -lt 2000
        set -f duration_color yellow  # 中等速度，显示黄色
    else if test $CMD_DURATION -lt 10000
        set -f duration_color FFA500  # 较慢，显示橙色
    else
        set -f duration_color red     # 很慢，显示红色
    end

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    # if test -z "$(git -C /Users/bytedance/.mbox/repos/flow_iOS@flow stash list)"
    #     echo "git stash is empty!!!"
    # end

    echo -n -s (set_color $duration_color) "["$duration"] " (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
end

# - fish keybindings
function fish_user_key_bindings
    fish_vi_key_bindings insert
end

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
    # if test "$TERM_PROGRAM" = "iTerm.app"
    #     source ~/.iterm2_shell_integration.fish
    # end

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
