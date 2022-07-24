# About 
This is an automated tool that automatically sets up Fedora. There is a fully automated set up which sets up all settings automatically or options can be called manually. 

# Usage
`apps.sh`:
* `automated` - automatically sets up environment 
* `install_flathub_apps_non_system` - installs certain Flatpak apps which are not part of the system
* `install_flathub_apps_system` - installs certain Flatpak apps which are alternatives to some system apps
* `remove_native_system_apps` - removes certain natively packaged app which are replaced by Flatpak versions
* `install_native_system_apps` - installs certain natively packaged apps which are required and do not have suitable Flatpak versions
* `install_insync` - installs InSync which syncs between cloud and local 
* `install_microsoft_edge` - installs Microsoft Edge web browser

[`development.sh`](development.sh)
* `install_setup_git` - installs and sets up Git version control system with correct name, email and end of line character
* `configure_github_ssh` - configures GitHub SSH to create required key to link to GitHub account
* `install_jdk` - installs Java Development Kit (JDK)
* `install_java_maven` - installs Maven project manager for Java
* `install_postgres` - installs PostgreSQL database
* `install_python_pip` - installs Pip package manager for Python
* `install_python_poetry` - installs Poetry project manager for Python
* `install_vscode` - installs Visual Studio Code editor
* `install_node_via_package_manager` - installs Node.JS 16 LTS via the native package manager 
* `install_node_via_nvm` - installs Node.JS 16 LTS via the Node Version Manager (NVM)
* `install_node` - installs Node.JS 16 LTS 

`drivers.sh`
* `install_drivers` - installs required drivers 
* `install_media_codecs` - installs media CODECs

`extensions.sh`
* `restore_extensions` - restores backed up Gnome extensions 
* `backup_extensions` - backs up Gnome extensions currently installed 
* `enable_favourite_extensions` - enables Gnome extensions to improve the Gnome experience
* `backup_extension_configuration` - backs up settings and configurations for Gnome extensions
* `restore_extension_configuration` - restores settings and configurations for Gnome extensions

`fonts.sh` 
* `install_cascadia_code_font` - installs the Cascadia Code font
* `install_windows_fonts` - installs Windows proprietary fonts

`gnome_configuration.sh`
* `gnome_customization` - tweaks built-in settings to improve the Gnome experience
* `gnome_fractional_scaling` - enables fractional scaling or Gnome

`keyboard_shortcuts.sh`
* `backup_keyboard_shortcuts` - backs up Gnome keyboard shortcuts
* `restore_keyboard_shortcuts` - restores Gnome keyboard shortcuts from backup 

'miscellaneous.sh'
* `set_bash` - adds custom configurations to the Bash shell such as aliases and theming
* `set_user_folder_directory` - configures custom user folder locations to sync with Google Drive
* `mount_university_server` - mounts university server into file system for easy access of files
* `create_required_directories` - creates required directories 

`package_management`
* `enable_rpm_fusion` - enables RPM Fusion repositories 
* `enable_flathub` - enables full FlatHub repositories for Flatpaks

`terminal_configuration.sh`
* `backup_terminal` - backs up Gnome Terminal configurations
* `restore_terminal` - restores Gnome Terminal configurations from back up
* `reset_terminal` - resets Gnome Terminal to default configurations 