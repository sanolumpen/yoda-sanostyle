#!/usr/bin/env bats
# Tests for Hyprland edit_note script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../hypr/scripts" && pwd)"

@test "edit_note.sh exists" {
    [[ -f "$SCRIPT_DIR/edit_note.sh" ]]
}

@test "edit_note.sh is executable" {
    [[ -x "$SCRIPT_DIR/edit_note.sh" ]]
}

@test "edit_note.sh defines NOTE_FILE" {
    grep -q 'NOTE_FILE=' "$SCRIPT_DIR/edit_note.sh"
}

@test "edit_note.sh creates directory if missing" {
    grep -q 'mkdir -p' "$SCRIPT_DIR/edit_note.sh"
}

@test "edit_note.sh creates file if missing" {
    grep -q 'touch' "$SCRIPT_DIR/edit_note.sh"
}

@test "edit_note.sh checks for wofi" {
    grep -q 'command -v wofi' "$SCRIPT_DIR/edit_note.sh"
}

@test "edit_note.sh uses wofi dmenu" {
    grep -q 'wofi.*dmenu' "$SCRIPT_DIR/edit_note.sh"
}

@test "edit_note.sh handles multiline notes" {
    grep -q 'wc -l' "$SCRIPT_DIR/edit_note.sh"
}

@test "edit_note.sh has fallback to nano" {
    grep -q 'nano' "$SCRIPT_DIR/edit_note.sh"
}

@test "edit_note.sh uses alacritty for fallback" {
    grep -q 'alacritty' "$SCRIPT_DIR/edit_note.sh"
}

@test "edit_note.sh sends notification" {
    grep -q 'notify-send' "$SCRIPT_DIR/edit_note.sh"
}