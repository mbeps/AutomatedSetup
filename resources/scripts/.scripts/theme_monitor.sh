#!/bin/bash

apply_theme() {
    if [ "$1" == "'prefer-dark'" ]; then
        # Apply dark themes
        gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        dconf write /org/gnome/shell/extensions/user-theme/name "'Marble-gray-dark'"
    else
        # Apply light themes
        gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
        gsettings set org.gnome.desktop.interface color-scheme 'default'
        dconf write /org/gnome/shell/extensions/user-theme/name "'Marble-gray-light'"
    fi
}

# Apply theme based on the current color scheme
current_scheme=$(gsettings get org.gnome.desktop.interface color-scheme)
apply_theme "$current_scheme"

# Monitor for changes in the color scheme
gsettings monitor org.gnome.desktop.interface color-scheme | while read -r line; do
    # Extract the new color scheme value
    new_scheme=$(echo "$line" | awk -F": " '{print $2}')
    apply_theme "$new_scheme"
done
