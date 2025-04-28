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
        return 127 # command not found code
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

function update
    if type -q apt
        echo -e "\nUPDATING APT"
        sudo apt update -y
        sudo apt upgrade -y
        sudo apt dist-upgrade -y
    end

    if type -q paru
        echo -e "\nUPDATING PARU"
        paru -Syyu
    end

    if type -q flatpak
        echo -e "\nUPDATING FLATPAK"
        sudo flatpak update -y
    end

    if type -q zypper
        echo -e "\nUPDATING ZYPPER"
        sudo zypper refresh
        sudo zypper update -y
        sudo zypper dist-upgrade -y
    end
end

function up
    update
end

function vi
    nvim $argv
end
