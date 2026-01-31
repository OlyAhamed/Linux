#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
## Edited  : Minimal Version (Applets Only)

# Import Current Theme
source "$HOME/.config/rofi/shared/theme.bash"
theme="$type/$style"

# Fixed Applets Settings
prompt='Quick Links'
mesg="Using '$BROWSER' as web browser"
list_col='1'
list_row='6'
efonts="JetBrains Mono Nerd Font 10"

# Options (Icons + Labels for Applets style)
option_1=" Google"
option_2=" Gmail"
option_3=" Youtube"
option_4=" Github"
option_5=" Reddit"
option_6=" Twitter"

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-theme-str "element-text {font: \"$efonts\";}" \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme "$theme"
}

# Execution Logic
chosen="$(echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd)"

case ${chosen} in
    $option_1) xdg-open 'https://www.google.com/' ;;
    $option_2) xdg-open 'https://mail.google.com/' ;;
    $option_3) xdg-open 'https://www.youtube.com/' ;;
    $option_4) xdg-open 'https://www.github.com/' ;;
    $option_5) xdg-open 'https://www.reddit.com/' ;;
    $option_6) xdg-open 'https://www.twitter.com/' ;;
esac
