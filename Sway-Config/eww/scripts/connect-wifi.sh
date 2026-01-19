#!/bin/bash
SSID="$1"

# Check if already connected
if iwctl station wlan0 show | grep -q "Connected network.*$SSID"; then
    notify-send "WiFi" "Already connected to $SSID"
    exit 0
fi

# Try to connect
iwctl station wlan0 connect "$SSID"

if [ $? -eq 0 ]; then
    notify-send "WiFi" "Connected to $SSID"
else
    notify-send "WiFi" "Failed to connect to $SSID"
fi
