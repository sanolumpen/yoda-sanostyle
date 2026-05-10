#!/bin/bash
LANG_FILE="$HOME/.cache/eww_cal_lang"
current=$(cat "$LANG_FILE" 2>/dev/null || echo "es")

case "$1" in
    toggle)
        if [ "$current" = "es" ]; then
            echo "en" > "$LANG_FILE"
        else
            echo "es" > "$LANG_FILE"
        fi
        ;;
    get)
        echo "$current"
        ;;
esac
