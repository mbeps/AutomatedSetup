# Contains functions to configure various Gnome settings. 

source "./dependencies.sh"

# Makes some tweaks for improving Gnome. 
	# Disables power promps when shutting down, restarting, logging, etc. 
	# Enables window controls such as minimise and maximise.  
function gnome_customization() { 
	title "Tweaking Some Gnome Functionalities"

	gsettings set org.gnome.SessionManager logout-prompt false 								# Disable Power Dialog
	gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close" # Enable Window Controls
	gsettings set org.gnome.desktop.interface show-battery-percentage true 					# Enable Battery Percentage
	gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'minimize'		# Middle click title bar to minimise
	gsettings set org.gnome.shell.app-switcher current-workspace-only true		# Show apps from current workspace only
	gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'			# Disable mouse acceleration
	gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true 			# Enable tap to click on touchpad
}

# Enables experimental support for fractional scaling. 
	# Both Wayland and X11
	# Source: https://www.linuxuprising.com/2019/04/how-to-enable-hidpi-fractional-scaling.html
function gnome_fractional_scaling() {
	title "Enabling Fractional Scaling"

	gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']" 	# Wayland
	# gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']" 	# X11
	# gsettings reset org.gnome.mutter experimental-features 								# Reset
}

# Backs up general Gnome configurations. 
function backup_general_configuration() { 
	dconf dump /org/gnome/mutter/draggable-border-width/ >> ./resources/general-gnome-settings/draggable-border-width
	dconf dump /org/gnome/terminal/legacy/ >> ./resources/general-gnome-settings/terminal
	dconf dump /org/gnome/software/ >> ./resources/general-gnome-settings/gnome-software
}

# Restores general Gnome configurations from dconf files. 
function restore_general_configuration() { 
	cat ./resources/general-gnome-settings/draggable-border-width | dconf load /org/gnome/mutter/draggable-border-width/
	cat ./resources/general-gnome-settings/terminal | dconf load /org/gnome/terminal/legacy/
	cat ./resources/general-gnome-settings/gnome-software | dconf load /org/gnome/software/
}

"$@"