# Contains functions to install various apps from various sources.

source "./dependencies.sh"

# Installs Flatpak apps (from FlatHub) which were not part of the system. 
	# Extra apps which were not preinstalled. 
function install_flathub_apps_non_system() { 
	title "Installing Non-System Flathub Apps"
	
	apps=(
		"com.github.maoschanz.drawing" 			# Drawing - Paint App
		"com.mattjakeman.ExtensionManager" 		# Extensions Manager for Gnome
		"com.github.johnfactotum.Foliate" 		# Foliate - eBook Reader
		"de.haeckerfelix.Fragments" 			# Fragments - Torrent Client
		"org.gnome.Geary" 						# Geary - Email Client
		"fr.free.Homebank" 						# HomeBank - Personal Finance
		"com.github.alexhuntley.Plots" 			# Plots - Graphing Tool
		"com.github.flxzt.rnote" 				# rNote - Whiteboard App
		"it.mijorus.smile" 						# Smile - Emoji Picker
		"org.gnome.SoundRecorder" 				# Sound Recorder
		"org.onlyoffice.desktopeditors" 		# OnlyOffice - Office Client
		"org.gnome.FileRoller" 					# File Roller - Archive Manager
		"org.gnome.Music" 						# Gnome Music
		"org.gnome.NetworkDisplays" 			# Network Displays
		"com.github.tchx84.Flatseal" 			# FlatSeal - Flatpak permission manager
		"org.gnome.Todo" 						# Gnome To-Do
		"com.github.rafostar.Clapper" 			# Clapper - Video Player
		"me.dusansimic.DynamicWallpaper" 		# Dynamic Wallpaper
		"com.bitwarden.desktop"					# Bitwarden
		"com.github.neithern.g4music"			# G4Music - Music Player
		"org.pulseaudio.pavucontrol"			# Volume Control
		"org.signal.Signal" 					# Signal
		"io.github.fsobolev.TimeSwitch"			# Time Switch - System Timer

		)

	install_flathub_apps "${apps[@]}"
}

# Installs Flatpak apps (from FlatHub) as alternatives to some preinstalled native versions of the same apps. 
	# Flatpak versions of the apps that were preinstalled. 
function install_flathub_apps_system() { 
	title "Installing System Flathub Apps Alternatives"
	
	apps=(
		"org.gnome.Calculator" 					# Calculator
		"org.gnome.Calendar" 					# Calendar
		"org.gnome.clocks" 						# Clocks
		"org.gnome.Connections" 				# Connection - Remote Connection Tool
		"org.gnome.Contacts" 					# Contacts
		"org.gnome.baobab" 						# Disk Analyser
		"org.gnome.eog" 						# Image Viewer
		"org.gnome.Maps" 						# Maps
		"org.gnome.TextEditor" 					# Text Editor
		"org.gnome.Totem" 						# Videos
		"org.gnome.Weather" 					# Weather
		"org.libreoffice.LibreOffice" # LibreOffice
		"io.github.fabrialberio.pinapp" # PinApp - edit apps 
		"org.nickvision.tubeconverter" # Tube Converter - video downloader
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
	title "Remove Native System Apps for Flatpak Alternatives"

	packages=(
		"gnome-boxes" 							# Gnome Boxes - Virtualisation Tool
		"gnome-calculator" 						# Calculator
		"gnome-calendar" 						# Calendar
		"gnome-clocks" 							# Clocks
		"gnome-connections" 					# Connection - Remote Connection Tool
		"gnome-contacts" 						# Contacts
		"gnome-maps" 							# Maps
		"gnome-text-editor" 					# Text Editor
		"gnome-weather" 						# Weather
		"rhythmbox"								# Rhythmbox Music
		# LibreOffice
		"libreoffice"
		"libreoffice-calc" 
		"libreoffice-core"
		"libreoffice-draw"
		"libreoffice-writer"
		"libreoffice-impress"
		)

	remove_native_apps "${packages[@]}"
	sudo dnf autoremove -y
}

# Installs some native apps that were not part of the system. 
	# Flatpak versions not available. 
function install_native_system_apps() {
	packages=(
		"gnome-tweaks" 							# Gnome Tweaks
		"gnome-usage" 							# Gnome Usage
		"openssl"								# OpenSSL
		"sshfs" 								# SSHFS
		"tldr" 									# TLDR 
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

# Installs Microsoft Edge browser. 
	# Adds all the necessary keys and repositories. 
	# Source: https://www.linuxcapable.com/how-to-install-microsoft-edge-on-fedora-34-35/
function install_microsoft_edge() { 
	title "Installing Microsoft Edge"

	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
	package=("microsoft-edge-stable")
	install_native_apps "${package[@]}"
}

"$@"