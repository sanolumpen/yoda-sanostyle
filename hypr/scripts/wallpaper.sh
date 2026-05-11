#!/bin/bash
# wallpaper.sh — wrapper para swww
# Uso: wallpaper.sh [random|next|prev]

WALLPAPERS_DIR="$HOME/.config/hypr/wallpaper"
CURRENT=$(cat ~/.cache/swww_wallpaper 2>/dev/null || echo "")

case "${1:-}" in
    random)
        FILE=$(find "$WALLPAPERS_DIR" -type f -name "*.png" -o -name "*.jpg" | shuf -n1)
        ;;
    next|prev)
        FILE=$(find "$WALLPAPERS_DIR" -type f -name "*.png" -o -name "*.jpg" | head -1)
        ;;
    *)
        FILE="${WALLPAPERS_DIR}/zoro.png"
        ;;
esac

if [ -n "$FILE" ]; then
    swww img "$FILE" --transition-type random 2>&1
    echo "$FILE" > ~/.cache/swww_wallpaper
    echo "Wallpaper: $FILE"
else
    echo "No se encontraron wallpapers en $WALLPAPERS_DIR" >&2
    exit 1
fi
