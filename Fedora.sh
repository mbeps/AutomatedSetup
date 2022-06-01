# Displays title for functions and clearns previous output. 
	# Args:
		# - $1: title to be printed. 
function title() {
	clear
	echo $1
}

#^ DEPENDENCIES
# Installs FlatHub apps from a list. 
	# Args:
		# - $1: array of apps
function installFlathubApps() {
	apps=$1
	for app in "${apps[@]}"; do
		flatpak install flathub $app -y
	done
}

# Installs native apps and packages from a list. 
	# Args:
		# - $1: array of packages
function installNativeApps() {
	packages=$1
	for package in "${packages[@]}"; do
		sudo dnf install $package -y
	done
}

# Removes native apps and packages from a list. 
	# Args:
		# - $1: array of apps
function removeNativeApps() {
	packages=$1
	for package in "${packages[@]}"; do
		sudo dnf remove $package -y
	done
}

#^ PACKAGE MANAGEMENT
# Updates and upgrades packages in the system. 
function updateAndUpgrade() {
	title "Update & Upgrade"

	sudo dnf update -y
	sudo dnf upgrade -y
}

# Opmisises DNF package manager performance. 
	# Chooses fastest server for downloads. 
	# Increases the number of parallel downloads. 
function optimiseDNF() { 
	title "Opmise DNF"

	echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf # Fastest server
	echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf # Max download
}

# Enables RPM Fusion repositories for added packages and apps. 
	# Enables free (Open Source) catalogue. 
	# Enables non-free (Closed Source / Proprietary) catalogue. 
	# Source: https://docs.fedoraproject.org/en-US/quick-docs/setup_rpmfusion/
function enableRPMFusion() { 
	title "Enable RPM Fusion Respositories"

	sudo dnf install \
		https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
	# Free
	sudo dnf install \
		https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
	# Non Free
}

# Enables FlatHub repositories for Flatpaks for added apps. 
	# Source: https://flatpak.org/setup/Fedora
function enableFlathub() { 
	title "Enable FlatHub"

	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

# Installs media codecs for added video support and video playback performance. 
	# Source: https://ostechnix.com/how-to-install-multimedia-codecs-in-fedora-linux/
function installMediaCodecs() { 
	title "Installing Media CODECs"

	sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
	sudo dnf install lame\* --exclude=lame-devel -y
	sudo dnf group upgrade --with-optional Multimedia -y
}

#^ DEVELOPMENT
# Installs Java Development Kit (JDK) for Java development. 
	# Source: https://docs.aws.amazon.com/corretto/latest/corretto-17-ug/generic-linux-install.html
function installJDK() { 
	title "Instaling Java Development Environment"

	sudo rpm --import https://yum.corretto.aws/corretto.key -y
	sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
	sudo yum install -y java-17-amazon-corretto-devel
}

# Installs Git version control system and sets up user configurations. 
	# Sets up user name, email and end of line setting. 
	# Source: https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup
function installAndSetupGit() { 
	title "Installing & Configuring Git"

	echo "Installing Git"
	sudo dnf install git -y
	
	echo "Configuring Git"
	git config --global user.name "Maruf Bepary"
	git config --global user.email "bepary71@gmail.com"
	git config --global core.autocrlf input
}

# Configures SSK key for GitHub.
	# Source: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
function configureGithubSSH() { 
	title "Configuring SSH Keys for GitHub"

	echo && echo && echo | ssh-keygen -t ed25519 -C "bepary71@gmail.com"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
	cat ~/.ssh/id_ed25519.pub
}

# Installs PostgreSQL database. 
	# Database will not be accessible via third-party Database Management Systems (DBMS). 
	# On `/var/lib/pgsql/data/pg_hba.conf`, edit `host all all 127.0.0.1/32 ident` to `host all all 127.0.0.1/32 md5`
	# Source: https://docs.fedoraproject.org/en-US/quick-docs/postgresql/
function installPostgres() { 
	title "Installing PostgreSQL"

	sudo dnf install postgresql-server postgresql-contrib -y
	sudo systemctl enable postgresql
	sudo postgresql-setup --initdb --unit postgresql
	sudo systemctl start postgresql
}

# Installs Pip package manager for Python. 
	# Source: https://www.osradar.com/install-pip-fedora-34/
function installPip() {
	title "Installing Pip"

	sudo dnf install python3-pip -y
}

# Installs Visual Studio Code. 
	# Adds all the necessary keys and repositories. 
	# Source: https://www.linuxcapable.com/how-to-install-visual-studio-code-vs-code-on-fedora-34-35/
function installVSCode() { 
	# https://www.linuxcapable.com/how-to-install-visual-studio-code-vs-code-on-fedora-34-35/
	title "Installing Visual Studio Code"

	respository=(
		"[vscode]"
		"name=Visual Studio Code"
		"baseurl=https://packages.microsoft.com/yumrepos/vscode"
		"enabled=1"
		"gpgcheck=1"
		"gpgkey=https://packages.microsoft.com/keys/microsoft.asc"
	)
	for line in "${respository[@]}"; do # Imports repository
		echo "$line" | sudo tee -a /etc/yum.repos.d/vscode.repo
	done
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc # Import GPG key
	sudo dnf install code -y
}

# Installs Node.JS via built-in package manager. 
	# This function is called by `installNode`. 
	# Source: https://nodejs.org/en/download/package-manager/#centos-fedora-and-red-hat-enterprise-linux
function installNodeViaPackageManager() {
	sudo dnf module install nodejs:16 -y
}

# Installs Node.JS via Node Version Manager (NVM). 
	# This function is called by `installNode`. 
	# Source: https://heynode.com/tutorial/install-nodejs-locally-nvm/
function installNodeViaNVM() { 
	# https://heynode.com/tutorial/install-nodejs-locally-nvm/
	curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh -o install_nvm.sh
	bash install_nvm.sh
	export NVM_DIR="$HOME/.nvm"
	nvm install --lts
}

# Installs Node.JS and Yarn. 
function installNode() {
	title "Installing Node.JS, NPM and Yarn"

	installNodeViaNVM
	npm install --global yarn
}

#^ APPS
# Installs Flatpak apps (from FlatHub) which were not part of the system. 
	# Extra apps which were not preinstalled. 
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

# Installs Flatpak apps (from FlatHub) as alternatives to some preinstalled native versions of the same apps. 
	# Flatpak versions of the apps that were preinstalled. 
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

# Removes some preinstalled native apps in favour of Flatpak versions of the same apps. 
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

# Installs some native apps that were not part of the system. 
	# Flatpak versions not available. 
function installNativeNonSystemApps() {
	packages=(
		"gnome-tweaks" 							# Gnome Tweaks
		"gnome-usage" 							# Gnome Usage
		"openssl"								# OpenSSL
		)

	installNativeApps "${packages[@]}"
}

# Installs InSync for syncing Google Drive with main file system. 
	# Adds all the necessary keys and repositories. 
	# Source: https://www.insynchq.com/downloads
function installInSync() { 
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
function installMicrosoftEdge() { 
	title "Installing Microsoft Edge"

	sudo dnf install dnf-plugins-core -y
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
	sudo dnf update --refresh
	sudo dnf install microsoft-edge-stable -y
}

#^ THEMES
# Installs Libadwaita port for legacy GTK-3. 
	# Improves consistency between legacy apps and modern apps. 
	# Source: https://github.com/lassekongo83/adw-gtk3
function installLibadwaitaGTK3PortTheme() { 
	title "Installing Libadwaita GTK-3 Theme Port"

	flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark -y
	sudo dnf copr enable nickavem/adw-gtk3 -y
	sudo dnf install adw-gtk3 -y
}

# Applies Libadwaita theme port to legacy apps. 
function applyThemeToNativeApps() { 
	title "Applying Themes to Native Apps"

	gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
}

# Applies theme to legacy Flatpak apps. 
	# Native app themes are sepparate from Flatpak apps. 
	# Source: https://itsfoss.com/flatpak-app-apply-theme/
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

	for app in "${apps[@]}"; do
		sudo flatpak override $app --env=GTK_THEME=adw-gtk3-dark
	done
}

# Makes some tweaks for improving Gnome. 
	# Disables power promps when shutting down, restarting, logging, etc. 
	# Enables window controls such as minimise and maximise.  
function gnomeCustomisations() { 
	title "Tweaking Some Gnome Functionalities"

	gsettings set org.gnome.SessionManager logout-prompt false 								# Disable Power Dialog
	gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close" # Enable Window Controls
	gsettings set org.gnome.desktop.interface show-battery-percentage true 					# Enable Battery Percentage
}

#^ OTHER
# Adds some settings to bashrc. 
	# Adds some aliases for quick commands.
	# Adds custom bash prompt.  
function setBash() { 
	title "Setting Up Bash"

	settings=(
		"export PS1='\[\e[0;1;91m\]\u\[\e[0;2;91m\]@\[\e[0;3;91m\]\h\[\e[0m\]:\[\e[0;2m\]/\[\e[0;38;5;39m\]\W\[\e[0;2m\]/\[\e[0;92m\]$(git branch 2>/dev/null | grep '"'"'^*'"'"' | colrm 1 2) \[\e[0m\]$ \[\e[0m\]'"  					 # Custom Bash Prompt 
		"alias editor=\"flatpak run org.gnome.TextEditor\"" 				# Sets Gnome Editor 
		"alias postgres-stop=\"sudo systemctl stop postgresql\"" 			# Stop Postgres
		"alias postgres-start=\"sudo systemctl start postgresql\"" 			# Start Postgres
		"alias git-sync=\"git pull && git push\"" 							# Git Pull and Push
	)
	for line in "${settings[@]}"; do # Adding settings
		echo "$line" | tee -a ~/.bashrc
	done
}

# Sets custom user folders. 
	# Allows Google Drive folders to be the defaults. 
	# Sync between computer and Google Drive. 
	# Source: https://askubuntu.com/questions/67044/change-default-user-folders-path
function setUserFolderDirectory() { 
    title "Set User Folder Directory"

	locations=(
		"DOCUMENTS" 
		"MUSIC" 
		"PICTURES" 
		"VIDEOS"
		)
	directories=(
		"/home/maruf/Google Drive/Documents"
		"/home/maruf/Google Drive/Music"
		"/home/maruf/Google Drive/Photos"
		"/home/maruf/Google Drive/Videos"
		)
	arrayLength=${#locations[@]}

	for (( i=0; i<$arrayLength; i++ )); do
		xdg-user-dirs-update --set ${locations[$i]} "${directories[$i]}"
	done
}

#^ MAIN
optimiseDNF
updateAndUpgrade
enableRPMFusion
enableFlathub
installMediaCodecs

installMicrosoftEdge
installInSync
removeNativeSystemApps
installFlathubAppsSystem
installFlathubAppsNonSystem
installLibadwaitaGTK3PortTheme
applyThemeToNativeApps
applyThemeToFlatpaks
gnomeCustomisations
setBash
setUserFolderDirectory

installAndSetupGit
installJDK
installPostgres
installPip
installNode
installVSCode
configureGithubSSH