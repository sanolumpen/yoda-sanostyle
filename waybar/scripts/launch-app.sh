#!/bin/bash
# Launcher desde waybar — delega a hypr/scripts/launch-app.sh
# Evita flickering NVIDIA al usar gtk-launch

app="$1"

case "$app" in
    brave)       nohup ~/.config/hypr/scripts/launch-app.sh brave > /dev/null 2>&1 & ;;
    discord)     nohup ~/.config/hypr/scripts/launch-app.sh discord > /dev/null 2>&1 & ;;
    steam)       nohup ~/.config/hypr/scripts/launch-app.sh steam > /dev/null 2>&1 & ;;
    gdevelop5)   nohup ~/.config/hypr/scripts/launch-app.sh gdevelop > /dev/null 2>&1 & ;;
    alacritty)   nohup ~/.config/hypr/scripts/launch-app.sh alacritty > /dev/null 2>&1 & ;;
    thunar)      nohup ~/.config/hypr/scripts/launch-app.sh thunar > /dev/null 2>&1 & ;;
    spotify)     nohup ~/.config/hypr/scripts/launch-app.sh spotify > /dev/null 2>&1 & ;;
    obs)         nohup ~/.config/hypr/scripts/launch-app.sh obs > /dev/null 2>&1 & ;;
    *)           gtk-launch "$app" & ;;
esac
