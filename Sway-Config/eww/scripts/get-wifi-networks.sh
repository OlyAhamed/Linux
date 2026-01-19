#!/bin/bash
# ~/.config/eww/scripts/get-wifi-networks.sh

WIFI_DEVICE=$(iwctl device list | sed 's/\x1b\[[0-9;]*m//g' | grep station | awk '{print $1}' | head -n1)
[ -z "$WIFI_DEVICE" ] && echo "[]" && exit 0

# If scan argument is passed, we trigger and wait
if [[ "$1" == "--scan" ]]; then
    iwctl station "$WIFI_DEVICE" scan
    sleep 2 # Required for iwd to populate the list
fi

# Fetch, sanitize and format output as JSON
iwctl station "$WIFI_DEVICE" get-networks 2>/dev/null | tail -n +5 | while IFS= read -r line; do
    # Remove ANSI colors and special terminal characters
    line=$(echo "$line" | sed 's/\x1b\[[0-9;]*m//g' | tr -d '\r')
    [[ -z "$line" || "$line" =~ "Scanning" ]] && continue
    
    connected="false"
    if [[ "$line" =~ ">" ]]; then
        line=$(echo "$line" | sed 's/>//')
        connected="true"
    fi
    
    # Extract SSID, Security, and Signal
    signal=$(echo "$line" | awk '{print $NF}')
    security=$(echo "$line" | awk '{print $(NF-1)}')
    ssid=$(echo "$line" | awk '{for(i=1;i<=NF-2;i++) printf "%s ", $i}' | sed 's/[[:space:]]*$//')
    
    [[ -z "$ssid" ]] && continue
    
    case "$signal" in
        "****") icon="󰤨" ;;
        "***")  icon="󰤥" ;;
        "**")   icon="󰤢" ;;
        "*")    icon="󰤟" ;;
        *)      icon="󰤯" ;;
    esac
    
    jq -n --arg ssid "$ssid" --arg security "$security" --arg icon "$icon" --arg connected "$connected" \
'{ssid: $ssid, icon: $icon, connected: ($connected == "true")}'
    done | jq -s .
