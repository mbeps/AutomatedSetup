#!/bin/bash

# Contains functions for various miscellaneous configurations.

source "./dependencies.sh"

# Adds some settings to bashrc.
# Adds some aliases for quick commands.
# Adds custom bash prompt.
function set_bash() {
	title "Setting Up Bash"

	rm "$HOME/.bashrc"                          # remove old `.bashrc` file
	cp "./resources/Bash/.bashrc" "$HOME"       # Add new `.bashrc` file and aliases file
	cp "./resources/Bash/.bash_aliases" "$HOME" # Add new `.bashrc` file and aliases file

	mkdir -p "$HOME/.scripts"
	cp "./resources/scripts/.scripts/update.sh" "$HOME/.scripts"
}

# Sets custom user folders.
# Allows Google Drive folders to be the defaults.
# Sync between computer and Google Drive.
# Source: https://askubuntu.com/questions/67044/change-default-user-folders-path
function set_user_folder_directory() {
	title "Set User Folder Directory"

	base_directory="/home/maruf/Remote/Google Drive"
	locations=(
		"DOCUMENTS"
		"MUSIC"
		"PICTURES"
		"VIDEOS"
	)
	directories=(
		"$base_directory/Documents"
		"$base_directory/Music"
		"$base_directory/Photos"
		"$base_directory/Videos"
	)
	arrayLength=${#locations[@]}

	for ((i = 0; i < $arrayLength; i++)); do
		xdg-user-dirs-update --set ${locations[$i]} "${directories[$i]}"
	done
}

# Mounts the user folder from Royal Holloway Linux Server into file system for easier access.
# Will ask for password which is normally used as log in.
# Source: https://youtu.be/fgEk9Q93FjE
function mount_university_server() {
	title "Mounting Royal Holloway Linux Server into File System"

	sshfs zjac268@linux.cim.rhul.ac.uk:/home/cim/ug/zjac268 "/home/maruf/Remotes/Royal Holloway Linux Server/"
}

# Creates all the directories required for personal use.
# Development, Remote and Wallpapers
function create_required_directories() {
	title "Creating All Required Directories"

	mkdir ~/Development
	mkdir ~/Wallpapers
}

# Adds templates for file types in the right click menu
function add_templates() {
	title "Adding File Templates"
	cp "./resources/Templates/"* "$HOME/Templates"
}


"$@"
