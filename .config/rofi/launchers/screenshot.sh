#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
## Edited  : Minimal Version (Applets Only)

# Import Current Theme
source "$HOME/.config/rofi/shared/theme.bash"
theme="$type/$style"

# Fixed Applets Settings
prompt='Screenshot'
list_col='1'
list_row='3'
win_width='300px'

# Directory Settings
dir="$(xdg-user-dir PICTURES)/Screenshots"
mesg="DIR: $dir"

# Ensure directory exists
[[ ! -d "$dir" ]] && mkdir -p "$dir"

# Options (Text + Icons for Applets style)
option_1=" Capture Desktop"
option_2=" Capture Area"
option_3=" Capture Window"

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme "$theme"
}

# Actions
chosen="$(echo -e "$option_1\n$option_2\n$option_3" | rofi_cmd)"

case ${chosen} in
    "$option_1")
        sleep 0.2 && hyprshot -m output -o "$dir"
        ;;
    "$option_2")
        hyprshot -m region -o "$dir"
        ;;
    "$option_3")
        sleep 0.2 && hyprshot -m window -o "$dir"
        ;;
esac
