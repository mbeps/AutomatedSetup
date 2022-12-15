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

# Applies theme to legacy Flatpak apps. 
	# Native app themes are sepparate from Flatpak apps. 
	# Source: https://itsfoss.com/flatpak-app-apply-theme/
function apply_theme_to_flatpaks() { 
	title "Applying Themes to Unsupported Flatpak Apps"
	
	apps=(
		"org.gnome.eog" 						# Image Viewer
		"org.gnome.Totem" 						# Videos
		"org.gnome.Boxes" 						# Gnome Boxes - Virtualisation Tool
		"org.gnome.Maps" 						# Maps
		"org.gnome.Connections" 				# Connection - Remote Connection Tool
		"org.gnome.FileRoller" 					# File Roller - Archive Manager
		"com.github.tchx84.Flatseal" 			# Flatseal - Flatpak Permission Manager
		)

	for app in "${apps[@]}"; do
		sudo flatpak override $app --env=GTK_THEME=adw-gtk3-dark
	done
}

# Applies Gnome theme to Firefox. 
	# Source: https://github.com/rafaelmardojai/firefox-gnome-theme
function firefox_gnome_theme() { 
	title "Applying Firefox Gnome Theme"

	curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash
}

"$@"