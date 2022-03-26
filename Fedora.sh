function title() {
	clear
	echo $1
}

function updateAndUpgrade() {
	title "Update & Upgrade"
	sudo dnf update -y
}

function enable_rpm_fusion() {
	title "Enable RPM Fusion Respositories"
	sudo dnf install \ https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm # Free
	sudo dnf install \ https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm # Non Free
}

function enable_flathub() {
    title "Enable FlatHub"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}