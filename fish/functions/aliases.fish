function cat
    if type -q bat
        set catbin bat

    else if type -q batcat
        set catbin batcat

    else
        command cat $argv
        return 0
    end

    $catbin -pp --tabs 4 --theme ansi $argv
end

function em
    emacsclient -ct $argv
end

function f
    flatpak $argv
end

function ff
    fastfetch $argv
end

function fflol
    if not type -q lolcat
        echo " fflol: lolcat not installed"
        return 127 # command not found
    end

    fastfetch $argv | lolcat
end

function g
    git $argv
end

function reload
    source $fish_dir/config.fish
    echo "🐟 Fish config reloaded!"
end

function sail
    if test -f sail
        sh sail $argv
    else
        sh vendor/bin/sail $argv
    end
end

function vi
    nvim $argv
end

function weather
    curl wttr.in/Colorado+Springs?u
end
