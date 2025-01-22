#!/bin/bash

# Function to apply background color based on color scheme
apply_pano_background() {
    color_scheme="$1"

    if [ "$color_scheme" == "'prefer-dark'" ]; then
        # Apply dark background color
        dconf write /org/gnome/shell/extensions/pano/window-background-color "'rgb(36,36,36)'"
    else
        # Apply light background color
        dconf write /org/gnome/shell/extensions/pano/window-background-color "'rgb(242,242,242)'"
    fi
}

# Function to apply accent color based on system accent color
apply_pano_accent_color() {
    # Retrieve the current accent color setting
    accent_color=$(gsettings get org.gnome.desktop.interface accent-color)

    case "$accent_color" in
        "'blue'")
            dconf write /org/gnome/shell/extensions/pano/active-item-border-color "'rgb(53,132,228)'"
            dconf write /org/gnome/shell/extensions/pano/hovered-item-border-color "'rgb(53,132,228)'"
            ;;
        "'teal'")
            dconf write /org/gnome/shell/extensions/pano/active-item-border-color "'rgb(33,144,164)'"
            dconf write /org/gnome/shell/extensions/pano/hovered-item-border-color "'rgb(33,144,164)'"
            ;;
        "'green'")
            dconf write /org/gnome/shell/extensions/pano/active-item-border-color "'rgb(58,148,74)'"
            dconf write /org/gnome/shell/extensions/pano/hovered-item-border-color "'rgb(58,148,74)'"
            ;;
        "'yellow'")
            dconf write /org/gnome/shell/extensions/pano/active-item-border-color "'rgb(200,136,0)'"
            dconf write /org/gnome/shell/extensions/pano/hovered-item-border-color "'rgb(200,136,0)'"
            ;;
        "'orange'")
            dconf write /org/gnome/shell/extensions/pano/active-item-border-color "'rgb(237,91,0)'"
            dconf write /org/gnome/shell/extensions/pano/hovered-item-border-color "'rgb(237,91,0)'"
            ;;
        "'red'")
            dconf write /org/gnome/shell/extensions/pano/active-item-border-color "'rgb(230,45,66)'"
            dconf write /org/gnome/shell/extensions/pano/hovered-item-border-color "'rgb(230,45,66)'"
            ;;
        "'pink'")
            dconf write /org/gnome/shell/extensions/pano/active-item-border-color "'rgb(213,97,153)'"
            dconf write /org/gnome/shell/extensions/pano/hovered-item-border-color "'rgb(213,97,153)'"
            ;;
        "'purple'")
            dconf write /org/gnome/shell/extensions/pano/active-item-border-color "'rgb(145,65,172)'"
            dconf write /org/gnome/shell/extensions/pano/hovered-item-border-color "'rgb(145,65,172)'"
            ;;
        "'slate'")
            dconf write /org/gnome/shell/extensions/pano/active-item-border-color "'rgb(111,131,150)'"
            dconf write /org/gnome/shell/extensions/pano/hovered-item-border-color "'rgb(111,131,150)'"
            ;;
        *)
            # Default color if accent color is not recognized
            dconf write /org/gnome/shell/extensions/pano/active-item-border-color "'rgb(111,131,150)'"
            dconf write /org/gnome/shell/extensions/pano/hovered-item-border-color "'rgb(111,131,150)'"
            ;;
    esac
}

# Get the initial color scheme and accent color values
current_scheme=$(gsettings get org.gnome.desktop.interface color-scheme)
current_accent=$(gsettings get org.gnome.desktop.interface accent-color)

# Apply the initial background and accent colors
apply_pano_background "$current_scheme"
apply_pano_accent_color

# Use a trap to handle process cleanup
trap 'kill $(jobs -p)' EXIT

# Start monitors in background but wait for them
{
    gsettings monitor org.gnome.desktop.interface color-scheme | while read -r line; do
        current_scheme=$(gsettings get org.gnome.desktop.interface color-scheme)
        apply_pano_background "$current_scheme"
    done
} &

{
    gsettings monitor org.gnome.desktop.interface accent-color | while read -r line; do
        apply_pano_accent_color
    done
} &

# Keep the script running
wait
