#!/bin/bash
# Simple notepad — lee/escribe un archivo de texto plano

NOTE_FILE="$HOME/.local/share/kuri-notes/notepad.txt"
mkdir -p "$(dirname "$NOTE_FILE")"
[ -f "$NOTE_FILE" ] || touch "$NOTE_FILE"

case "$1" in
    read)
        cat "$NOTE_FILE"
        ;;
    write)
        printf '%s' "$2" > "$NOTE_FILE"
        ;;
    append)
        printf '%s\n' "$2" >> "$NOTE_FILE"
        ;;
    clear)
        > "$NOTE_FILE"
        ;;
    edit)
        nohup alacritty -e bash -c "nano '$NOTE_FILE'; pkill -RTMIN+11 eww" > /dev/null 2>&1 &
        ;;
    *)
        cat "$NOTE_FILE"
        ;;
esac
