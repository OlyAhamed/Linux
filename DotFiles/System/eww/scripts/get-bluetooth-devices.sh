#!/bin/bash
if ! bluetoothctl show | grep -q "Powered: yes"; then
    echo "[]" # Return empty JSON array if off
    exit 0
fi

bluetoothctl devices | while read -r line; do
    mac=$(echo "$line" | awk '{print $2}')
    name=$(echo "$line" | cut -d' ' -f3-)
    
    connected="false"
    if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
        connected="true"
    fi
    
    jq -n --arg name "$name" --arg mac "$mac" --arg connected "$connected" \
      '{name: $name, mac: $mac, connected: ($connected == "true")}'
done | jq -s .