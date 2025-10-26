function update
    if type -q apt
        echo -e "\nUPDATING APT"
        sudo apt update
        sudo apt dist-upgrade -y
        sudo apt autoremove -y
    end

    if type -q dnf
        echo -e "\nUPDATING DNF"
        sudo dnf update -y
        sudo dnf autoremove -y
    end

    if type -q flatpak
        echo -e "\nUPDATING FLATPAK"
        sudo flatpak update -y
    end

    if type -q pacman
        set -l package_manager (get_arch_package_manager)
        if test $status -eq 0
            switch $package_manager
                case pacman
                    echo -e "\nUPDATING PACMAN"
                case paru
                    echo -e "\nUPDATING PARU"
            end
            sudo $package_manager -Syu --noconfirm
            arch_remove_orphaned_packages
        end
    end

    if type -q zypper
        echo -e "\nUPDATING ZYPPER"
        sudo zypper refresh
        sudo zypper update -y
        sudo zypper dist-upgrade -y
    end

    echo -e "\nDONE"
end

function up
    update
end

function arch_remove_orphaned_packages
    set -l package_manager (get_arch_package_manager)

    if test $status -ne 0
        echo "Error: Could not find Arch package manager `pacman` or `paru`"
        return 1
    end

    set -l orphaned_packages (sudo $package_manager -Qdtq)

    if test (count $orphaned_packages) -eq 0
        echo "No orphaned packages found"
        return 0
    end

    sudo $package_manager -Rns $orphaned_packages
end

function get_arch_package_manager
    if type -q paru
        echo paru
        return 0
    end

    if type -q pacman
        echo pacman
        return 0
    end

    return 1
end
