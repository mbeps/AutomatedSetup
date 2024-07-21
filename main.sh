#!/bin/bash

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

function automated_normal() {
	cd "$HOME/Downloads"
	optimise_dnf
	update_upgrade
	enable_rpm_fusion
	enable_flathub
	install_media_codecs
	install_drivers

	remove_native_system_apps
	install_native_system_apps
	install_flathub_apps_system
	install_flathub_apps_non_system
	remove_preinstalled_flatpaks
	install_insync

	restore_extensions
	restore_extension_configuration
	enable_favourite_extensions

	install_fonts
	# install_windows_fonts

	gnome_customization
	gnome_fractional_scaling
	backup_general_configuration

	restore_keyboard_shortcuts

	set_bash
	set_user_folder_directory
	create_required_directories
	add_templates

	install_libadwaita_gtk3_port_theme
	apply_theme_to_native_apps
	firefox_gnome_theme
	restore_themes
	install_marble_shell_theme
	restore_svg_icons
}

function automated_dev() {
	automated_normal

	install_flathub_apps_dev
	install_developer_tools
	restore_terminal
	install_setup_git
	install_jdk
	install_java_maven
	install_python_pip
	install_python_poetry
	install_pyenv
	install_vscode
	install_node
	install_docker
	install_jdk
	configure_git_ssh
}

function automated_wsl_dev() {
	optimise_dnf
	update_upgrade
	enable_rpm_fusion

	set_bash

	install_setup_git
	install_postgres
	install_mysql
	install_python_pip
	install_python_poetry
	install_vscode
	install_node
	install_docker
	install_flathub_apps_development
	configure_git_ssh
}

"$@"
