#!/bin/bash

# Variables
SSID="MyHotspot"
PASSWORD="MyStrongPassword"
WIFI_INTERFACE="wlp0s20f3"
ETHERNET_INTERFACE="enp4s0"
HOTSPOT_CONF="/etc/NetworkManager/system-connections/${SSID}.nmconnection"

# Function to enable Wi-Fi hotspot
enable_hotspot() {
    # Ensure NetworkManager is running
    sudo systemctl start NetworkManager
    sudo systemctl enable NetworkManager

    # Unblock Wi-Fi if blocked
    sudo rfkill unblock wifi

    # Bring up the Wi-Fi interface
    sudo ip link set $WIFI_INTERFACE up

    # Install necessary packages if not already installed
    sudo apt update
    sudo apt install -y wireless-tools wpasupplicant

    # Create Wi-Fi hotspot
    nmcli device wifi hotspot ifname $WIFI_INTERFACE ssid $SSID password $PASSWORD

    # Configure hotspot to share internet
    sudo bash -c "echo -e '\n[ipv4]\nmethod=shared\n' >> $HOTSPOT_CONF"

    # Restart NetworkManager
    sudo systemctl restart NetworkManager

    echo "Hotspot $SSID created and internet sharing enabled."
}

# Function to disable Wi-Fi hotspot
disable_hotspot() {
    # Delete the hotspot configuration file
    sudo rm -f $HOTSPOT_CONF

    # Restart NetworkManager to apply changes
    sudo systemctl restart NetworkManager

    echo "Hotspot $SSID disabled."
}

# Command line argument handling
case "$1" in
    enable)
        enable_hotspot
        ;;
    disable)
        disable_hotspot
        ;;
    *)
        echo "Usage: $0 {enable|disable}"
        exit 1
        ;;
esac

exit 0

