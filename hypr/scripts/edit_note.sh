#!/bin/bash
NOTE_FILE="$HOME/.local/share/kuri-notes/nota.txt"

# Usar wofi para editar (no espera, no blocking)
# wofi con --dmenu permite entrada de texto
RESULT=$(wofi --show dmenu --width 500 --height 200 --prompt "Editar Nota (Enter para guardar, Esc para cancelar)" < "$NOTE_FILE" 2>/dev/null)

if [ $? -eq 0 ]; then
    echo -n "$RESULT" > "$NOTE_FILE"
fi