#!/bin/bash

# Sticky Notes Manager Script
# Manages persistent notes storage with JSON backend

NOTES_DIR="$HOME/.local/share/kuri-notes"
NOTES_FILE="$NOTES_DIR/notes.json"

# Initialize notes directory
init_notes() {
    mkdir -p "$NOTES_DIR"
    if [ ! -f "$NOTES_FILE" ]; then
        echo "[]" > "$NOTES_FILE"
    fi
}

# Create a new note
create_note() {
    local title="$1"
    local content="${2:-}"
    local color="${3:-#ffff00}"  # Default yellow
    
    init_notes
    
    local note_id="note-$(date +%s)$RANDOM"
    local timestamp=$(date +%s)
    
    local updated=$(jq \
        --arg id "$note_id" \
        --arg title "$title" \
        --arg content "$content" \
        --arg color "$color" \
        --argjson created "$timestamp" \
        --argjson modified "$timestamp" \
        '. += [{
            "id": $id,
            "title": $title,
            "content": $content,
            "color": $color,
            "created": $created,
            "modified": $modified,
            "pinned": false
        }]' "$NOTES_FILE")
    
    echo "$updated" > "$NOTES_FILE"
    echo "$note_id"
}

# Get all notes
get_notes() {
    init_notes
    cat "$NOTES_FILE" | jq -c .
}

# Get note by ID
get_note() {
    local note_id="$1"
    init_notes
    jq --arg id "$note_id" '.[] | select(.id == $id)' "$NOTES_FILE"
}

# Update note
update_note() {
    local note_id="$1"
    local field="$2"
    local value="$3"
    
    init_notes
    
    local timestamp=$(date +%s)
    local updated
    
    if [ "$field" = "content" ] || [ "$field" = "title" ]; then
        updated=$(jq \
            --arg id "$note_id" \
            --arg field "$field" \
            --arg value "$value" \
            --argjson modified "$timestamp" \
            'map(if .id == $id then .[$field] = $value | .modified = $modified else . end)' \
            "$NOTES_FILE")
    elif [ "$field" = "color" ]; then
        updated=$(jq \
            --arg id "$note_id" \
            --arg color "$value" \
            --argjson modified "$timestamp" \
            'map(if .id == $id then .color = $color | .modified = $modified else . end)' \
            "$NOTES_FILE")
    elif [ "$field" = "pinned" ]; then
        updated=$(jq \
            --arg id "$note_id" \
            --argjson pinned "${value:-false}" \
            --argjson modified "$timestamp" \
            'map(if .id == $id then .pinned = $pinned | .modified = $modified else . end)' \
            "$NOTES_FILE")
    fi
    
    echo "$updated" > "$NOTES_FILE"
}

# Delete note
delete_note() {
    local note_id="$1"
    
    init_notes
    
    local updated=$(jq \
        --arg id "$note_id" \
        'map(select(.id != $id))' \
        "$NOTES_FILE")
    
    echo "$updated" > "$NOTES_FILE"
}

# Toggle pin
toggle_pin() {
    local note_id="$1"
    
    init_notes
    
    local timestamp=$(date +%s)
    local updated=$(jq \
        --arg id "$note_id" \
        --argjson modified "$timestamp" \
        'map(if .id == $id then .pinned = (.pinned | not) | .modified = $modified else . end)' \
        "$NOTES_FILE")
    
    echo "$updated" > "$NOTES_FILE"
}

# Export notes to file
export_notes() {
    local export_path="${1:-.}/notes-backup.json}"
    init_notes
    cp "$NOTES_FILE" "$export_path"
    echo "Exported to: $export_path"
}

# Import notes from file
import_notes() {
    local import_path="$1"
    init_notes
    
    if [ ! -f "$import_path" ]; then
        echo "Error: File not found: $import_path"
        return 1
    fi
    
    cp "$import_path" "$NOTES_FILE"
    echo "Imported from: $import_path"
}

# Watch for changes and broadcast to eww
watch_notes() {
    init_notes
    
    while true; do
        # Output current state
        get_notes
        
        # Wait for file changes
        if command -v inotifywait &> /dev/null; then
            inotifywait -q -e modify "$NOTES_FILE" 2>/dev/null
        else
            # Fallback: poll every second
            sleep 1
        fi
    done
}

# Main dispatcher
case "${1:-list}" in
    create)
        create_note "$2" "${3:-}" "${4:-#ffff00}"
        ;;
    list)
        get_notes
        ;;
    get)
        get_note "$2"
        ;;
    update)
        update_note "$2" "$3" "$4"
        ;;
    delete)
        delete_note "$2"
        ;;
    toggle-pin)
        toggle_pin "$2"
        ;;
    export)
        export_notes "$2"
        ;;
    import)
        import_notes "$2"
        ;;
    watch)
        watch_notes
        ;;
    read)
        cat "$HOME/.local/share/kuri-notes/nota.txt" 2>/dev/null || echo ""
        ;;
    edit)
        nohup alacritty -e vim "$HOME/.local/share/kuri-notes/nota.txt" > /dev/null 2>&1 &
        ;;
    clear)
        echo -n "" > "$HOME/.local/share/kuri-notes/nota.txt"
        ;;
    *)
        echo "Usage: $0 {create|list|get|update|delete|toggle-pin|export|import|watch|read|edit|clear} [args]"
        echo ""
        echo "Commands:"
        echo "  create <title> [content] [color]  - Create new note"
        echo "  list                              - List all notes"
        echo "  get <note-id>                     - Get specific note"
        echo "  update <note-id> <field> <value> - Update note field (content/title/color/pinned)"
        echo "  delete <note-id>                  - Delete note"
        echo "  toggle-pin <note-id>              - Toggle pin status"
        echo "  export [path]                     - Export notes to backup"
        echo "  import <path>                     - Import notes from backup"
        echo "  watch                             - Watch and broadcast changes to eww"
        exit 1
        ;;
esac
