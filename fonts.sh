# Contains functions to install various fonts.

source "./dependencies.sh"

#^ VARIABLES
#^ Locations
local_font_location="/usr/share/fonts/windows"
backup_location="./resources/fonts/windows/"
#^ Archives
reconstructed_archive="windows-fonts.zip"
decomposed_archive="new.zip"
backup_archive="backup.zip"

# Install Cascadia Code Font from RPM repository. 
function install_cascadia_code_font() {
	title "Installing Cascadia Code Font"

	package=("cascadia-fonts-all")
	install_native_apps "${package[@]}"
}

# Installs Microsoft Windows Proprietary fonts. 
	# Unzips fonts into the fonts folder. 
	# Source: https://superuser.com/questions/336219/how-do-i-split-a-zip-file-into-multiple-segments#:~:text=Add%20a%20comment-,3%20Answers,-Sorted%20by%3A
function install_windows_fonts() {
	title "Installing Windows Proprietary Fonts"

	decomposed_backup_location=$backup_location$decomposed_archive # Backup of split archive 
	reconstructed_backup_location=$backup_location$reconstructed_archive

	zip -F $decomposed_backup_location --out $reconstructed_backup_location # Reconstructs split archive
	uncompress_archive $reconstructed_backup_location $local_font_location
}

# Backs up Windows fonts stored in `/usr/share/fonts/windows/`. 
	# Creates a Zip archive. 
function backup_windows_fonts() {
	title "Backing Up Windows Fonts"

	cd $local_font_location
	sudo zip -r $backup_archive .
	cd -
	backup=$local_font_location$backup_archive # Backup archive stored in local font location
	sudo mv $backup $backup_location
}

# Trims backup archive and removes original archive. 
	# Backup archive trimmed into 90M due to size limitations on GitHub. 
function trim_fonts_backup() {
	title "Trimming Fonts Backup Archive"

	target=$backup_location$backup_archive
	destination=$backup_location$decomposed_archive

	split_archive $target $destination
	rm $target
}

"$@"