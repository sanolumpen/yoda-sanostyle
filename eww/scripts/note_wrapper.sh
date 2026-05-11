#!/bin/bash
# Wrapper para guardar nota - usa archivo temporal
NOTE_FILE="$HOME/.local/share/kuri-notes/nota.txt"
TEMP_FILE="$HOME/.local/share/kuri-notes/nota.tmp"

# Leer del argumento o stdin
if [ -n "$1" ]; then
    echo -n "$1" > "$TEMP_FILE"
    mv "$TEMP_FILE" "$NOTE_FILE"
else
    cat > "$TEMP_FILE" < /dev/stdin
    mv "$TEMP_FILE" "$NOTE_FILE"
fi