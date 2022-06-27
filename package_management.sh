# Contains functions for package menegement for RPM and Flatpak. 

source "./dependencies.sh"

# Updates and upgrades packages in the system. 
function updateAndUpgrade() {
	title "Update & Upgrade"

	sudo dnf update -y
	sudo dnf upgrade -y
}

# Opmisises DNF package manager performance. 
	# Increases the number of parallel downloads. 
function optimiseDNF() { 
	title "Opmise DNF"

	echo 'max_parallel_downloads=20' | sudo tee -a /etc/dnf/dnf.conf # Max download
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
	sudo dnf groupupdate core -y # Make apps visible on Gnome Store
}

# Enables FlatHub repositories for Flatpaks for added apps. 
	# Source: https://flatpak.org/setup/Fedora
function enableFlathub() { 
	title "Enable FlatHub"

	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

"$@"