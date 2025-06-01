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
        set -l orphaned_packages (paru -Qdtq)
        if test (count $orphaned_packages) -gt 0
            paru -Rns $orphaned_packages
        else
            echo "No orphaned packages found"
        end
    end

    if type -q zypper
        echo -e "\nUPDATING ZYPPER"
        sudo zypper refresh
        sudo zypper update -y
        sudo zypper dist-upgrade -y
    end

    echo -e "\nDONE\n"
end

function up
    update
end
