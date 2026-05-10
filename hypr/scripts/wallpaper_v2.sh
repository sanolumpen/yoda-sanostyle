#!/bin/bash

# Wallpaper path
WALLPAPER="/home/sanodesu/.config/hypr/wallpaper/zoro.png"

# Ensure wallpaper exists
if [ ! -f "$WALLPAPER" ]; then
    echo "Wallpaper not found at $WALLPAPER"
    exit 1
fi

# Start swww if not running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 1
fi

# Set wallpaper with swww
swww img "$WALLPAPER" --transition-type random --transition-duration 3

echo "Wallpaper set to: $WALLPAPER"
