# Wifi_Hotspot_Linux

## How to use:
1- Save the script: Save the modified script with a filename like hotspot.sh.

2- Make it executable: Run chmod +x hotspot.sh to make it executable.

3- Enable the hotspot: To enable the Wi-Fi hotspot, run ./hotspot.sh enable. This will create the hotspot with the specified SSID and password.

4- Disable the hotspot: To disable the Wi-Fi hotspot, run ./hotspot.sh disable. This will delete the hotspot configuration file and restart NetworkManager to disable the hotspot.

This script adds two functions: enable_hotspot to create and enable the hotspot, and disable_hotspot to delete the hotspot configuration and disable the hotspot. It uses a command-line argument (enable or disable) to determine which action to perform. Adjust paths and configurations as needed based on your environment and requirements.
