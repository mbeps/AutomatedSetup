# This file contains resources (functions and variables) which are critical to other files' execution. 

# Displays title for functions and clearns previous output. 
	# Args:
		# - $1: title to be printed. 
function title() {
	clear
	echo $1
}

#^ DEPENDENCIES
# Installs FlatHub apps from a list. 
	# Args:
		# - $1: array of apps
function installFlathubApps() {
	apps=$1
	for app in "${apps[@]}"; do
		flatpak install flathub $app -y
	done
}

# Installs native apps and packages from a list. 
	# Args:
		# - $1: array of packages
function installNativeApps() {
	packages=$1
	for package in "${packages[@]}"; do
		sudo dnf install $package -y
	done
}

# Removes native apps and packages from a list. 
	# Args:
		# - $1: array of apps
function removeNativeApps() {
	packages=$1
	for package in "${packages[@]}"; do
		sudo dnf remove $package -y
	done
}

"$@"