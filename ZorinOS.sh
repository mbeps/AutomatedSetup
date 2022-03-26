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