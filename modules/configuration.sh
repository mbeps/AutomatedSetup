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

# Backs up dconf configurations from list. 
	# Args:
		# - $1: name and location configuration to be backed up
		# - $2: name and location of backup file
	# Source: https://www.reddit.com/r/gnome/comments/l3ha66/how_to_export_and_import_all_gnome_keyboard/?utm_source=share&utm_medium=web2x&context=3
function backup_configurations() { backups=$1; originals=$2
	backups_length=${#backups[@]}
	originals_length=${#originals[@]}

	if [[ backups_length -eq originals_length]]
	then
		for i in "${!backups[@]}"; do
  			backup_configuration "${backups[$i]}" "${originals[$i]}"
	fi
}

# Restores dconf configurations from list.  
	# Args:
		# - $1: list of names and locations of backed up configurations 
		# - $2: list of names and locations of configuration to be restored
	# Source: https://www.reddit.com/r/gnome/comments/l3ha66/how_to_export_and_import_all_gnome_keyboard/?utm_source=share&utm_medium=web2x&context=3
function restore_configurations() { originals=$1; backups=$2
	backups_length=${#backups[@]}
	originals_length=${#originals[@]}

	if [[ backups_length -eq originals_length]]
	then
		for i in "${!backups[@]}"; do
  			restore_configuration "${originals[$i]}" "${backups[$i]}" 
	fi
}