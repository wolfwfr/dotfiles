#!/bin/bash

# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
# Usage: protonvpn [OPTIONS] COMMAND [ARGS]...
#
#    ____            _               __     ______  _   _
#   |  _ \ _ __ ___ | |_ ___  _ __   \ \   / /  _ \| \ | |
#   | |_) | '__/ _ \| __/ _ \| '_ \   \ \ / /| |_) |  \| |
#   |  __/| | | (_) | || (_) | | | |   \ V / |  __/| |\  |
#   |_|   |_|  \___/ \__\___/|_| |_|    \_/  |_|   |_| \_| 1.0.0
#
#   Proton VPN command-line interface for Linux.
#
# Options:
#   -v, --verbose  Show detailed output during command execution
#   -h, --help     Show this message and exit.
#
# Commands:
#   signin      Sign in to Proton VPN with your credentials.
#   signout     Sign out from Proton VPN and clear local credentials.
#   info        Display your Proton VPN account information.
#   connect     Connect to Proton VPN server.
#   disconnect  Disconnect from current VPN server.
#   status      Show current VPN connection status.
#   servers     View available servers.
#   countries   Discover all countries where Proton VPN servers are available.
#   cities      Discover cities where servers are available in a specific
#               country.
#   config      Configure Proton VPN settings.
#
#   Examples:
#     protonvpn signin                      # Sign in
#     protonvpn connect                     # Connect to fastest server
#     protonvpn connect --country US        # Connect to US
#     protonvpn config list                 # View settings
#     protonvpn disconnect                  # Disconnect
#
# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
# Protonvpn Methods
vpn_get_status() {
    protonvpn status
}

vpn_disconnect() {
    protonvpn disconnect
}

vpn_connect() {
    protonvpn connect
}

# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
# Vars
VPN_STATUS="$(vpn_get_status)"
VPN_CONNECTION=$(echo "$VPN_STATUS" | awk -F'Status: ' '/Status/ {print $2}' | xargs)
VPN_RELAY=$(echo "$VPN_STATUS" | awk -F' ' '/Server:/ {print $2}' | xargs)
# VPN_FEATURES=$(echo "$VPN_STATUS" | awk -F'Features: ' '/Features:/ {print $2}' | xargs)
VPN_VISIBLE_LOCATION=$(echo "$VPN_STATUS" | awk -F' ' '/Server:/ {print $4 $5}' | xargs)

# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
# Actions
#
# [toggle_connection] Connect/disconnect to a VPN relay based on current status and send notification
toggle_connection() {
    if [ "$VPN_CONNECTION" = "Connected" ]; then
        vpn_disconnect
    else
        vpn_connect
    fi

    notify-send
    sleep 1
}

# [get_module_data] Get data for custom/protonvpn module in waybar. Returns waybar JSON
get_module_data() {
    local class alt tooltip

    tooltip="proton VPN\n\nStatus: $VPN_CONNECTION\nServer: $VPN_RELAY\nVisible Location: $VPN_VISIBLE_LOCATION"

    case "$VPN_CONNECTION" in
    Connected)
        class="connected"
        alt="connected"
        ;;
    Connecting)
        class="connecting"
        alt="connecting"
        ;;
    *)
        class="disconnected"
        alt="disconnected"
        ;;
    esac

    echo "{\"text\": \"$VPN_CONNECTION\", \"tooltip\": \"$tooltip\", \"alt\": \"$alt\", \"class\": \"$class\"}"
}

# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
# Input
case "$1" in
toggle) toggle_connection ;;
# reconnect) reconnect ;;
*) get_module_data ;;
esac
