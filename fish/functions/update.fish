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
		echo -e "\nUPDATING PACMAN"
		sudo pacman -Syu --noconfirm
		pacman_remove_orphaned_packages
	end

	if type -q paru
		echo -e "\nUPDATING PARU"
		paru -Syu
		pacman_remove_orphaned_packages
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

function pacman_remove_orphaned_packages
	set -l orphaned_packages (pacman -Qdtq)

	if test (count $orphaned_packages) -eq 0
		echo "No orphaned packages found"
		return 0
	end

	paru -Rns $orphaned_packages
end
