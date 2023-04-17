function bak
    set -f options -x "c,r"
    set -a options (fish_opt -s c -l copy)
    set -a options (fish_opt -s r -l reverse)
    set -a options (fish_opt -s n -l dry-run)
    argparse -i $options -- $argv
    or return

    if set -q _flag_reverse
        for arg in $argv
            set name (string replace -r '\.bak$' '' $arg)
            if test $status -ne 0
                echo "'$arg'" not ends with .bak >&2
                return
            end

            if set -q _flag_dry_run
                echo mv $arg $name
            else
                mv $arg $name
            end
        end
    else
        for arg in $argv
            if set -q _flag_copy
                if set -q _flag_dry_run
                    echo cp $arg $arg.bak
                else
                    cp $arg $arg.bak
                end
            else
                if set -q _flag_dry_run
                    echo mv $arg $arg.bak
                else
                    mv $arg $arg.bak
                end
            end
        end
    end
end
