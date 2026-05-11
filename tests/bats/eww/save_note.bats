#!/usr/bin/env bats
# Tests for EWW save_note.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "save_note.sh exists" {
    [[ -f "$SCRIPT_DIR/save_note.sh" ]]
}

@test "save_note.sh is executable" {
    [[ -x "$SCRIPT_DIR/save_note.sh" ]]
}

@test "save_note.sh defines NOTE_FILE" {
    grep -q 'NOTE_FILE=' "$SCRIPT_DIR/save_note.sh"
}

@test "save_note.sh handles stdin input" {
    grep -q 'cat >' "$SCRIPT_DIR/save_note.sh"
}

@test "save_note.sh handles argument input" {
    grep -q 'echo -n' "$SCRIPT_DIR/save_note.sh"
}

@test "save_note.sh checks for pipe input" {
    grep -q '/dev/stdin' "$SCRIPT_DIR/save_note.sh"
}