#!/bin/bash
# Wrapper para guardar notas
NOTE_FILE="$HOME/.local/share/eww/notes/note.txt"
mkdir -p "$(dirname "$NOTE_FILE")"
echo -n "$1" > "$NOTE_FILE"