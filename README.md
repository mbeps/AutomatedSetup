# Introduction & Overview
The main.sh script is a comprehensive system setup and configuration script designed to automate the process of configuring a Linux-based system. It brings together a collection of functions from various script files to handle tasks such as package management, application installation, font installation, theme setup, GNOME configuration, keyboard shortcuts, and more. By executing the main.sh script, users can easily set up their system according to their desired configuration.

## Overview
The main.sh script serves as the entry point for initiating system setup and configuration. It sources multiple script files that contain functions related to different aspects of system configuration. These script files include `apps.sh`, `dependencies.sh`, `development.sh`, `drivers.sh`, `fonts.sh`, `gnome_configuration.sh`, `keyboard_shortcuts.sh`, `miscellaneous.sh`, `package_management.sh`, `theme.sh`, `terminal_configuration.sh`, and `extensions.sh`.

The script provides three main functions: `automated_normal`, `automated_dev`, and `automated_wsl_dev`:

- The `automated_normal` function performs the automated setup for a normal system. It includes optimizations, package management, application installation, configuration tweaks, font installation, theme setup, extension restoration, and more.

- The `automated_dev` function extends the automated_normal setup and includes additional development-related tools and configurations. It installs developer tools, sets up Git, installs Java Development Kit (JDK), Maven, Python tools (Pip and Poetry), Visual Studio Code, Node.js, Docker, and more.

- The `automated_wsl_dev` function is specifically designed for Windows Subsystem for Linux (WSL) development environments. It includes optimizations, package management, Bash configuration, Git setup, database installations (PostgreSQL and MySQL), Python setup, Visual Studio Code installation, Node.js setup, Docker installation, and more.

By executing the main.sh script with the appropriate function, users can streamline the setup process and configure their system with the desired settings and tools.

It's important to review and modify the script based on specific requirements and system setup before executing it.

# Using the Script

To use the main.sh script, follow these steps:

1. Open a terminal on your Linux-based system.

2. Navigate to the directory where the main.sh script is located.

3. Execute the script with the desired function by running the following command:
   ```
   bash ./main.sh function_name
   ```

   Replace "function_name" with one of the available functions:
   - For a normal system setup, use `automated_normal`.
   - For a development-oriented system setup, use `automated_dev`.
   - For a Windows Subsystem for Linux (WSL) development setup, use `automated_wsl_dev`.

4. The script will start executing the selected function, performing various tasks such as package management, application installation, configuration tweaks, font installation, theme setup, and more.

5. Monitor the terminal output for any prompts or instructions during the execution of the script. Follow the prompts and provide any required input as needed.

6. Once the script completes the execution of the selected function, the system will be configured according to the specified setup.

Note: It is recommended to review and modify the script according to your specific requirements and system setup before executing it. Make sure to understand the actions performed by each function and ensure compatibility with your system.

The `main.sh` file serves as the entry point for executing the various functions related to system setup and configuration. Here's an overview of the functions and their purpose:

## Files

### `automated_normal`
This function performs the automated setup for a normal system, including optimizations, package management, application installation, configuration tweaks, font installation, theme setup, extension restoration, and more.

### `automated_dev`
This function extends the `automated_normal` setup and includes additional development-related tools and configurations such as developer tools installation, Git setup, JDK installation, Python setup, Visual Studio Code installation, Node.js setup, Docker installation, and more.

### `automated_wsl_dev`
This function is specifically designed for Windows Subsystem for Linux (WSL) development environments. It includes optimizations, package management, Bash configuration, Git setup, database installations (PostgreSQL and MySQL), Python setup, Visual Studio Code installation, Node.js setup, Docker installation, and more.

By calling one of these functions, you can initiate the automated setup process and execute the corresponding tasks for your desired system configuration.

Please note that executing these functions may require appropriate permissions and access to repositories and resources. Make sure to review and modify the scripts based on your specific requirements and system setup.

## Dependencies
> This file contains resources (functions and variables) which are critical to other files' execution.
[`dependencies.sh`](dependencies.sh)

### `title`
Displays a title for functions and clears previous output.

### `install_flathub_apps`
Installs FlatHub apps from a list of apps.

### `install_native_apps`
Installs native apps and packages from a list.

### `remove_native_apps`
Removes native apps and packages from a list.

### `enable_extensions`
Enables Gnome Shell extensions from a list.

### `split_archive`
Takes an archive and splits it into segments of 90MB each. This is useful for size constraints on platforms like GitHub.


## Package Management
> Contains functions for package management for RPM and Flatpak.
[`package_management.sh`](package_management.sh)

### `update_upgrade`
Updates and upgrades packages in the system using the `dnf` package manager.

### `optimise_dnf`
Optimizes the `dnf` package manager's performance by increasing the number of parallel downloads.

### `enable_rpm_fusion`
Enables RPM Fusion repositories for added packages and apps. This includes enabling the free (Open Source) and non-free (Closed Source / Proprietary) catalog.

### `enable_flathub`
Enables FlatHub repositories for Flatpaks, allowing access to additional apps.


## Apps
> Contains functions to install various apps from various sources.
[`apps.sh`](apps.sh)

### `install_flathub_apps`
Installs Flatpak apps (from FlatHub) which were not part of the system. These are additional apps that were not preinstalled.

### `remove_preinstalled_flatpaks`
Removes preinstalled Flatpak apps.

### `remove_native_system_apps`
Removes some preinstalled native apps in favor of Flatpak versions of the same apps.

### `install_native_system_apps`
Installs some native apps that were not part of the system. These apps do not have suitable Flatpak versions.

### `install_insync`
Installs InSync for syncing Google Drive with the main file system. It adds all the necessary keys and repositories.


## Development
> Contains functions to install and configure the development environment.
[`development.sh`](development.sh)

### `install_setup_git`
Installs Git version control system and sets up user configurations.

### `install_developer_tools`
Installs the recommended development packages.

### `configure_git_ssh`
Configures SSH key for GitHub.

### `install_jdk`
Installs Java Development Kit (JDK) for Java development.

### `install_java_maven`
Installs Maven project manager for Java.

### `install_python_pip`
Installs Pip package manager for Python.

### `install_python_poetry`
Installs Poetry Project Manager for Python.

### `install_pyenv`
Installs PyEnv for Python version management.

### `install_vscode`
Installs Visual Studio Code.

### `install_node_via_nvm`
Installs Node.JS via Node Version Manager (NVM).

### `install_node`
Installs Node.JS and Yarn.

### `install_docker`
Installs Docker.

### `install_flathub_apps_development`
Installs FlatHub apps required for development.


## Drivers and CODECs
> Contains functions to install drivers and CODECs.
[`drivers.sh`](drivers.sh)

### `install_drivers`
Installs required drivers which are not shipped by default. This includes media drivers.

### `install_media_codecs`
Installs media codecs for added video support and video playback performance.


## Gnome Shell Extensions
> Contains functions to configure Gnome Shell Extensions.
[`extensions.sh`](extensions.sh)

### `restore_extensions`
Installs all the extensions into `~/.local/share/gnome-shell/extensions/` by unzipping the archive containing the extensions.

### `backup_extensions`
Backs up all the installed extensions from `~/.local/share/gnome-shell/extensions/` by creating a Zip archive of all extensions.

### `enable_favourite_extensions`
Enables favorite extensions to configure Gnome Shell ideally. Not all installed extensions are enabled.

### `backup_extension_configuration`
Creates a backup file for Gnome Shell Extensions by saving a dump file in `./resources/extensions/`.

### `restore_extension_configuration`
Restores the terminal configurations from the backed-up dump file. The dump file is located in `./resources/extensions/`.


## Fonts
> Contains functions to install various fonts.
[`fonts.sh`](fonts.sh)

### `install_cascadia_code_font`
Installs Cascadia Code Font from the RPM repository.

### `install_windows_fonts`
Installs Microsoft Windows Proprietary fonts by unzipping the fonts into the fonts folder.

### `backup_windows_fonts`
Backs up Windows fonts stored in `/usr/share/fonts/windows/` by creating a Zip archive.

### `trim_fonts_backup`
Trims the backup archive of Windows fonts into segments of 90MB each, due to size limitations on platforms like GitHub.


## Gnome Settings Configuration
> Contains functions to configure various Gnome settings.
[`gnome_configuration.sh`](gnome_configuration.sh)

### `gnome_customization`
Makes some tweaks for improving Gnome. This includes disabling power prompts when shutting down, restarting, logging, etc., enabling window controls such as minimize and maximize, enabling battery percentage display, setting middle click on the title bar to minimize, showing apps from the current workspace only, disabling mouse acceleration, and enabling tap to click on the touchpad.

### `gnome_fractional_scaling`
Enables experimental support for fractional scaling in Gnome. This can be enabled for both Wayland and X11 sessions.

### `backup_general_configuration`
Backs up general Gnome configurations by creating dconf files for specific settings.

### `restore_general_configuration`
Restores general Gnome configurations from the backed-up dconf files.


## Keyboard Shortcuts
> Contains functions to backup and restore keyboard shortcuts.
[`keyboard_shortcuts.sh`](keyboard_shortcuts.sh)

### `backup_keyboard_shortcuts`
Creates backup files for various keyboard shortcuts by compiling shortcuts from various locations and saving dump files in `./resources/keyboard-shortcuts/`.

### `restore_keyboard_shortcuts`
Restores keyboard shortcuts from the dump files located in `./resources/keyboard-shortcuts/`.


## Miscellaneous Configurations
> Contains functions for various miscellaneous configurations.
[`miscellaneous.sh`](miscellaneous.sh)

### `set_bash`
Adds some settings to `.bashrc`, including aliases for quick commands and a custom bash prompt.

### `set_user_folder_directory`
Sets custom user folders and allows Google Drive folders to be the defaults. This enables synchronization between the computer and Google Drive.

### `mount_university_server`
Mounts the user folder from Royal Holloway Linux Server into the file system for easier access. This function requires entering the password used for login.

### `create_required_directories`
Creates all the directories required for personal use, including "Development," "Remotes," and "Wallpapers."

### `add_templates`
Adds templates for file types in the right-click menu.


## Terminal Configuration
> Contains functions to configure Gnome Terminal.
[`terminal_configuration.sh`](terminal_configuration.sh)

### `backup_terminal`
Creates a backup file for Gnome Terminal configurations by saving a dump file in `./resources/terminal/`.

### `reset_terminal`
Resets the Gnome Terminal configuration to its default settings.

### `restore_terminal`
Restores the terminal configurations from the backed-up dump file located in `./resources/terminal/`.


## Theme
> Contains functions to install and apply themes.
[`theme.sh`](theme.sh)

### `install_libadwaita_gtk3_port_theme`
Installs the Libadwaita GTK-3 theme port, which improves consistency between legacy apps and modern apps by providing a unified theme. This function installs the necessary packages and enables the theme.

### `apply_theme_to_native_apps`
Applies the Libadwaita theme port to native apps, ensuring consistent styling across the system. This function sets the GTK theme for native apps using GSettings.

### `firefox_gnome_theme`
Applies the Gnome theme to Firefox, providing a consistent look and feel between the browser and the Gnome desktop environment. This function installs the Firefox Gnome theme using a script.

### `restore_themes`
Imports themes by extracting the contents of the `themes.zip` file into the `~/.themes` directory.

### `restore_svg_icons`
Restores the ArcMenu icons by extracting the contents of the `icons.zip` file into the `~/.icons` directory.