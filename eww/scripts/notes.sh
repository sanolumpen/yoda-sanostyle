#!/bin/bash
# Notepad simple — muestra placeholder cuando está vacío

NOTE_FILE="$HOME/.local/share/kuri-notes/notepad.txt"
mkdir -p "$(dirname "$NOTE_FILE")"
[ -f "$NOTE_FILE" ] || touch "$NOTE_FILE"

case "$1" in
    read)
        content=$(cat "$NOTE_FILE")
        if [ -z "$content" ] || [ -z "$(echo "$content" | tr -d '[:space:]')" ]; then
            echo "✏️ Escribí algo... (abrí el editor con el botón)"
        else
            echo "$content"
        fi
        ;;
    edit)
        nohup alacritty -e bash -c "nano '$NOTE_FILE'; pkill -RTMIN+11 eww" > /dev/null 2>&1 &
        ;;
    clear)
        > "$NOTE_FILE"
        ;;
    *)
        cat "$NOTE_FILE"
        ;;
esac
