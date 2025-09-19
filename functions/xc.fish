function xc
    set current_dir (pwd)

    # 定义局部配置参数
    set -l XCODE_VERSIONS xc15 default
    set -l XCODE_PATHS
    set -l XCODE_PATHS[xc15] /Applications/Xcode-15.4.0.app/
    set -l XCODE_PATHS[default] xed
    set -l XCODE_PATH_PATTERNS
    set -l XCODE_PATH_PATTERNS[xc15] '^/Users/bytedance/flow/flow_ios_grace'

    # 检查全局关联数组是否存在
    if not set -q XCODE_PATH_PATTERNS
        echo "Xcode配置未加载，请检查xcconfig.fish"
        return 1
    end

    # 遍历匹配路径模式
    for version in $XCODE_VERSIONS
        if set -l pattern $XCODE_PATH_PATTERNS[$version]
            if string match -rq -- "$pattern" "$current_dir"
                open -a "$XCODE_PATHS[$version]" $argv
                return
            end
        end
    end

    # 默认使用xed
    xed $argv
end