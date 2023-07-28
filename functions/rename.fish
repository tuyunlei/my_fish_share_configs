function rename --wraps='mv -v'
    set pattern $argv[1]
    set replace $argv[2]
    for name in (command ls)
        set new (string replace -f -r $pattern $replace $name)
        and mv -v $name $new
    end
end
