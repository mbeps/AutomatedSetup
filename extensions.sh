#!/bin/bash

# Contains functions to configure Gnome Shell Extensions.

source "./dependencies.sh"

# Installs all the extensions into `~/.local/share/gnome-shell/extensions/`
# Unzips th archive containing the extensions into the extensions folder.
function restore_extensions() {
	title "Restoring Extensions"

	unzip "./resources/extensions/extensions.zip" -d "$HOME/.local/share/gnome-shell/extensions/"
}

# Backs up all the installed extensions from `~/.local/share/gnome-shell/extensions/`
# Creates a Zip archive of all extensions.
function backup_extensions() {
	title "Backing Up Extensions"

	cd "$HOME/.local/share/gnome-shell/extensions/"
	zip -r "extensions.zip" .
	cd -
	mv "$HOME/.local/share/gnome-shell/extensions/extensions.zip" "./resources/extensions"
}

# Enables favaurite extensions to configure Gnome Shell ideally.
# Not all installed extensions are enabled.
function enable_favourite_extensions() {
	title "Enabling Favourite Extensions"

	extensions=(
		"Always-Show-Titles-In-Overview@gmail.com"
		"Bluetooth-Battery-Meter@maniacx.github.com"
		"clipboard-history@alexsaveau.dev"
		"dash-to-panel@jderose9.github.com"
		"emoji-copy@felipeftn"
		"gestureImprovements@gestures"
		"gnome-fuzzy-app-search@gnome-shell-extensions.Czarlie.gitlab.com"
		"gsconnect@andyholmes.github.io"
		"nightthemeswitcher@romainvigier.fr"
		"NotificationCounter@coolllsk"
		"osd-volume-number@deminder"
		"pip-on-top@rafostar.github.com"
		"quick-settings-tweaks@qwreey"
		"rounded-window-corners@fxgn"
		"tiling-assistant@leleat-on-github"
		"tilingshell@ferrarodomenico.com"
		"user-theme@gnome-shell-extensions.gcampax.github.com"
		"weekstartmodifier@saccuzm.gmail.com"
	)
	enable_extensions "${extensions[@]}"
}

# Creates backup file for Gnome Shell Extensions.
# Saves dump file in `./resources/extensions/`
# Source: https://www.reddit.com/r/gnome/comments/afuw4h/moving_extensions_and_their_settings_to_new/
function backup_extension_configuration() {
	title "Backing Up Extensions Configuration"

	dconf dump /org/gnome/shell/extensions/ >./resources/extensions/extension-settings.dconf
}

# Restores the terminal configurations from backed up dump file.
# Dump saved in `./resources/extensions/`
# Source: https://www.reddit.com/r/gnome/comments/afuw4h/moving_extensions_and_their_settings_to_new/
function restore_extension_configuration() {
	title "Restoring Up Extensions Configuration"

	dconf load /org/gnome/shell/extensions/ <./resources/extensions/extension-settings.dconf
}

"$@"
