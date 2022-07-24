# This module contains functions to manage dconfigurations. 

# Backs up dconf configurations. 
	# Args:
		# - $1: name and location configuration to be backed up
		# - $2: name and location of backup file
	# Source: https://www.reddit.com/r/gnome/comments/l3ha66/how_to_export_and_import_all_gnome_keyboard/?utm_source=share&utm_medium=web2x&context=3
function backup_configuration() { original=$1; backup=$2
	dconf dump "$original" >> "$backup"
	# dconf dump "$original" > "$backup"
}

# Restores dconf configurations. 
	# Args:
		# - $1: name and location of backed up configuration
		# - $2: name and location of configuration to be restored
	# Source: https://www.reddit.com/r/gnome/comments/l3ha66/how_to_export_and_import_all_gnome_keyboard/?utm_source=share&utm_medium=web2x&context=3
function restore_configuration() { backup=$1; original=$2
	cat "$backup" | dconf load "$original"
	# dconf load "$backup" < "$original"
}

# Resets dconf configurations. 
	# Args:
		# - $1: name and location of configuration to be reset
	# Source: https://askubuntu.com/questions/967517/backup-gnome-terminal
function reset_configuration() { target=$1
	dconf reset -f "$target"
}