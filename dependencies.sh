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
function install_flathub_apps() {
	apps=$1
	for app in "${apps[@]}"; do
		flatpak install flathub $app -y
	done
}

# Installs native apps and packages from a list. 
	# Args:
		# - $1: array of packages
function install_native_apps() {
	packages=$1
	for package in "${packages[@]}"; do
		sudo dnf install $package -y
	done
}

# Removes native apps and packages from a list. 
	# Args:
		# - $1: array of apps
function remove_native_apps() {
	packages=$1
	for package in "${packages[@]}"; do
		sudo dnf remove $package -y
	done
}

# Enables Gnome Shell extensions from a list.  
	# Args:
		# - $1: array of extensions
function enable_extensions() {
	title "Enabling Extensions"

	extensions=$1
	for extension in "${extensions[@]}"; do
		gnome-extensions enable "$extension" 
	done  
}

# Takes an archive and splits into 90M. 
	# This is due to size contraints on GitHub. 
		# Args:
			# - $1: location of the archive to be split
			# - $2: location where splitted archive is to be saved
	# Source: https://superuser.com/questions/336219/how-do-i-split-a-zip-file-into-multiple-segments#:~:text=Add%20a%20comment-,3%20Answers,-Sorted%20by%3A
function split_archive() {
	title "Spltting Archive"

	location=$1
	destination=$2
	zip $location --out $destination -s 90m
}
