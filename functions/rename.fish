function rename --wraps='mv -v' --description 'Batch regex rename; -R/--recursive for recursion'
    # 解析参数
    argparse 'R/recursive' -- $argv
    or begin
        echo "Usage: rename [-R|--recursive] PATTERN REPLACEMENT" >&2
        return 2
    end

    if test (count $argv) -lt 2
        echo "Usage: rename [-R|--recursive] PATTERN REPLACEMENT" >&2
        return 2
    end

    set -l pattern  $argv[1]
    set -l replace  $argv[2]

    if set -q _flag_recursive
        # 递归：只处理文件，忽略 .git 目录
        for path in (command find . -type f -not -path '*/.git/*' -print)
            set -l dir  (dirname -- "$path")
            set -l base (basename -- "$path")

            set -l new (string replace -fr -- "$pattern" "$replace" -- "$base")
            if test -n "$new"; and test "$new" != "$base"
                set -l target "$dir/$new"
                if test -e "$target"
                    echo "skip (exists): $target" >&2
                else
                    command mv -v -- "$path" "$target"
                end
            end
        end
    else
        # 非递归：处理当前目录下的条目（文件/目录均可）
        for name in *
            # 跳过匹配不到的
            set -l new (string replace -fr -- "$pattern" "$replace" -- "$name")
            if test -n "$new"; and test "$new" != "$name"
                if test -e "$new"
                    echo "skip (exists): $new" >&2
                else
                    command mv -v -- "$name" "$new"
                end
            end
        end
    end
end
