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
source "./terminal_configuration.sh"
source "./extensions.sh"

optimiseDNF
updateAndUpgrade
enableRPMFusion
enableFlathub
installMediaCodecs

restore_keyboard_shortcuts

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
restore_terminal

restore_extensions
restore_extension_configuration
enable_favourite_extensions

installAndSetupGit
installJDK
installMaven
installPostgres
installPip
installNode
installVSCode
configureGithubSSH


"$@"