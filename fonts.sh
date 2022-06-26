# Contains funtions to install various fonts.

source "./dependencies.sh"

# Install Cascadia Code Font from RPM repository. 
function installCascadiaCodeFont() {
	title "Installing Cascadia Code Font"

	package=("cascadia-fonts-all")
	installNativeApps "${package[@]}"
}

# Installs Microsoft Windows Proprietary fonts. 
	# Copies fonts into the fonts folder. 
function installWindowsFonts() {
	title "Installing Windows Proprietary Fonts"

	cp ./resources/fonts/windows /usr/share/fonts
}