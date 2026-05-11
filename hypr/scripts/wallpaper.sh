#!/usr/bin/bash
# wallpaper.sh — wrapper para wallpaper_v2.sh (compatibilidad)
exec ~/.config/hypr/scripts/wallpaper_v2.sh "$@"
WALL
chmod +x /home/sanodesu/.config/hypr/scripts/wallpaper.sh
echo "wallpaper.sh fixeado como wrapper"