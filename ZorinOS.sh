function title() {
	clear
	echo $1
}

function updateAndUpgrade() {
	title "Update & Upgrade"
	sudo apt update -y
	sudo apt autoremove -y
	sudo apt upgrade -y
}

#^ USEFULL
function installMicrosoftFonts() {
	title "Install Microsoft Fonts"
	sudo add-apt-repository multiverse -y
	sudo apt install ttf-mscorefonts-installer -y
	sudo fc-cache -f -v
}

function installMediaCodecs() {
	title "Install Media Codecs"
	sudo add-apt-repository multiverse -y
	sudo apt install ubuntu-restricted-extras -y
}