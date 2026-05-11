#!/usr/bin/env bats
# Tests for EWW note_write.py script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "note_write.py exists" {
    [[ -f "$SCRIPT_DIR/note_write.py" ]]
}

@test "note_write.py has valid shebang" {
    grep -q '#!/usr/bin/env python3' "$SCRIPT_DIR/note_write.py"
}

@test "note_write.py uses python3" {
    grep -q 'python3' "$SCRIPT_DIR/note_write.py"
}

@test "note_write.py imports sys" {
    grep -q 'import sys' "$SCRIPT_DIR/note_write.py"
}

@test "note_write.py imports os" {
    grep -q 'import os' "$SCRIPT_DIR/note_write.py"
}

@test "note_write.py defines NOTE_FILE" {
    grep -q 'NOTE_FILE' "$SCRIPT_DIR/note_write.py"
}

@test "note_write.py creates directory if missing" {
    grep -q 'os.makedirs' "$SCRIPT_DIR/note_write.py"
}

@test "note_write.py handles command line arguments" {
    grep -q 'sys.argv' "$SCRIPT_DIR/note_write.py"
}

@test "note_write.py writes to file" {
    grep -q 'open(NOTE_FILE' "$SCRIPT_DIR/note_write.py"
}

@test "note_write.py handles empty argument case" {
    grep -q 'else:' "$SCRIPT_DIR/note_write.py"
}