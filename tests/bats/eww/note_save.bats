#!/usr/bin/env bats
# Tests for EWW note_save.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "note_save.sh exists" {
    [[ -f "$SCRIPT_DIR/note_save.sh" ]]
}

@test "note_save.sh is executable" {
    [[ -x "$SCRIPT_DIR/note_save.sh" ]]
}

@test "note_save.sh defines NOTE_FILE" {
    grep -q 'NOTE_FILE=' "$SCRIPT_DIR/note_save.sh"
}

@test "note_save.sh creates directory" {
    grep -q 'mkdir -p' "$SCRIPT_DIR/note_save.sh"
}

@test "note_save.sh writes to file" {
    grep -q '> "$NOTE_FILE"' "$SCRIPT_DIR/note_save.sh"
}