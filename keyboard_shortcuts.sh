#!/bin/bash

# Contains functions to backup and restore keyboard shortcuts.

source "./dependencies.sh"

# Creates backup files for various keyboard shortcuts.
# Compiles shortcuts from various locations.
# Saves dump files in `./resources/keyboard-shortcuts/`
# Source: https://www.reddit.com/r/gnome/comments/l3ha66/how_to_export_and_import_all_gnome_keyboard/?utm_source=share&utm_medium=web2x&context=3
function backup_keyboard_shortcuts() {
	title "Backing Up Keyboard Shortcuts"

	dconf dump /org/gnome/settings-daemon/plugins/media-keys/ >>./resources/keyboard-shortcuts/dump_1
	dconf dump /org/gnome/desktop/wm/keybindings/ >>./resources/keyboard-shortcuts/dump_2
	dconf dump /org/gnome/shell/keybindings/ >>./resources/keyboard-shortcuts/dump_3
	dconf dump /org/gnome/mutter/keybindings/ >>./resources/keyboard-shortcuts/dump_4
	dconf dump /org/gnome/mutter/wayland/keybindings/ >>./resources/keyboard-shortcuts/dump_5
}

# Restores keyboard shortcuts from dump files.
# Files saved in `./resources/keyboard-shortcuts/`.
# Source: https://www.reddit.com/r/gnome/comments/l3ha66/how_to_export_and_import_all_gnome_keyboard/?utm_source=share&utm_medium=web2x&context=3
function restore_keyboard_shortcuts() {
	title "Restoring Keyboard Shortcuts"

	cat ./resources/keyboard-shortcuts/dump_1 | dconf load /org/gnome/settings-daemon/plugins/media-keys/
	cat ./resources/keyboard-shortcuts/dump_2 | dconf load /org/gnome/desktop/wm/keybindings/
	cat ./resources/keyboard-shortcuts/dump_3 | dconf load /org/gnome/shell/keybindings/
	cat ./resources/keyboard-shortcuts/dump_4 | dconf load /org/gnome/mutter/keybindings/
	cat ./resources/keyboard-shortcuts/dump_5 | dconf load /org/gnome/mutter/wayland/keybindings/
}

"$@"
