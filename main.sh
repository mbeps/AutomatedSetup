source "./apps.sh"
source "./dependencies.sh"
source "./development.sh"
source "./drivers.sh"
source "./fonts.sh"
source "./gnome_configuration.sh"
source "./keyboard_shortcuts.sh"
source "./miscellaneous.sh"
source "./package_management.sh"
source "./theme.sh" 

optimiseDNF
updateAndUpgrade
enableRPMFusion
enableFlathub
installMediaCodecs

restore_keyboard_shortcuits

installCascadiaCodeFont
installWindowsFonts

installMicrosoftEdge
installInSync
removeNativeSystemApps
installFlathubAppsSystem
installFlathubAppsNonSystem
installLibadwaitaGTK3PortTheme
applyThemeToNativeApps
applyThemeToFlatpaks
gnomeCustomisations
gnomeFractionalScaling
setBash
createRequiredDirectories
setUserFolderDirectory
# mountUniServer
installDrivers

installAndSetupGit
installJDK
installMaven
installPostgres
installPip
installNode
installVSCode
configureGithubSSH