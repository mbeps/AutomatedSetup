function title() {
	clear
	echo $1
}


function setUserFolderDirectory() {
    title "Set User Folder Directory"
    xdg-user-dirs-update --set DOCUMENTS "$HOME/Google Drive/Documents"
    xdg-user-dirs-update --set MUSIC "$HOME/Google Drive/Music"
    xdg-user-dirs-update --set PICTURES "$HOME/Google Drive/Photos"
    xdg-user-dirs-update --set VIDEOS "$HOME/Google Drive/Videos"
}

#^ APPS
function installFlatpakApps() {
    title "Installing Flatpak Apps"
    flatpak install flathub it.mijorus.smile
    flatpak install flathub com.usebottles.bottles
    flatpak install flathub com.github.alexhuntley.Plots
    flatpak install flathub org.gnome.gitg
    flatpak install flathub rest.insomnia.Insomnia
    flatpak install flathub io.github.lainsce.Quilter
    flatpak install flathub io.dbeaver.DBeaverCommunity
    flatpak install flathub org.signal.Signal
    flatpak install flathub com.wps.Office
    flatpak install flathub org.onlyoffice.desktopeditors
    flatpak install flathub fr.free.Homebank
    flatpak install flathub com.bitwarden.desktop
    flatpak install flathub org.gnome.Music
    flatpak install flathub org.gnome.Geary
    flatpak install flathub sa.sy.bluerecorder
    flatpak install flathub org.gnome.Connections
    flatpak install flathub com.mattjakeman.ExtensionManager
    flatpak install flathub com.github.maoschanz.drawing
    flatpak install flathub de.haeckerfelix.Fragments
    flatpak install flathub com.github.johnfactotum.Foliate
    flatpak install flathub com.github.flxzt.rnote
    flatpak install flathub org.gnome.Boxes
    
    flatpak install flathub org.gnome.SoundRecorder
    flatpak install flathub org.gnome.NetworkDisplays
	flatpak install flathub org.gnome.TextEditor
}

#^ GNOME 
function gnomePowerDialog() {
	title "Disable Power Dialog for Gnome"
	gsettings set org.gnome.SessionManager logout-prompt false
}