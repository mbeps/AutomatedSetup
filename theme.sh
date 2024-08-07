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

"$@"
