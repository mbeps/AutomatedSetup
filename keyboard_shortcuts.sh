# Contains functions to backup and restore keyboard shortcuts.

source "./dependencies.sh"

	backups=(
		"/org/gnome/settings-daemon/plugins/media-keys/"
		"/org/gnome/desktop/wm/keybindings/"
		"/org/gnome/shell/keybindings/"
		"/org/gnome/mutter/keybindings/"
		"/org/gnome/mutter/wayland/keybindings/"
	)
	originals=(
		"./resources/keyboard-shortcuts/dump_1"
		"./resources/keyboard-shortcuts/dump_2"
		"./resources/keyboard-shortcuts/dump_3"
		"./resources/keyboard-shortcuts/dump_4"
		"./resources/keyboard-shortcuts/dump_5"
	)

# Creates backup files for various keyboard shortcuts. 
	# Compiles shortcuts from various locations. 
	# Saves dump files in `./resources/keyboard-shortcuts/`
	# Source: https://www.reddit.com/r/gnome/comments/l3ha66/how_to_export_and_import_all_gnome_keyboard/?utm_source=share&utm_medium=web2x&context=3
function backup_keyboard_shortcuts() {
	title "Backing Up Keyboard Shortcuts"

	backup_configurations "${backups[@]}" "${originals[@]}"
}

# Restores keyboard shortcuts from dump files. 
	# Files saved in `./resources/keyboard-shortcuts/`.
	# Source: https://www.reddit.com/r/gnome/comments/l3ha66/how_to_export_and_import_all_gnome_keyboard/?utm_source=share&utm_medium=web2x&context=3
function restore_keyboard_shortcuts() {
	title "Restoring Keyboard Shortcuts"

	restore_configurations "${backups[@]}" "${originals[@]}"
}

"$@"