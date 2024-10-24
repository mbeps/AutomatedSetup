#!/bin/bash

# Contains functions to install various fonts.

source "./dependencies.sh"

# Install Cascadia Code Font from RPM repository.
function install_fonts() {
	title "Installing Cascadia Code Font"

	package=("cascadia-fonts-all" "rsms-inter-fonts")
	install_native_apps "${package[@]}"
}

# Installs Microsoft Windows Proprietary fonts.
# Unzips fonts into the fonts folder.
# Source: https://superuser.com/questions/336219/how-do-i-split-a-zip-file-into-multiple-segments#:~:text=Add%20a%20comment-,3%20Answers,-Sorted%20by%3A
function install_windows_fonts() {
	title "Installing Windows Proprietary Fonts"

	zip -F "./resources/fonts/windows/new.zip" --out "./resources/fonts/windows/windows-fonts.zip" # Reconstructs split archive
	unzip "./resources/fonts/windows/windows-fonts.zip" -d "/usr/share/fonts/windows"              # Unzip
}

# Backs up Windows fonts stored in `/usr/share/fonts/windows/`.
# Creates a Zip archive.
function backup_windows_fonts() {
	title "Backing Up Windows Fonts"

	cd "/usr/share/fonts/windows"
	sudo zip -r "backup.zip" .
	cd -
	sudo mv "/usr/share/fonts/windows/backup.zip" "./resources/fonts/windows"
}

# Trims backup archive and removes original archive.
# Backup archive trimmed into 90M due to size limitations on GitHub.
function trim_fonts_backup() {
	title "Trimming Fonts Backup Archive"

	location="./resources/fonts/windows/backup.zip"
	destination="./resources/fonts/windows/new.zip"
	split_archive $location $destination
	rm "./resources/fonts/windows/backup.zip"
}

"$@"
