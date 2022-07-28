# Contains functions to configure Gnome Shell Extensions. 

source "./dependencies.sh"

# Installs all the extensions into `~/.local/share/gnome-shell/extensions/`
	# Unzips th archive containing the extensions into the extensions folder. 
function restore_extensions() {
	title "Restoring Extensions"

	archive="./resources/extensions/extensions.zip"
	destination="$HOME/.local/share/gnome-shell/extensions/"
	uncompress_archive "$archive" "$destination"
}

# Backs up all the installed extensions from `~/.local/share/gnome-shell/extensions/`
	# Creates a Zip archive of all extensions. 
function backup_extensions() {
	title "Backing Up Extensions"

	extensions_location="$HOME/.local/share/gnome-shell/extensions/"
	archive_name="extensions.zip"
	save_location="./resources/extensions"

	cd "$extensions_location"
	zip -r $archive_name .
	cd -
	mv "$extensions_location$archive_name" "$save_location"
}

# Enables favaurite extensions to configure Gnome Shell ideally.
    # Not all installed extensions are enabled.  
function enable_favourite_extensions() {
	title "Enabling Favourite Extensions"

	extensions=(
		"arcmenu@arcmenu.com"
		"clipboard-indicator@tudmotu.com"
		"dash-to-dock-cosmic-@halfmexicanhalfamazing@gmail.com"
		"gestureImprovements@gestures"
		"gsconnect@andyholmes.github.io"
		"just-perfection-desktop@just-perfection"
		"legacyschemeautoswitcher@joshimukul29.gmail.com"
		"NotificationCounter@coolllsk"
		"sound-output-device-chooser@kgshank.net"
		"sound-percentage@maestroschan.fr"
		"tiling-assistant@leleat-on-github"
		"Vitals@CoreCoding.com"

	)
	enable_extensions "${extensions[@]}"
}

# Creates backup file for Gnome Shell Extensions.
	# Saves dump file in `./resources/extensions/`
	# Source: https://www.reddit.com/r/gnome/comments/afuw4h/moving_extensions_and_their_settings_to_new/
function backup_extension_configuration() {
	title "Backing Up Extensions Configuration"

	original="/org/gnome/shell/extensions/"
	backup="./resources/extensions/extension-settings.dconf"
	backup_configuration "$original" "$backup"
}

# Restores the terminal configurations from backed up dump file. 
	# Dump saved in `./resources/extensions/`
	# Source: https://www.reddit.com/r/gnome/comments/afuw4h/moving_extensions_and_their_settings_to_new/
function restore_extension_configuration() {
	title "Restoring Up Extensions Configuration"

	backup="/org/gnome/shell/extensions/"
	original="./resources/extensions/extension-settings.dconf"
	restore_configuration "$backup" "$original"
}

"$@"