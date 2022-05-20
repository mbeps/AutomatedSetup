function title() {
	clear
	echo $1
}

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

function installMicrosoftFonts() {
	title "Installing Microsoft "
	sudo dnf install curl cabextract xorg-x11-font-utils fontconfig -y
	sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
}

function installMediaCodecs() {
	title "Installing Media CODECs"
	sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
	sudo dnf install lame\* --exclude=lame-devel -y
	sudo dnf group upgrade --with-optional Multimedia
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
	sudo dnf install postgresql-server postgresql-contrib
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
	title "Installing Non-System Flathub Apps" -y
	flatpak install flathub io.dbeaver.DBeaverCommunity -y # DBeaver - Database App
	flatpak install flathub com.github.maoschanz.drawing -y # Drawing - Paint App
	flatpak install flathub com.mattjakeman.ExtensionManager -y # Extensions Manager for Gnome
	flatpak install flathub com.github.johnfactotum.Foliate -y # Foliate - eBook Reader
	flatpak install flathub de.haeckerfelix.Fragments -y # Fragments - Torrent Client
	flatpak install flathub org.gnome.Geary -y # Geary - Email Client
	flatpak install flathub fr.free.Homebank -y # HomeBank - Personal Finance
	flatpak install flathub rest.insomnia.Insomnia -y # Insomnia - API Tool
	flatpak install flathub com.github.alexhuntley.Plots -y # Plots - Graphing Tool
	flatpak install flathub com.github.flxzt.rnote -y # rNote - Whiteboard App
	flatpak install flathub it.mijorus.smile -y # Smile - Emoji Picker
	flatpak install flathub org.gnome.SoundRecorder -y # Sound Recorder
	flatpak install flathub com.wps.Office -y # WPS Office
	flatpak install flathub org.gnome.FileRoller # FlatSeal - Flatpak Permission Manager
	flatpak install flathub org.gnome.Music # Gnome Music
	flatpak install flathub org.gnome.NetworkDisplays # Network Displays
	flatpak install flathub org.gnome.gitg # Git GUI
}

function installFlathubAppsSystem() {
	title "Installing System Flathub Apps Alternatives" -y
	flatpak install flathub org.gnome.Boxes -y # Gnome Boxes - Virtualisation Tool
	flatpak install flathub org.gnome.Calculator -y  # Gnome Boxes - Virtualisation Tool
	flatpak install flathub org.gnome.Calendar -y # Calendar
	flatpak install flathub org.gnome.clocks -y # Clocks
	flatpak install flathub org.gnome.Connections -y # Connection - Remote Connection Tool
	flatpak install flathub org.gnome.Contacts -y # Contacts
	flatpak install flathub org.gnome.baobab -y # Disk Analyser
	flatpak install flathub org.gnome.eog -y # Image Viewer
	flatpak install flathub org.gnome.Maps -y # Maps
	flatpak install flathub org.gnome.TextEditor -y # Text Editor
	flatpak install flathub org.gnome.Totem -y # Videos
	flatpanamek install flathub org.gnome.Weather -y # Weather
}

function removeNativeSystemApps() {
	title "Remove Native System Apps for Flatpak Alternatives"

	sudo dnf remove gnome-boxes -y # Gnome Boxes - Virtualisation Tool
	sudo dnf remove gnome-calculator -y  # Gnome Boxes - Virtualisation Tool
	sudo dnf remove gnome-calendar -y # Calendar
	sudo dnf remove gnome-clocks -y # Clocks
	sudo dnf remove gnome-connections -y # Connection - Remote Connection Tool
	sudo dnf remove gnome-contacts -y # Contacts
	sudo dnf remove gnome-connections -y # Connection - Remote Connection Tool
	sudo dnf remove gnome-maps -y # Maps
	sudo dnf remove gnome-text-editor -y # Text Editor
	sudo dnf remove gnome-weather -y # Weather

	sudo dnf autoremove -y
}

function installNativeApps() {
	title "Installing Required Native Apps"
	sudo dnf install gnome-tweaks -y # Gnome Tweaks
	sudo dnf install gnome-usage -y # Gnome Usage
	sudo dnf install openssl -y # OpenSSL
}

#^ THEMES
function installLibadwaitaGTK3PortTheme() {
	title "Installing Libadwaita GTK-3 Theme Port"
	flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
	dnf copr enable nickavem/adw-gtk3
	dnf install adw-gtk3
}

function applyThemeToFlatpaks() {
	title "Applying Themes to Unsupported Flatpak Apps"
	sudo flatpak override org.gnome.eog --env=GTK_THEME=adw-gtk3-dark # Image Viewer
	sudo flatpak override org.gnome.Totem --env=GTK_THEME=adw-gtk3-dark # Videos
	sudo flatpak override org.gnome.Boxes --env=GTK_THEME=adw-gtk3-dark # Boxes
	sudo flatpak override org.gnome.Maps --env=GTK_THEME=adw-gtk3-dark # Maps
	sudo flatpak override org.gnome.Connections --env=GTK_THEME=adw-gtk3-dark # Connections
}

function gnomeCustomisations() {
	title "Tweaking Some Gnome Functionalities"
	gsettings set org.gnome.SessionManager logout-prompt false # Disable Power Dialog
	gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close" # Enable Window Controls

}