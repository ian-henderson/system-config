function update
    if type -q apt
        echo -e "\nUPDATING APT"
        sudo apt update
        sudo apt dist-upgrade -y
        sudo apt autoremove -y
    end

    if type -q flatpak
        echo -e "\nUPDATING FLATPAK"
        sudo flatpak update -y
    end

    if type -q paru
        echo -e "\nUPDATING PARU"
        paru -Syyu
        paru -Rns (paru -Qdtq)
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
