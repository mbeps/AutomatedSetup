function title() {
	clear
	echo $1
}
#^ DEPENDENCIES
function installFlathubApps() {
	apps=$1
	for app in ${apps[@]}; do
		flatpak install flathub $app -y
	done
}

function installNativeApps() {
	packages=$1
	for package in ${packages[@]}; do
		sudo dnf install $package -y
	done
}

function removeNativeApps() {
	packages=$1
	for package in ${packages[@]}; do
		sudo dnf remove $package -y
	done
}

#^ PACKAGE MANAGEMENT
function updateAndUpgrade() {
	title "Update & Upgrade"

	sudo dnf update -y
	sudo dnf upgrade -y
}

function optimiseDNF() {
	title "Opmise DNF"

	echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
	echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf

}

function enableRPMFusion() {
	title "Enable RPM Fusion Respositories"

	sudo dnf install \
		https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
	# Free
	sudo dnf install \
		https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	# Non Free
}

function enableFlathub() {
	title "Enable FlatHub"

	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

function installMediaCodecs() {
	title "Installing Media CODECs"

	sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
	sudo dnf install lame\* --exclude=lame-devel -y
	sudo dnf group upgrade --with-optional Multimedia
}


function setUserFolderDirectory() {
    title "Set User Folder Directory"

	locations=(
		"DOCUMENTS" 
		"MUSIC" 
		"PICTURES" 
		"VIDEOS"
		)
	directories=(
		"\"$HOME/Google Drive/Documents\""
		"\"$HOME/Google Drive/Music\""
		"\"$HOME/Google Drive/Photos\""
		"\"$HOME/Google Drive/Videos\""
		)
	arrayLength=${#locations[@]}

	for (( i=0; i<$arrayLength; i++ )); do
		echo "xdg-user-dirs-update --set ${locations[$i]} ${directories[$i]}"
	done
}

#^ DEVELOPMENT
function installJDK() {
	title "Instaling Java Development Environment"

	sudo rpm --import https://yum.corretto.aws/corretto.key -y
	sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
	sudo yum install -y java-17-amazon-corretto-devel
}

function installAndSetupGit() {
	title "Installing & Configuring Git"

	echo "Installing Git"
	sudo dnf install git -y
	echo "Configuring Git"
	git config --global user.name "Maruf Bepary"
	git config --global user.email "bepary71@gmail.com"
	git config --global core.autocrlf input
}

function configureGithubSSH() {
	title "Configuring SSH Keys for GitHub"

	ssh-keygen -t ed25519 -C "bepary71@gmail.com"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
	cat ~/.ssh/id_ed25519.pub
}

function installPostgres() {
	title "Installing PostgreSQL"

	sudo dnf install postgresql-server postgresql-contrib -y
	sudo systemctl enable postgresql
	sudo postgresql-setup --initdb --unit postgresql
	sudo systemctl start postgresql
}

function installPip() {
	title "Installing Pip"

	sudo dnf install pip3 -y
}

#^ APPS
function installFlathubAppsNonSystem() {
	title "Installing Non-System Flathub Apps"
	
	apps=(
		"io.dbeaver.DBeaverCommunity" 			# DBeaver - Database App
		"com.github.maoschanz.drawing" 			# Drawing - Paint App
		"com.mattjakeman.ExtensionManager" 		# Extensions Manager for Gnome
		"com.github.johnfactotum.Foliate" 		# Foliate - eBook Reader
		"de.haeckerfelix.Fragments" 			# Fragments - Torrent Client
		"org.gnome.Geary" 						# Geary - Email Client
		"fr.free.Homebank" 						# HomeBank - Personal Finance
		"rest.insomnia.Insomnia" 				# Insomnia - API Tool
		"com.github.alexhuntley.Plots" 			# Plots - Graphing Tool
		"com.github.flxzt.rnote" 				# rNote - Whiteboard App
		"it.mijorus.smile" 						# Smile - Emoji Picker
		"org.gnome.SoundRecorder" 				# Sound Recorder
		"com.wps.Office" 						# WPS Office
		"org.gnome.FileRoller" 					# File Roller - Archive Manager
		"org.gnome.Music" 						# Gnome Music
		"org.gnome.NetworkDisplays" 			# Network Displays
		"org.gnome.gitg" 						# Git GUI
		"com.github.tchx84.Flatseal" 			# FlatSeal - Flatpak permission manager
		)

	installFlathubApps "${apps[@]}"
}

function installFlathubAppsSystem() {
	title "Installing System Flathub Apps Alternatives"
	
	apps=(
		"org.gnome.Boxes" 						# Gnome Boxes - Virtualisation Tool
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
		)

	installFlathubApps "${apps[@]}"
}

function removeNativeSystemApps() {
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
		)

	removeNativeApps "${packages[@]}"

	sudo dnf autoremove -y
}

function installNativeApps() {
	packages=(
		"gnome-tweaks" 							# Gnome Tweaks
		"gnome-usage" 							# Gnome Usage
		"openssl"								# OpenSSL
		)

	for package in ${packages[@]}; do
		echo "sudo dnf install $package -y"
	done
}

#^ THEMES
function installLibadwaitaGTK3PortTheme() {
	title "Installing Libadwaita GTK-3 Theme Port"

	flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark -y
	dnf copr enable nickavem/adw-gtk3
	dnf install adw-gtk3
}

function applyThemeToFlatpaks() {
	title "Applying Themes to Unsupported Flatpak Apps"
	
	apps=(
		"org.gnome.eog" 						# Image Viewer
		"org.gnome.Totem" 						# Videos
		"org.gnome.Boxes" 						# Gnome Boxes - Virtualisation Tool
		"org.gnome.Maps" 						# Maps
		"org.gnome.Connections" 				# Connection - Remote Connection Tool
		"org.gnome.FileRoller" 					# File Roller - Archive Manager
		)

	for app in ${apps[@]}; do
		sudo flatpak override $app --env=GTK_THEME=adw-gtk3-dark
	done
}

function gnomeCustomisations() {
	title "Tweaking Some Gnome Functionalities"

	gsettings set org.gnome.SessionManager logout-prompt false 								# Disable Power Dialog
	gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close" # Enable Window Controls
}