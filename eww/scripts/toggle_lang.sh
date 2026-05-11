#!/bin/bash

LANG_FILE="$HOME/.cache/desktop_lang"

if [ ! -f "$LANG_FILE" ]; then
    echo "es" > "$LANG_FILE"
fi

CURRENT_LANG=$(cat "$LANG_FILE")

if [ "$CURRENT_LANG" = "es" ]; then
    NEW_LANG="en"
    NEW_LOCALE="en_US.UTF-8"
else
    NEW_LANG="es"
    NEW_LOCALE="es_AR.UTF-8"
fi

echo "$NEW_LANG" > "$LANG_FILE"

# Restart Waybar with new locale
killall waybar
LC_TIME="$NEW_LOCALE" waybar > /dev/null 2>&1 &

# Restart EWW daemon with new locale
eww kill
sleep 1
LC_TIME="$NEW_LOCALE" eww daemon &
sleep 2

# Re-open windows
eww open dashboard_window
eww open date_window

disown
