#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers/type-1"
theme='style-5-2'
WALLDIR="$HOME/Pictures/walls"

selected=$(ls "$WALLDIR" | rofi -dmenu -i \
    -p "Choose wallpaper" \
    -theme "${dir}/${theme}.rasi")

[ -z "$selected" ] && exit

 cp "$WALLDIR/$selected" ~/.cache/hyprlock/wallpaper.png && matugen image "$WALLDIR/$selected" && notify-send "Wallpaper Changed" ""$selected" applied."

