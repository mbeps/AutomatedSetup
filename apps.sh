#!/bin/bash

# Contains functions to install various apps from various sources.

source "./dependencies.sh"

# Installs Flatpak apps (from FlatHub) which were not part of the system.
# Extra apps which were not preinstalled.
function install_flathub_apps_system() {
	title "Installing System Flathub Apps"

	apps=(
		"com.github.neithern.g4music"
		"org.gnome.Decibels"
		"com.github.rafostar.Clapper"
		"io.missioncenter.MissionCenter"
		"net.nokyan.Resources"
		"com.raggesilver.BlackBox"
		"org.gnome.Calculator"
		"org.gnome.Calendar"
		"org.gnome.Contacts"
		"org.gnome.FileRoller"
		"org.gnome.Papers"
		"org.gnome.Geary"
		"org.gnome.Loupe"
		"org.gnome.Snapshot"
		"org.gnome.TextEditor"
		"org.gnome.Weather"
		"org.gnome.clocks"
		"org.gnome.SimpleScan"
		"org.gnome.Maps"
		"org.gnome.SoundRecorder"
		"io.github.amit9838.mousam"
	)

	install_flathub_apps "${apps[@]}"
}

# Installs Flatpak apps (from FlatHub) which were not part of the system.
# Extra apps which were not preinstalled.
function install_flathub_apps_non_system() {
	title "Installing Non-System Flathub Apps"

	apps=(
		"app.drey.EarTag"
		"com.bitwarden.desktop"
		"com.github.alexhuntley.Plots"
		"com.github.flxzt.rnote"
		"com.github.maoschanz.drawing"
		"com.github.tchx84.Flatseal"
		"com.github.wwmm.easyeffects"
		"com.mattjakeman.ExtensionManager"
		"de.schmidhuberj.Flare"
		"fr.free.Homebank"
		"it.mijorus.smile"
		"me.dusansimic.DynamicWallpaper"
		"org.gnome.Boxes"
		"org.gnome.Connections"
		"org.gnome.NetworkDisplays"
		"org.gnome.Todo"
		"org.gnome.baobab"
		"org.gnome.gitg"
		"org.nickvision.tubeconverter"
		"org.onlyoffice.desktopeditors"
		"org.pulseaudio.pavucontrol"
		"age.codeberg.libre_menu_editor.LibreMenuEditor"
	)

	install_flathub_apps "${apps[@]}"
}

# Removing preinstalled Flatpak apps.
function remove_preinstalled_flatpaks() {
	title "Removing Preinstalled Flatpak"

	flatpak remove org.fedoraproject.MediaWriter -y
}

# Removes some preinstalled native apps in favour of Flatpak versions of the same apps.
function remove_native_system_apps() {
	title "Remove Native System Apps"

	packages=(
		"gnome-boxes"       # Gnome Boxes - Virtualisation Tool
		"gnome-calculator"  # Calculator
		"gnome-calendar"    # Calendar
		"gnome-clocks"      # Clocks
		"gnome-connections" # Connection - Remote Connection Tool
		"gnome-contacts"    # Contacts
		"gnome-maps"        # Maps
		"gnome-text-editor" # Text Editor
		"gnome-weather"     # Weather
		"eog"               # Weather
		"totem"             # Videos
		"rhythmbox"         # Music
		"gnome-terminal"    # Terminal
		# LibreOffice
		"libreoffice"
		"libreoffice-calc"
		"libreoffice-core"
		"libreoffice-draw"
		"libreoffice-writer"
		"libreoffice-impress"
	)

	remove_native_apps "${packages[@]}"
}

# Installs some native apps that were not part of the system.
# Flatpak versions not available.
function install_native_system_apps() {
	packages=(
		"gnome-tweaks"     # Gnome Tweaks
		"gnome-usage"      # Gnome Usage
		"openssl"          # OpenSSL
		"sshfs"            # SSHFS
		"tldr"             # TLDR
		"libgda"           # Libgda
		"libgda-sqlite"    # Libgda SQLite
		"pipx"             # Pipx
	)

	install_native_apps "${packages[@]}"
}

# Installs InSync for syncing Google Drive with main file system.
# Adds all the necessary keys and repositories.
# Source: https://www.insynchq.com/downloads
function install_insync() {
	title "Installing InSync"

	sudo rpm --import https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key

	respository=(
		"[insync]"
		"name=insync repo"
		"baseurl=http://yum.insync.io/fedora/\$releasever/"
		"gpgcheck=1"
		"gpgkey=https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key"
		"enabled=1"
		"metadata_expire=120m"
	)
	for line in "${respository[@]}"; do # Imports repository
		echo "$line" | sudo tee -a /etc/yum.repos.d/insync.repo
	done
	sudo yum install insync -y
}

# Installs Waydroid to be able to run Android apps.
# Sets multiwindow to run multiple apps at once.
# Source: https://docs.waydro.id/usage/install-on-desktops
function install_waydroid() {
	title "Installing Waydroind Android Support"

	sudo dnf install waydroid -y
	sudo systemctl enable --now waydroid-container

	waydroid prop set persist.waydroid.multi_windows true # multiwindow
	sudo systemctl restart waydroid-container
}

# Allows opening BlackBox terminal in files.
function files_terminal() {
	title "Enable BlackBox for Files"

	sudo dnf install nautilus-python -y
	git clone https://github.com/ppvan/nautilus-open-in-blackbox.git
	cd nautilus-open-in-blackbox
	bash ./install.sh
	cd ..
	rm -rf nautilus-open-in-blackbox
}

"$@"
