#!/bin/bash
# Wrapper para guardar la nota
# Recibe el contenido por stdin o como argumento
NOTE_FILE="$HOME/.local/share/kuri-notes/nota.txt"

if [ -p /dev/stdin ]; then
    cat > "$NOTE_FILE"
elif [ -n "$1" ]; then
    echo -n "$1" > "$NOTE_FILE"
fi