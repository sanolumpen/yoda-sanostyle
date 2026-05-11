#!/usr/bin/bash
# Editar nota sticky — fallback seguro a nano si wofi falla
NOTE_FILE="$HOME/.local/share/kuri-notes/nota.txt"
mkdir -p "$(dirname "$NOTE_FILE")"
[ -f "$NOTE_FILE" ] || touch "$NOTE_FILE"

# Intentar con wofi (dmenu mode) — si falla, usar nano
if command -v wofi > /dev/null 2>&1; then
    # wofi dmenu recibe input por stdin y devuelve por stdout
    # Solo para edición simple (una línea). Multilinea → nano.
    LINES=$(wc -l < "$NOTE_FILE")
    if [ "$LINES" -le 1 ]; then
        RESULT=$(wofi --show dmenu --width 500 --height 200 \
            --prompt "✏️ Editar nota:" \
            < "$NOTE_FILE" 2>/dev/null)
        if [ $? -eq 0 ]; then
            echo -n "$RESULT" > "$NOTE_FILE"
            notify-send "Nota" "Guardada"
        fi
        exit 0
    fi
fi

# Fallback: nano en terminal
alacritty -e nano "$NOTE_FILE" &
