#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
## Edited  : Minimal Version (Applets Only)

# Import Current Theme
source "$HOME/.config/rofi/shared/theme.bash"
theme="$type/$style"

# Theme Elements
prompt="$(hostname)"
mesg="Uptime : $(uptime -p | sed -e 's/up //g')"
list_col='1'
list_row='6'

# Options (Text + Icons for Applets style)
option_1=" Lock"
option_2=" Logout"
option_3=" Suspend"
option_4=" Hibernate"
option_5=" Reboot"
option_6=" Shutdown"
yes=' Yes'
no=' No'

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme "$theme"
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
		-theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme "$theme"
}

# Logic for Confirmation and Execution
run_action() {
	selected="$(echo -e "$yes\n$no" | confirm_cmd)"
	if [[ "$selected" == "$yes" ]]; then
		eval "$1"
	else
		exit
	fi
}

# Actions
chosen="$(echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd)"

case ${chosen} in
    $option_1) run_action "hyprlock" ;;
    $option_2) run_action "kill -9 -1" ;;
    $option_3) run_action "mpc -q pause; amixer set Master mute; systemctl suspend" ;;
    $option_4) run_action "systemctl hibernate" ;;
    $option_5) run_action "systemctl reboot" ;;
    $option_6) run_action "systemctl poweroff" ;;
esac
