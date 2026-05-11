#!/usr/bin/env bats
# Tests for EWW music.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "music.sh exists" {
    [[ -f "$SCRIPT_DIR/music.sh" ]]
}

@test "music.sh is executable" {
    [[ -x "$SCRIPT_DIR/music.sh" ]]
}

@test "music.sh checks for playerctl" {
    grep -q 'playerctl' "$SCRIPT_DIR/music.sh"
}

@test "music.sh has fallback when playerctl missing" {
    grep -q 'command -v playerctl' "$SCRIPT_DIR/music.sh"
}

@test "music.sh handles status command" {
    grep -q 'status)' "$SCRIPT_DIR/music.sh"
}

@test "music.sh handles title command" {
    grep -q 'title)' "$SCRIPT_DIR/music.sh"
}

@test "music.sh handles artist command" {
    grep -q 'artist)' "$SCRIPT_DIR/music.sh"
}

@test "music.sh handles cover command" {
    grep -q 'cover)' "$SCRIPT_DIR/music.sh"
}

@test "music.sh uses playerctl status" {
    grep -q 'playerctl status' "$SCRIPT_DIR/music.sh"
}

@test "music.sh uses playerctl metadata" {
    grep -q 'playerctl metadata' "$SCRIPT_DIR/music.sh"
}

@test "music.sh handles default cover" {
    grep -q '/tmp/default_cover.png' "$SCRIPT_DIR/music.sh"
}

@test "music.sh converts file:// URLs" {
    grep -q 'file://' "$SCRIPT_DIR/music.sh"
}

@test "music.sh has usage message" {
    grep -q 'Usage:' "$SCRIPT_DIR/music.sh"
}