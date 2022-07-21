# Contains funtions for various miscellaneous configurations. 

source "./dependencies.sh"

# Adds some settings to bashrc. 
	# Adds some aliases for quick commands.
	# Adds custom bash prompt.  
function set_bash() { 
	title "Setting Up Bash"

	settings=(
		"export PS1='\[\e[0;1;91m\]\u\[\e[0;2;91m\]@\[\e[0;3;91m\]\h\[\e[0m\]:\[\e[0;2m\]/\[\e[0;38;5;39m\]\W\[\e[0;2m\]/\[\e[0;92m\]$(git branch 2>/dev/null | grep '"'"'^*'"'"' | colrm 1 2) \[\e[0m\]$ \[\e[0m\]'"  					 # Custom Bash Prompt 
		"alias editor=\"flatpak run org.gnome.TextEditor\"" 				# Sets Gnome Editor 
		"alias postgres-stop=\"sudo systemctl stop postgresql\"" 			# Stop Postgres
		"alias postgres-start=\"sudo systemctl start postgresql\"" 			# Start Postgres
		"alias git-sync=\"git pull && git push\"" 							# Git Pull and Push
		"alias mount-uni=\"sshfs zjac268@linux.cim.rhul.ac.uk:/home/cim/ug/zjac268 \\\"/home/maruf/Remotes/Royal Holloway Linux Server/\\\"\"" # Mount University Drive
		"alias layout-windows=\"gnome-extensions disable dash-to-dock-cosmic-@halfmexicanhalfamazing@gmail.com && gnome-extensions disable Vitals@CoreCoding.com && gnome-extensions enable dash-to-panel@jderose9.github.com\""
		"alias layout-personal=\"gnome-extensions enable dash-to-dock-cosmic-@halfmexicanhalfamazing@gmail.com && gnome-extensions enable Vitals@CoreCoding.com && gnome-extensions disable dash-to-panel@jderose9.github.com\""
	)
	for line in "${settings[@]}"; do # Adding settings
		echo "$line" | tee -a ~/.bashrc
	done
}

# Sets custom user folders. 
	# Allows Google Drive folders to be the defaults. 
	# Sync between computer and Google Drive. 
	# Source: https://askubuntu.com/questions/67044/change-default-user-folders-path
function set_user_folder_directory() { 
	title "Set User Folder Directory"

	locations=(
		"DOCUMENTS" 
		"MUSIC" 
		"PICTURES" 
		"VIDEOS"
		)
	directories=(
		"/home/maruf/Google Drive/Documents"
		"/home/maruf/Google Drive/Music"
		"/home/maruf/Google Drive/Photos"
		"/home/maruf/Google Drive/Videos"
		)
	arrayLength=${#locations[@]}

	for (( i=0; i<$arrayLength; i++ )); do
		xdg-user-dirs-update --set ${locations[$i]} "${directories[$i]}"
	done
}

# Mounts the user folder from Royal Holloway Linux Server into file system for easier access. 
	# Will ask for password which is normally used as log in. 
	# Source: https://youtu.be/fgEk9Q93FjE
function mount_university_server() {
	title "Mounting Royal Holloway Linux Server into File System"

	sshfs zjac268@linux.cim.rhul.ac.uk:/home/cim/ug/zjac268 "/home/maruf/Remotes/Royal Holloway Linux Server/"
}

# Creates all the directories required for personal use. 
	# Development, Remote and Wallpapers
function create_required_directories() {
	title "Creating All Required Directories"

	mkdir ~/Development
	mkdir "$HOME/Remotes/Royal Holloway Linux Server"
	mkdir Wallpapers
}

"$@"