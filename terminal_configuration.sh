# Contains funtions to configure Gnome Terminal. 

source "./dependencies.sh"

# Creates backup file for Gnome Terminal.
    # Saves dump file in `./resources/terminal/`
    # Source: https://askubuntu.com/questions/967517/backup-gnome-terminal
function backup_terminal() {
    title "Backing Up Gnome Terminal Configurations"

    dconf dump /org/gnome/terminal/ > ./resources/terminal/dump
}

# Restores the terminal configurations to its default settings. 
    # Source: https://askubuntu.com/questions/967517/backup-gnome-terminal
function reset_terminal() {
    title "Resetting Terminal Configuration to Defaults"

    dconf reset -f /org/gnome/terminal/
}