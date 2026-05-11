#!/usr/bin/bash
# wallpaper_v2.sh — Wallpaper con swww y cache
# Soporta: set, next, prev, random

SWWW_DAEMON=false
WALLPAPER_DIR="$HOME/.config/hypr/wallpaper"
CACHE="$HOME/.cache/swww_wallpaper"

# Asegurar que swww-daemon está corriendo
start_swww() {
    if ! pgrep -x swww-daemon > /dev/null 2>&1; then
        swww-daemon &
        sleep 1
    fi
}

# Seleccionar wallpaper aleatorio
get_random_wallpaper() {
    find "$WALLPAPER_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | shuf -n1
}

# Siguiente wallpaper (alfabético)
get_next_wallpaper() {
    local current=$(cat "$CACHE" 2>/dev/null || echo "")
    local all=($(find "$WALLPAPER_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | sort))
    local len=${#all[@]}
    
    if [ $len -eq 0 ]; then
        echo ""
        return
    fi
    
    for i in "${!all[@]}"; do
        if [ "${all[$i]}" = "$current" ] && [ $((i+1)) -lt $len ]; then
            echo "${all[$((i+1))]}"
            return
        fi
    done
    echo "${all[0]}"  # Volver al primero
}

# Anterior wallpaper (alfabético)
get_prev_wallpaper() {
    local current=$(cat "$CACHE" 2>/dev/null || echo "")
    local all=($(find "$WALLPAPER_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | sort))
    local len=${#all[@]}
    
    if [ $len -eq 0 ]; then
        echo ""
        return
    fi
    
    for i in "${!all[@]}"; do
        if [ "${all[$i]}" = "$current" ] && [ $i -gt 0 ]; then
            echo "${all[$((i-1))]}"
            return
        fi
    done
    echo "${all[$((len-1))]}"  # Volver al último
}

# Establecer wallpaper
set_wallpaper() {
    local file="$1"
    if [ -z "$file" ] || [ ! -f "$file" ]; then
        echo "Error: archivo no encontrado: $file" >&2
        exit 1
    fi
    
    start_swww
    swww img "$file" \
        --transition-type random \
        --transition-duration 1.5 \
        --transition-angle 45 \
        --transition-fps 60
    
    echo "$file" > "$CACHE"
    echo "Wallpaper: $file"
}

# Main
case "${1:-set}" in
    set)   set_wallpaper "${2:-$WALLPAPER_DIR/zoro.png}" ;;
    next)  set_wallpaper "$(get_next_wallpaper)" ;;
    prev)  set_wallpaper "$(get_prev_wallpaper)" ;;
    random) set_wallpaper "$(get_random_wallpaper)" ;;
    *)     echo "Uso: $0 {set|next|prev|random} [archivo]" ;;
esac
