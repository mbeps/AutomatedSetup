# Contains functions to configure Gnome Terminal. 

source "./dependencies.sh"

original="/org/gnome/terminal/"
backup="./resources/terminal/dump"

# Creates backup file for Gnome Terminal.
	# Saves dump file in `./resources/terminal/`
	# Source: https://askubuntu.com/questions/967517/backup-gnome-terminal
function backup_terminal() {
	title "Backing Up Gnome Terminal Configurations"

	backup_configuration $backup $original
}

# Restores the terminal configurations to its default settings. 
	# Source: https://askubuntu.com/questions/967517/backup-gnome-terminal
function reset_terminal() {
	title "Resetting Gnome Terminal Configuration to Defaults"

	dconf reset -f $original
}

# Restores the terminal configurations from backed up dump file. 
	# Dump saved in `./resources/terminal/`
	# Source: https://askubuntu.com/questions/967517/backup-gnome-terminal
function restore_terminal() {
	title "Restores Gnome Terminal Configuration"

	restore_configuration $original $backup
}

"$@"