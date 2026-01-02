#!/bin/bash

# Options array
OPTIONS=(
    "󰌾  Lock"
    "󰗼  Logout"
    "󰜉  Reboot"
    "󰐥  Shutdown"
)

# uptime
UPTIME_STR=$(uptime -p | sed 's/up //')

# index
SELECTED=0
TOTAL=${#OPTIONS[@]}

# Hide cursor
tput civis

# Cleanup function
cleanup() {
    tput cnorm  # Show cursor
    tput clear
}
trap cleanup EXIT

# menu
draw_menu() {
    clear
    
    # uptime box
    echo ""
    echo "╭───────────────────────────────╮"
    printf "│     󱎫 Uptime: %-16s│\n" "$UPTIME_STR"
    echo "╰───────────────────────────────╯"
    
    # sessions box
    echo "╭─  Sessions  ──────────────────╮"
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

# Main loop
while true; do
    draw_menu
    
    # Read single key
    read -rsn1 key
    
    # Handle arrow keys 
    if [[ $key == $'\x1b' ]]; then
        read -rsn2 -t 0.1 key
        case $key in
            '[A') # Up arrow
                ((SELECTED--))
                [ $SELECTED -lt 0 ] && SELECTED=$((TOTAL-1))
                ;;
            '[B') # Down arrow
                ((SELECTED++))
                [ $SELECTED -ge $TOTAL ] && SELECTED=0
                ;;
            '') # Just ESC key
                exit 0
                ;;
        esac
    else
        case $key in
            k|K) # Up
                ((SELECTED--))
                [ $SELECTED -lt 0 ] && SELECTED=$((TOTAL-1))
                ;;
            j|J) # Down
                ((SELECTED++))
                [ $SELECTED -ge $TOTAL ] && SELECTED=0
                ;;
            q|Q) # Quit
                exit 0
                ;;
            '') # Enter
                CHOICE="${OPTIONS[$SELECTED]}"
                clear
                tput cnorm
                
                case "$CHOICE" in
                    *Lock)
                        hyprlock
                        ;;
                    *Logout)
                        swaymsg exit
                        ;;
                    *Reboot)
                        systemctl reboot
                        ;;
                    *Shutdown)
                        systemctl poweroff
                        ;;
                esac
                exit 0
                ;;
        esac
    fi
done
