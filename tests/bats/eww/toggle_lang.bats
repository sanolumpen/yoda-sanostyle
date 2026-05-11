#!/usr/bin/env bats
# Tests for EWW toggle_lang.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "toggle_lang.sh exists" {
    [[ -f "$SCRIPT_DIR/toggle_lang.sh" ]]
}

@test "toggle_lang.sh is executable" {
    [[ -x "$SCRIPT_DIR/toggle_lang.sh" ]]
}

@test "toggle_lang.sh has LANG_FILE variable" {
    grep -q 'LANG_FILE=' "$SCRIPT_DIR/toggle_lang.sh"
}

@test "toggle_lang.sh creates lang file if missing" {
    grep -q 'echo "es"' "$SCRIPT_DIR/toggle_lang.sh"
}

@test "toggle_lang.sh reads current language" {
    grep -q 'cat "$LANG_FILE"' "$SCRIPT_DIR/toggle_lang.sh"
}

@test "toggle_lang.sh handles es to en toggle" {
    grep -q 'NEW_LANG="en"' "$SCRIPT_DIR/toggle_lang.sh"
}

@test "toggle_lang.sh handles en to es toggle" {
    grep -q 'NEW_LANG="es"' "$SCRIPT_DIR/toggle_lang.sh"
}

@test "toggle_lang.sh restarts waybar" {
    grep -q 'killall waybar' "$SCRIPT_DIR/toggle_lang.sh"
}

@test "toggle_lang.sh restarts eww" {
    grep -q 'eww kill' "$SCRIPT_DIR/toggle_lang.sh"
}

@test "toggle_lang.sh re-opens windows" {
    grep -q 'eww open' "$SCRIPT_DIR/toggle_lang.sh"
}