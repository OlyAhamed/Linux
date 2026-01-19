#!/bin/bash
MAC="$1"
NAME="$2"

# Check if connected
if bluetoothctl info "$MAC" | grep -q "Connected: yes"; then
    bluetoothctl disconnect "$MAC"
    notify-send "Bluetooth" "Disconnected from $NAME"
else
    bluetoothctl connect "$MAC"
    if [ $? -eq 0 ]; then
        notify-send "Bluetooth" "Connected to $NAME"
    else
        notify-send "Bluetooth" "Failed to connect to $NAME"
    fi
fi

