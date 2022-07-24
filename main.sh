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

function automated() {
	optimise_dnf
	update_upgrade
	enable_rpm_fusion
	enable_flathub
	install_media_codecs
	install_drivers

	restore_keyboard_shortcuts

	install_cascadia_code_font
	install_windows_fonts

	install_microsoft_edge
	install_insync
	remove_native_system_apps
	install_flathub_apps_system
	install_flathub_apps_non_system
	install_libadwaita_gtk3_port_theme
	apply_theme_to_native_apps
	apply_theme_to_flatpaks
	gnome_customization
	gnome_fractional_scaling
	set_bash
	create_required_directories
	set_user_folder_directory
	# mount_university_server
	restore_terminal

	restore_extensions
	restore_extension_configuration
	enable_favourite_extensions

	install_setup_git
	install_jdk
	install_java_maven
	install_postgres
	install_python_pip
	install_python_poetry
	install_node
	install_vscode
	configure_github_ssh
}




"$@"