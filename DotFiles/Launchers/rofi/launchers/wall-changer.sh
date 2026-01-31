#!/usr/bin/env bash

# --- Configuration ---
# Updated to your requested directory
WALLDIR="$HOME/Pictures/walls"
# Using your specific theme path
ROFI_THEME="$HOME/.config/rofi/styles/wall-picker.rasi"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/wallpaper-thumbs"
HYPRLOCK_CACHE="$HOME/.cache/hyprlock/wallpaper.png"
THUMB_SIZE="400x400"

# Ensure directories exist
mkdir -p "$CACHE_DIR"
mkdir -p "$(dirname "$HYPRLOCK_CACHE")"

# --- 1. Find Images ---
mapfile -t IMG_FILES < <(find "$WALLDIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \))

if [ "${#IMG_FILES[@]}" -eq 0 ]; then
    notify-send "Error" "No images found in $WALLDIR"
    exit 1
fi

# --- 2. Generate Thumbnails & Rofi Input ---
ROFI_INPUT=""
for IMG_FILE in "${IMG_FILES[@]}"; do
    BASENAME=$(basename "$IMG_FILE")
    
    # Create thumbnail if it doesn't exist
    THUMB_FILE="$CACHE_DIR/${BASENAME}.png"
    if [ ! -f "$THUMB_FILE" ]; then
        convert "$IMG_FILE" -auto-orient -thumbnail "${THUMB_SIZE}^" -gravity center -extent "$THUMB_SIZE" "$THUMB_FILE"
    fi
    
    # Build the string for Rofi
    ROFI_INPUT+="${BASENAME}\0icon\x1f${THUMB_FILE}\x1finfo\x1f${IMG_FILE}\n"
done

# --- 3. Show Rofi Menu ---
SELECTED_INDEX=$(echo -en "$ROFI_INPUT" | rofi -dmenu \
    -i \
    -show-icons \
    -theme "$ROFI_THEME" \
    -p "Choose wallpaper" \
    -format 'i' \
    -selected-row 0
)

# Exit if Escaped
[ -z "$SELECTED_INDEX" ] && exit 0

# Get the path of the selected file
WALLPAPER_PATH="${IMG_FILES[$SELECTED_INDEX]}"
SELECTED_NAME=$(basename "$WALLPAPER_PATH")

# --- 4. Apply (The combined logic you asked for) ---

# First: Apply to hyprpaper (if running)
hyprctl hyprpaper preload "$WALLPAPER_PATH" > /dev/null 2>&1
hyprctl hyprpaper wallpaper "eDP-1,$WALLPAPER_PATH" > /dev/null 2>&1

# Second: The part from your second code (matugen + hyprlock cache + notify)
cp "$WALLPAPER_PATH" "$HYPRLOCK_CACHE" && \
matugen image "$WALLPAPER_PATH" && \
notify-send "Wallpaper Changed" "${SELECTED_NAME} applied."

exit 0
