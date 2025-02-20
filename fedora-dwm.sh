#!/bin/sh

# Ensure the script runs with sudo privileges
if ! sudo -v; then
    echo "You need sudo privileges to run this script."
    exit 1
fi

# Install dependencies
sudo dnf install -y git make gcc libXft-devel libX11-devel libXinerama-devel

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

# Ask if user wants to install a Display Manager
echo "Do you want to install a Display Manager? (y/n)"
read -r install_dm

if [ "$install_dm" = "y" ]; then
    echo "Choose a Display Manager:"
    echo "1) GDM (Default for Fedora)"
    echo "2) LightDM (Lightweight)"
    echo "3) SDDM (Used by KDE)"
    echo "4) No Display Manager (Use startx)"
    read -r dm_choice

    case $dm_choice in
        1) sudo dnf install -y gdm && sudo systemctl enable gdm ;;
        2) sudo dnf install -y lightdm lightdm-gtk && sudo systemctl enable lightdm ;;
        3) sudo dnf install -y sddm && sudo systemctl enable sddm ;;
        4) echo "Skipping Display Manager installation. You'll need to use 'startx'." ;;
        *) echo "Invalid choice, skipping DM installation." ;;
    esac
else
    echo "Skipping Display Manager installation. You'll need to use 'startx'."
fi

# If no DM is installed, set up ~/.xinitrc for startx
if [ "$dm_choice" = "4" ] || [ "$install_dm" = "n" ]; then
    echo "Setting up ~/.xinitrc for startx..."
    echo "exec dwm" > ~/.xinitrc
    chmod +x ~/.xinitrc
fi

# Create DWM session file for display managers
echo "Creating DWM session file..."
echo "[Desktop Entry]
Name=DWM
Comment=Dynamic Window Manager
Exec=/usr/local/bin/dwm
Icon=dwm
Type=XSession" | sudo tee /usr/share/xsessions/dwm.desktop > /dev/null

# Ensure DWM is properly linked for execution
sudo ln -sf "$(command -v dwm)" /usr/local/bin/dwm

echo "Installation complete! Reboot and select DWM from your login screen, or run 'startx' if no DM was installed."
