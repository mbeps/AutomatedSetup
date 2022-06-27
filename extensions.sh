# Contains funtions to configure Gnome Shell Extensions. 

source "./dependencies.sh"

# Installs all the extensions into `~/.local/share/gnome-shell/extensions/`
    # Unzips th archive containing the extensions into the extensions folder. 
function restore_extensions() {
   title "Restoring Extensions"

   unzip "./resources/extensions/extensions.zip" -d "$HOME/.local/share/gnome-shell/extensions/"
}

# Creates backup file for Gnome Shell Extensions.
    # Saves dump file in `./resources/extensions/`
    # Source: https://www.reddit.com/r/gnome/comments/afuw4h/moving_extensions_and_their_settings_to_new/
function backup_extension_configuration() {
    title "Backing Up Extensions Configuration"

    dconf dump /org/gnome/shell/extensions/ > ./resources/extensions/extension-settings.dconf
}

# Restores the terminal configurations from backed up dump file. 
    # Dump saved in `./resources/extensions/`
    # Source: https://www.reddit.com/r/gnome/comments/afuw4h/moving_extensions_and_their_settings_to_new/
function restore_extension_configuration() {
    title "Restoring Up Extensions Configuration"

    dconf load /org/gnome/shell/extensions/ < ./resources/extensions/extension-settings.dconf
}

"$@"