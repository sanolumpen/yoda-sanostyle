#!/usr/bin/env bats
# Tests for EWW note_wrapper.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "note_wrapper.sh exists" {
    [[ -f "$SCRIPT_DIR/note_wrapper.sh" ]]
}

@test "note_wrapper.sh is executable" {
    [[ -x "$SCRIPT_DIR/note_wrapper.sh" ]]
}

@test "note_wrapper.sh defines NOTE_FILE" {
    grep -q 'NOTE_FILE=' "$SCRIPT_DIR/note_wrapper.sh"
}

@test "note_wrapper.sh defines TEMP_FILE" {
    grep -q 'TEMP_FILE=' "$SCRIPT_DIR/note_wrapper.sh"
}

@test "note_wrapper.sh handles argument input" {
    grep -q 'if \[ -n "\$1" \]' "$SCRIPT_DIR/note_wrapper.sh"
}

@test "note_wrapper.sh writes to temp file" {
    grep -q '> "$TEMP_FILE"' "$SCRIPT_DIR/note_wrapper.sh"
}

@test "note_wrapper.sh moves temp to final" {
    grep -q 'mv "$TEMP_FILE"' "$SCRIPT_DIR/note_wrapper.sh"
}

@test "note_wrapper.sh handles stdin input" {
    grep -q 'cat >' "$SCRIPT_DIR/note_wrapper.sh"
}