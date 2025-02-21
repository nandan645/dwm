#!/bin/sh

# Ensure the script runs with sudo privileges
if ! sudo -v; then
    echo "You need sudo privileges to run this script."
    exit 1
fi

# Install dependencies
sudo dnf install -y git make gcc libXft-devel libX11-devel libXinerama-devel @base-x || { echo "Failed to install dependencies"; exit 1; }

# Set up XDG directories
xdg_config_home=${XDG_CONFIG_HOME:-$HOME/.config}
xdg_data_home=${XDG_DATA_HOME:-$HOME/.local/share}

mkdir -p "$xdg_data_home/suckless" || { echo "Failed to create directory"; exit 1; }
cd "$xdg_data_home/suckless" || { echo "Failed to change directory"; exit 1; }

# Clone, build, and install dwm, st, and dmenu
for app in dwm st dmenu; do
    if [ ! -d "$app" ]; then
        git clone "https://git.suckless.org/$app" || { echo "Failed to clone $app"; exit 1; }
    else
        echo "$app is already cloned, skipping..."
    fi
    cd "$app" || { echo "Failed to enter $app directory"; exit 1; }
    make || { echo "Make failed for $app"; exit 1; }
    sudo make clean install || { echo "Installation failed for $app"; exit 1; }
    cd ..
done

# Create .xinitrc file in the home directory
cat > "$HOME/.xinitrc" << 'EOF'
#!/bin/sh
# Continuously update the root window name with the current date and uptime
while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
do
    sleep 1
done &

# Start dwm as the window manager
exec dwm
EOF

# Make sure .xinitrc is executable
chmod +x "$HOME/.xinitrc"

echo "Installation complete. To launch dwm, run: startx"