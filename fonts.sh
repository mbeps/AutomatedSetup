# Contains funtions to install various fonts.

source "./dependencies.sh"

# Install Cascadia Code Font from RPM repository. 
function installCascadiaCodeFont() {
	title "Installing Cascadia Code Font"

	package=("cascadia-fonts-all")
	installNativeApps "${package[@]}"
}

# Installs Microsoft Windows Proprietary fonts. 
	# Unzips fonts into the fonts folder. 
function installWindowsFonts() {
	title "Installing Windows Proprietary Fonts"

	unzip "./resources/fonts/windows/windows-fonts.zip" -d "/usr/share/fonts"
}

"$@"