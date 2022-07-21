# Contains funtions to install various fonts.

source "./dependencies.sh"

# Install Cascadia Code Font from RPM repository. 
function install_cascadia_code_font() {
	title "Installing Cascadia Code Font"

	package=("cascadia-fonts-all")
	install_native_apps "${package[@]}"
}

# Installs Microsoft Windows Proprietary fonts. 
	# Unzips fonts into the fonts folder. 
function install_windows_fonts() {
	title "Installing Windows Proprietary Fonts"

	unzip "./resources/fonts/windows/windows-fonts.zip" -d "/usr/share/fonts"
}

"$@"