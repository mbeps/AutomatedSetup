# This file contains resources (functions and variables) which are critical to other files' execution. 

# Displays title for functions and clearns previous output. 
	# Args:
		# - $1: title to be printed.

source "./modules/archive.sh"

function title() {
	clear
	echo $1
}

#^ DEPENDENCIES
# Installs FlatHub apps from a list. 
	# Args:
		# - $1: array of apps
function install_flathub_apps() { apps=$1
	for app in "${apps[@]}"; do
		flatpak install flathub "$app" -y
	done
}

# Installs native apps and packages from a list. 
	# Args:
		# - $1: array of packages
function install_native_apps() { packages=$1
	for package in "${packages[@]}"; do
		sudo dnf install "$package" -y
	done
}

# Removes native apps and packages from a list. 
	# Args:
		# - $1: array of apps
function remove_native_apps() { packages=$1
	for package in "${packages[@]}"; do
		sudo dnf remove "$package" -y
	done
}

# Enables Gnome Shell extensions from a list.  
	# Args:
		# - $1: array of extensions
function enable_extensions() { extensions=$1
	for extension in "${extensions[@]}"; do
		gnome-extensions enable "$extension" 
	done  
}
