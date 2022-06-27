# Contains funtions to configure Gnome Shell Extensions. 

source "./dependencies.sh"

# Creates backup file for Gnome Shell Extensions.
    # Saves dump file in `./resources/extensions/`
    # Source: https://www.reddit.com/r/gnome/comments/afuw4h/moving_extensions_and_their_settings_to_new/
function backup_extension() {
    dconf dump /org/gnome/shell/extensions/ > ./resources/extensions/extension-settings.dconf
}

# Restores the terminal configurations from backed up dump file. 
    # Dump saved in `./resources/extensions/`
    # Source: https://www.reddit.com/r/gnome/comments/afuw4h/moving_extensions_and_their_settings_to_new/
function restore_extension() {
    dconf load /org/gnome/shell/extensions/ < ./resources/extensions/extension-settings.dconf
}

"$@"