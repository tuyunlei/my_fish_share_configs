function bak
    set -f options -x "c,r"
    set -a options (fish_opt -s c -l copy)
    set -a options (fish_opt -s r -l reverse)
    # set -a options (fish_opt -s n -l dry-run)
    argparse -i $options -- $argv
    or return

    function _eval
        echo $argv 1>&2
        eval $argv
        # if set -q _flag_dry_run
        #     echo $argv
        # else
        #     eval $argv
        # end
    end

    if set -q _flag_reverse
        for arg in $argv
            set name (string replace -r '\.bak$' '' $arg)
            if test $status -ne 0
                echo "'$arg'" not ends with .bak >&2
                return
            end

            _eval mv "$arg" "$name"
        end
    else
        for arg in $argv
            if set -q _flag_copy
                _eval cp -c "$arg" "$arg.bak"
            else
                _eval mv "$arg" "$arg.bak"
            end
        end
    end

    functions -e _eval
end
