#!/usr/bin/env python3
import sys
import os

NOTE_FILE = os.path.expanduser("~/.local/share/eww/notes/note.txt")
os.makedirs(os.path.dirname(NOTE_FILE), exist_ok=True)

if len(sys.argv) > 1:
    with open(NOTE_FILE, 'w') as f:
        f.write(sys.argv[1])
else:
    print("", end="")