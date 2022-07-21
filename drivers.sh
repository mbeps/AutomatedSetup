# Contains funtions to install drivers and CODECs.

source "./dependencies.sh"

# Installs required drivers which are not shipped by default. 
	# Installs media drivers
	# Source: https://www.reddit.com/r/intel/comments/l22le8/what_is_the_intelmediadriver/
function install_drivers() {
	title "Installing Required Drivers"

	drivers=(
		"libva-intel-driver"
		"intel-media-driver"
		"gstreamer1-vaapi"
	)
	install_native_apps "${drivers[@]}"
}

# Installs media codecs for added video support and video playback performance. 
	# Source: https://ostechnix.com/how-to-install-multimedia-codecs-in-fedora-linux/
function install_media_codecs() { 
	title "Installing Media CODECs"

	sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
	sudo dnf install lame\* --exclude=lame-devel -y
	sudo dnf group upgrade --with-optional Multimedia -y
}

"$@"