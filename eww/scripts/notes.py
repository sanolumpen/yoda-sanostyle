#!/usr/bin/env python3
"""
Notes Backend for EWW
CRUD operations with YAML output for EWW widgets
"""

import json
import os
import sys
import secrets
from datetime import datetime

NOTES_DIR = os.path.expanduser("~/.local/share/kuri-notes")
NOTES_FILE = os.path.join(NOTES_DIR, "notes.json")

COLORS = {
    "yellow": "#ffff00",
    "green": "#00ff00",
    "cyan": "#00ffff",
    "pink": "#ff69b4",
    "orange": "#ffa500",
    "purple": "#bf90ff",
    "white": "#ffffff",
}


def init():
    os.makedirs(NOTES_DIR, exist_ok=True)
    if not os.path.exists(NOTES_FILE):
        with open(NOTES_FILE, "w") as f:
            json.dump([], f)


def load():
    init()
    with open(NOTES_FILE, "r") as f:
        return json.load(f)


def save(notes):
    with open(NOTES_FILE, "w") as f:
        json.dump(notes, f, indent=2)


def list_notes():
    notes = load()
    notes.sort(key=lambda n: (-n.get("pinned", False), -n.get("modified", 0)))
    if not notes:
        print("no_notes: true")
        print("notes: []")
        return
    print("no_notes: false")
    print("notes:")
    for note in notes:
        print(f"  - id: \"{note['id']}\"")
        print(f"    title: \"{note.get('title', '')}\"")
        print(f"    content: \"{note.get('content', '')}\"")
        print(f"    color: \"{note.get('color', '#ffff00')}\"")
        print(f"    pinned: {str(note.get('pinned', False)).lower()}")
        ts = note.get('modified', 0)
        dt = datetime.fromtimestamp(ts)
        print(f"    modified: \"{dt.strftime('%d/%m %H:%M')}\"")


def create(title, content="", color="#ffff00"):
    if not title.strip():
        print("error: title is required")
        sys.exit(1)
    notes = load()
    note_id = f"note-{secrets.token_hex(4)}"
    ts = int(datetime.now().timestamp())
    notes.append({
        "id": note_id,
        "title": title,
        "content": content if content else "",
        "color": color if color in COLORS else "#ffff00",
        "created": ts,
        "modified": ts,
        "pinned": False,
    })
    save(notes)
    print(f"created: {note_id}")
    list_notes()


def delete(note_id):
    notes = load()
    notes = [n for n in notes if n["id"] != note_id]
    save(notes)
    print(f"deleted: {note_id}")
    list_notes()


def update(note_id, field, value):
    notes = load()
    for note in notes:
        if note["id"] == note_id:
            if field in ("title", "content"):
                note[field] = value
            elif field == "color":
                note[field] = value
            note["modified"] = int(datetime.now().timestamp())
            break
    save(notes)
    print(f"updated: {note_id}")
    list_notes()


def toggle_pin(note_id):
    notes = load()
    for note in notes:
        if note["id"] == note_id:
            note["pinned"] = not note.get("pinned", False)
            note["modified"] = int(datetime.now().timestamp())
            break
    save(notes)
    print(f"toggled: {note_id}")
    list_notes()


def clear():
    save([])
    print("cleared: all")
    list_notes()


def color_options():
    print("available_colors:")
    for name, hexcode in COLORS.items():
        print(f"  - name: \"{name}\"")
        print(f"    hex: \"{hexcode}\"")


def main():
    if len(sys.argv) < 2:
        print("Usage: notes.py <command> [args]")
        print("Commands: list, create, delete, update, toggle-pin, clear, colors")
        sys.exit(1)

    cmd = sys.argv[1]

    if cmd == "list":
        list_notes()
    elif cmd == "create":
        title = sys.argv[2] if len(sys.argv) > 2 else ""
        content = sys.argv[3] if len(sys.argv) > 3 else ""
        color = sys.argv[4] if len(sys.argv) > 4 else "#ffff00"
        create(title, content, color)
    elif cmd == "delete":
        note_id = sys.argv[2] if len(sys.argv) > 2 else ""
        delete(note_id)
    elif cmd == "update":
        note_id = sys.argv[2] if len(sys.argv) > 2 else ""
        field = sys.argv[3] if len(sys.argv) > 3 else ""
        value = sys.argv[4] if len(sys.argv) > 4 else ""
        update(note_id, field, value)
    elif cmd == "toggle-pin":
        note_id = sys.argv[2] if len(sys.argv) > 2 else ""
        toggle_pin(note_id)
    elif cmd == "clear":
        clear()
    elif cmd == "colors":
        color_options()
    else:
        print(f"Unknown command: {cmd}")
        sys.exit(1)


if __name__ == "__main__":
    main()