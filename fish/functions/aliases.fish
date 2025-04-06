function cat
    batcat -pp --tabs 8 --theme ansi $argv
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
    fastfetch $argv | lolcat
end

function g
    git $argv
end

function reload
    source $fish_dir/config.fish
    echo "🐟 Fish config reloaded!"
end

function vi
    nvim $argv
end
