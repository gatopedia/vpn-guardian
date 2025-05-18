#!/bin/sh
# vpn-guardian.sh - VPN Monitoring & Alert Script via Telegram
# Version: 1.0
# Author: gatopedia
# License: MIT

# Bot credentials
BOT_TOKEN="your token"      # Your bot's token
CHAT_ID="your chat ID"      # Your chat ID

# Lockfile to prevent multiple instances
LOCKFILE="/tmp/vpn_monitor.lock"

# Function to check VPN status
check_vpn_status() {
    # Check for WireGuard
    WG_STATUS=$(wg show 2>/dev/null | grep -q "interface" && echo "connected" || echo "disconnected")

    # Check for OpenVPN
    OVPN_STATUS=$(ps | grep -q "[o]penvpn" && echo "connected" || echo "disconnected")

    # Determine current status
    if [ "$WG_STATUS" = "connected" ] || [ "$OVPN_STATUS" = "connected" ]; then
        CURRENT_STATUS="connected"
    else
        CURRENT_STATUS="disconnected"
    fi

    # If status changed, send Telegram message
    if [ ! -f "/tmp/vpn_status" ] || [ "$(cat /tmp/vpn_status)" != "$CURRENT_STATUS" ]; then
        if [ "$CURRENT_STATUS" = "connected" ]; then
            MESSAGE="✅ VPN is active."
        else
            MESSAGE="❌ VPN is inactive."
        fi

        # Send message via Telegram
        curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
            -d chat_id="$CHAT_ID" \
            -d text="$MESSAGE" >/dev/null 2>&1

        # Save current status
        echo "$CURRENT_STATUS" > /tmp/vpn_status
    fi
}

# Main logic
if [ -e "$LOCKFILE" ]; then
    echo "Script is already running. Exiting..."
    exit 1
else
    touch "$LOCKFILE"
    check_vpn_status
    rm -f "$LOCKFILE"
fi


