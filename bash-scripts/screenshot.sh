#!/bin/bash

# Ensure directory exists
mkdir -p "$HOME/Pictures/Screenshots"

OPTIONS=("󰹑  Capture Desktop" "󰒅  Capture Area")
SELECTED=0
TOTAL=${#OPTIONS[@]}

tput civis
cleanup() { tput cnorm; }
trap cleanup EXIT

draw_menu() {
    clear
    echo -e "\n╭───────────────────────────────╮"
    printf "│          Screenshot %-9s│\n" 
    echo "╰───────────────────────────────╯"
    echo "╭─  Options  ───────────────────╮"
    echo "│                               │" 
    for i in "${!OPTIONS[@]}"; do
        if [ $i -eq $SELECTED ]; then
            printf "│   \033[1;34m▶ %-29s\033[0m│\n" "${OPTIONS[$i]}"
        else
            printf "│    %-30s│\n" "${OPTIONS[$i]}"
        fi
    done
    echo "│                               │"    
    echo "╰───────────────────────────────╯"
}

take_ss() {
    local mode=$1
    local filename="$HOME/Pictures/Screenshots/Screenshot_$(date +%Y%m%d_%H%M%S).png"
    
    if [ "$mode" == "area" ]; then
        local geom=$(slurp)
        [ -z "$geom" ] && exit 0 
        swaymsg move scratchpad
        sleep 0.1
        grim -g "$geom" "$filename"
    else
        swaymsg move scratchpad
        sleep 0.2
        grim "$filename"
    fi

    # --- THE SOUND FIX ---
    # We use nohup to ensure the sound survives the script exiting
    nohup canberra-gtk-play -i camera-shutter > /dev/null 2>&1 &
    
    wl-copy < "$filename"
    notify-send -u low -i camera-photo "Screenshot Captured" "Saved to Pictures & Clipboard"
    
    # Give the sound a tiny fraction of a second to initialize before exit
    sleep 0.1
    exit 0
}

while true; do
    draw_menu
    read -rsn1 key
    if [[ $key == $'\x1b' ]]; then
        read -rsn2 -t 0.1 key
        case $key in
            '[A') ((SELECTED--)); [ $SELECTED -lt 0 ] && SELECTED=$((TOTAL-1)) ;;
            '[B') ((SELECTED++)); [ $SELECTED -ge $TOTAL ] && SELECTED=0 ;;
            '') exit 0 ;;
        esac
    else
        case $key in
            k|K) ((SELECTED--)); [ $SELECTED -lt 0 ] && SELECTED=$((TOTAL-1)) ;;
            j|J) ((SELECTED++)); [ $SELECTED -ge $TOTAL ] && SELECTED=0 ;;
            q|Q) exit 0 ;;
            '') 
                case "${OPTIONS[$SELECTED]}" in
                    *"Desktop") take_ss "desktop" ;;
                    *"Area")    take_ss "area"    ;;
                esac
                ;;
        esac
    fi
done
