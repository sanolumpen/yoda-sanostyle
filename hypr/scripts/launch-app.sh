#!/usr/bin/bash
# launch-app.sh — Lanzador universal con soporte NVIDIA Wayland
# Uso: launch-app.sh <app> [args...]
# Apps soportadas: brave, discord, steam, gdevelop, spotify, obs, thunar, alacritty

GPU_OPTS="--enable-features=UseOzonePlatform --ozone-platform=wayland"
NVIDIA_OPTS="--disable-gpu-memory-buffer-video-frames"

launch_steam() {
    # Steam con sandbox deshabilitado para NVIDIA Wayland
    if pgrep -x steam > /dev/null; then
        notify-send "Steam" "Ya está en ejecución"
    else
        steam -no-cef-sandbox "$@" &
        sleep 2
        # Forzar modo ventana para evitar flickering
        hyprctl dispatch movetoworkspace current, $(hyprctl activeworkspace | grep -oP '\d+')
    fi
}

launch_brave() {
    # Brave con flags anti-flicker NVIDIA
    /usr/bin/brave-browser \
        --disable-gpu-memory-buffer-video-frames \
        --enable-features=UseOzonePlatform \
        --ozone-platform=wayland \
        --enable-wayland-ime \
        "$@" &
}

launch_discord() {
    # Discord con renderizado de escritorio para evitar flickering
    if pgrep -x discord > /dev/null; then
        notify-send "Discord" "Ya está en ejecución"
    else
        discord --use-gl=desktop "$@" &
        sleep 3
    fi
}

launch_gdevelop() {
    # GDevelop — desactivar GPU para compatibilidad
    gdevelop --disable-gpu "$@" &
}

launch_spotify() {
    # Spotify (usar spotifyd o spotify flatpak)
    if command -v spotify &> /dev/null; then
        spotify "$@" &
    elif command -v flatpak &> /dev/null && flatpak list | grep -q spotify; then
        flatpak run com.spotify.Client "$@" &
    else
        notify-send "Error" "Spotify no instalado"
    fi
}

launch_obs() {
    # OBS Studio — limpiar logs antiguos y lanzar
    find ~/.config/obs-studio/logs/ -type f -name "*.txt" | sort -r | tail -n +4 | xargs -r rm -f
    find ~/.config/obs-studio/profiler_data/ -type f -name "*.csv.gz" | sort -r | tail -n +4 | xargs -r rm -f
    
    if pgrep -x obs > /dev/null; then
        notify-send "OBS" "Ya está en ejecución"
    else
        obs &
        sleep 2
    fi
}

launch_thunar() {
    thunar "$@" &
}

launch_alacritty() {
    alacritty "$@" &
}

# Main
case "${1:-}" in
    brave|Brave)       launch_brave "${@:2}" ;;
    discord|Discord)   launch_discord "${@:2}" ;;
    steam|Steam)       launch_steam "${@:2}" ;;
    gdevelop|GDevelop) launch_gdevelop "${@:2}" ;;
    spotify|Spotify)   launch_spotify "${@:2}" ;;
    obs|OBS)           launch_obs "${@:2}" ;;
    thunar|Thunar)     launch_thunar "${@:2}" ;;
    alacritty|Alacritty) launch_alacritty "${@:2}" ;;
    *)
        echo "Uso: $0 <app> [args...]"
        echo "Apps: brave, discord, steam, gdevelop, spotify, obs, thunar, alacritty"
        exit 1
        ;;
esac
