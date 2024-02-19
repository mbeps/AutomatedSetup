#!/bin/bash

# ANSI escape code for red text
RED='\033[0;31m'
# ANSI escape code for green text
GREEN='\033[0;32m'
# ANSI escape code for bold text
BOLD='\033[1m'
# ANSI escape code to reset text color and style
NC='\033[0m' # No Color

# Separator
SEPARATOR="-------------------------------------------------------------------------------------------\n"

# Function for printing messages with color and separator
print_message() {
    local color=$1
    local message=$2
    local messageType=$3 # "heading" or "ending"

    if [ "$messageType" = "heading" ]; then
        echo -e "\n${SEPARATOR}${color}${BOLD}${message}${NC}\n"
    else
        echo -e "\n${color}${BOLD}${message}${NC}"
    fi
}

# Function to update the system using dnf
update_system() {
    print_message "$RED" "Updating System Packages..." "heading"
    sudo dnf update -y
    print_message "$GREEN" "System Packages Updated." "ending"
}

# Function to update flatpak applications
update_flatpak() {
    print_message "$RED" "Updating Flatpak Applications..." "heading"
    flatpak update -y
    print_message "$GREEN" "Flatpak Applications Updated." "ending"
}

# Function to upgrade poetry
upgrade_poetry() {
    print_message "$RED" "Upgrading Poetry..." "heading"
    pipx upgrade poetry
    print_message "$GREEN" "Poetry Upgraded." "ending"
}

# Function to upgrade Firefox Gnome Theme
upgrade_firefox_gnome_theme() {
    print_message "$RED" "Upgrading Firefox Gnome Theme..." "heading"
    curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash
    print_message "$GREEN" "Firefox Gnome Theme Upgraded." "ending"
}

# Main function to run all updates
main() {
    update_system
    update_flatpak
    upgrade_poetry
    upgrade_firefox_gnome_theme
    
    echo -e "$SEPARATOR"
    print_message "$GREEN" "All Updates Completed." "ending"
}

# Call the main function
main

