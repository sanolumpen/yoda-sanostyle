#!/bin/bash
# Launcher script para apps en Hyprland - evita flickering NVIDIA
# Uso: launch-app.sh "nombre-app"

app="$1"
case "$app" in
    brave)       ~/.config/hypr/scripts/brave.sh & ;;
    discord)     ~/.config/hypr/scripts/discord.sh & ;;
    steam)       ~/.config/hypr/scripts/steam.sh & ;;
    gdevelop5)   ~/.config/hypr/scripts/gdevelop.sh & ;;
    *)           gtk-launch "$app" & ;;
esac