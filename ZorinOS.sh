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

#^ DEVELOOMENT
function installJDK() {
	title "Install Java Development Environment"
	 wget -O- https://apt.corretto.aws/corretto.key | sudo apt-key add - 
 sudo add-apt-repository 'deb https://apt.corretto.aws stable main'
  sudo apt-get update; sudo apt-get install -y java-17-amazon-corretto-jdk
}

function installAndSetupGit() {
	title "Installing & Configuring Git"
	echo "Installing Git"
	sudo apt install git
	echo "Configuring Git"
	git config --global user.name "Maruf Bepary"
	git config --global user.email "bepary71@gmail.com"
	git config --global core.autocrlf input
}