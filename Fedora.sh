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
	sudo dnf install \ https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm # Free
	sudo dnf install \ https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm # Non Free
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
	sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
	sudo dnf install lame\* --exclude=lame-devel
	sudo dnf group upgrade --with-optional Multimedia
}

#^ DEVELOPMENT
function installJDK() {
    title "Instaling Java Development Environment"
    sudo rpm --import https://yum.corretto.aws/corretto.key 
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

function installPostgres() {
	title "Installing PostgreSQL"
	sudo dnf install postgresql-server postgresql-contrib -y
    sudo systemctl enable postgresql
    sudo postgresql-setup --initdb --unit postgresql
    sudo systemctl start postgresql
}

function installNativeApps() {
    title "Installing Natively Packaged Apps"
    sudo dnf install gnome-tweak-tool -y
}

function removeApps() {
    title "Remove Unnecessary Native Apps"
    sudo dnf remove gedit -y
}