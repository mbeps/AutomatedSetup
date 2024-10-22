#!/bin/bash

# Contains functions to install and apply theme.

source "./dependencies.sh"

# Installs Libadwaita port for legacy GTK-3.
# Improves consistency between legacy apps and modern apps.
# Source: https://github.com/lassekongo83/adw-gtk3
function install_libadwaita_gtk3_port_theme() {
	title "Installing Libadwaita GTK-3 Theme Port"

	flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark -y
	sudo dnf copr enable nickavem/adw-gtk3 -y
	package=("adw-gtk3")
	install_native_apps "${package[@]}"
}

# Applies Libadwaita theme port to legacy apps.
function apply_theme_to_native_apps() {
	title "Applying Themes to Native Apps"

	gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
}

# Applies Gnome theme to Firefox.
# Source: https://github.com/rafaelmardojai/firefox-gnome-theme
function firefox_gnome_theme() {
	title "Applying Firefox Gnome Theme"

	curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash
}

# Imports themes
function restore_themes() {
	title "Importing Themes"

	mkdir "$HOME/.themes"
	unzip "./resources/themes/themes.zip" -d "$HOME/.themes/"
}

# Installs Marble Shell Theme.
# Source: https://github.com/imarkoff/Marble-shell-theme
function install_marble_shell_theme() {
	title "Installing Marble Shell Theme"

	cd "$HOME/Downloads" || exit
	git clone https://github.com/imarkoff/Marble-shell-theme.git
	cd Marble-shell-theme

	# User theme
	python install.py -a --filled --panel_no_pill

	# GDM theme
	python install.py -a --filled --panel_no_pill --gdm --gray
}

# Restores the ArcMenu icons.
function restore_svg_icons() {
	title "Importing Icons"

	mkdir "$HOME/.icons"
	unzip "./resources/themes/icons.zip" -d "$HOME/.icons/"
}

# Sets up the Theme Monitor script and systemd service
# The script monitors the current theme and changes it to the specified theme if it changes.
function setup_theme_monitor_service() {
    title "Setting up Theme Monitor Service"

    # Create necessary directories if they don't exist
    mkdir -p "$HOME/.scripts"
    mkdir -p "$HOME/.config/systemd/user"

    # Copy the theme_monitor.sh script to ~/.scripts
    cp "./resources/scripts/.scripts/theme_monitor.sh" "$HOME/.scripts/"

    # Make the script executable
    chmod +x "$HOME/.scripts/theme_monitor.sh"

    # Copy the systemd service file to the appropriate location
    cp "./resources/systemd/theme-monitor.service" "$HOME/.config/systemd/user/"

    # Reload the systemd user daemon
    systemctl --user daemon-reload

    # Enable and restart the theme-monitor service
    systemctl --user enable theme-monitor.service
    systemctl --user restart theme-monitor.service
}

"$@"
