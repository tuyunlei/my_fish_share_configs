function humanize
    set -l total_ms $argv[1]

    # 处理毫秒
    if test $total_ms -lt 1000
        echo (math $total_ms)"ms"
        return
    end

    # 处理秒
    set -l total_seconds (math "$total_ms / 1000")
    if test $total_seconds -lt 60
        if test (math "(floor ($total_seconds * 100)) / 100") -eq $total_seconds
            echo (math "$total_seconds")"s"
        else
            echo (printf "%.2f" $total_seconds)"s"
        end
        return
    end

    # 处理分钟
    set -l total_minutes (math "$total_ms / 60000")
    set -l seconds (math "($total_ms % 60000) / 1000")
    if test $total_minutes -lt 60
        set -l floor_minutes (math "floor $total_minutes")
        set -l floor_seconds (math "floor $seconds")
        if test $seconds -eq 0
            echo (math $floor_minutes)"m"
        else
            echo (math $floor_minutes)"m"(math $floor_seconds)"s"
        end
        return
    end

    # 处理小时
    set -l total_hours (math "$total_ms / 3600000")
    set -l minutes (math "($total_ms % 3600000) / 60000")
    if test $total_hours -lt 24
        set -l floor_hours (math "floor $total_hours")
        set -l floor_minutes (math "floor $minutes")
        if test $minutes -eq 0
            echo (math $floor_hours)"h"
        else
            echo (math $floor_hours)"h"(math $floor_minutes)"m"
        end
        return
    end

    # 处理天
    set -l total_days (math "$total_ms / 86400000")
    set -l hours (math "($total_ms % 86400000) / 3600000")
    set -l minutes (math "($total_ms % 3600000) / 60000")
    set -l floor_days (math "floor $total_days")
    set -l floor_hours (math "floor $hours")
    set -l floor_minutes (math "floor $minutes")
    if test $minutes -eq 0 -a $hours -eq 0
        echo (math $floor_days)"d"
    else
        echo (math $floor_days)"d"(math $floor_hours)"h"(math $floor_minutes)"m"
    end
end

