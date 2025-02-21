#!/bin/sh

# Ensure the script runs with sudo privileges
if ! sudo -v; then
    echo "You need sudo privileges to run this script."
    exit 1
fi

# Install dependencies
sudo dnf install -y git make gcc libXft-devel libX11-devel libXinerama-devel @base-x

# Set up XDG directories
xdg_config_home=${XDG_CONFIG_HOME:-$HOME/.config}
xdg_data_home=${XDG_DATA_HOME:-$HOME/.local/share}

mkdir -p "$xdg_data_home/suckless"
cd "$xdg_data_home/suckless"

# Clone and install dwm, st, and dmenu
for app in dwm st dmenu; do
    if [ ! -d "$app" ]; then
        git clone "https://git.suckless.org/$app"
    else
        echo "$app is already cloned, skipping..."
    fi
    cd "$app"
    make
    sudo make clean install
    cd ..
done
 