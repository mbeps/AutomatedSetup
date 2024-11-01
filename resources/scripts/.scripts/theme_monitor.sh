#!/bin/bash

apply_theme() {
    color_scheme="$1"
    accent_color="$2"

    # Map GNOME accent colors to Marble theme colors
    declare -A color_map=(
        ["red"]="red"
        ["green"]="green"
        ["blue"]="blue"
        ["yellow"]="yellow"
        ["purple"]="purple"
        ["slate"]="gray"
    )

    # Default to 'gray' if the accent color doesn't have a corresponding Marble theme
    marble_color="${color_map[$accent_color]:-gray}"

    if [ "$color_scheme" == "'prefer-dark'" ]; then
        # Apply dark themes
        gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        dconf write /org/gnome/shell/extensions/user-theme/name "'Marble-${marble_color}-dark'"
    else
        # Apply light themes
        gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
        gsettings set org.gnome.desktop.interface color-scheme 'default'
        dconf write /org/gnome/shell/extensions/user-theme/name "'Marble-${marble_color}-light'"
    fi
}

# Get the initial values
current_scheme=$(gsettings get org.gnome.desktop.interface color-scheme)
current_accent=$(gsettings get org.gnome.desktop.interface accent-color | tr -d "'")

apply_theme "$current_scheme" "$current_accent"

# Monitor for changes in both settings
(gsettings monitor org.gnome.desktop.interface color-scheme &
gsettings monitor org.gnome.desktop.interface accent-color) | while read -r line; do
    # Get updated values
    current_scheme=$(gsettings get org.gnome.desktop.interface color-scheme)
    current_accent=$(gsettings get org.gnome.desktop.interface accent-color | tr -d "'")
    apply_theme "$current_scheme" "$current_accent"
done
