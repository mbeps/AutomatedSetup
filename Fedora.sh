function title() {
	clear
	echo $1
}

function updateAndUpgrade() {
	title "Update & Upgrade"
	sudo dnf update -y
}