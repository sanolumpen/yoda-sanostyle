#!/usr/bin/env bats
# Tests for EWW toggle-all-widgets.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "toggle-all-widgets.sh exists" {
    [[ -f "$SCRIPT_DIR/toggle-all-widgets.sh" ]]
}

@test "toggle-all-widgets.sh is executable" {
    [[ -x "$SCRIPT_DIR/toggle-all-widgets.sh" ]]
}

@test "toggle-all-widgets.sh has case statement" {
    grep -q 'case "$1" in' "$SCRIPT_DIR/toggle-all-widgets.sh"
}

@test "toggle-all-widgets.sh handles dashboard" {
    grep -q 'dashboard)' "$SCRIPT_DIR/toggle-all-widgets.sh"
}

@test "toggle-all-widgets.sh handles calendar" {
    grep -q 'calendar)' "$SCRIPT_DIR/toggle-all-widgets.sh"
}

@test "toggle-all-widgets.sh handles football" {
    grep -q 'football)' "$SCRIPT_DIR/toggle-all-widgets.sh"
}

@test "toggle-all-widgets.sh handles notes" {
    grep -q 'notes)' "$SCRIPT_DIR/toggle-all-widgets.sh"
}

@test "toggle-all-widgets.sh checks eww active-windows" {
    grep -q 'eww active-windows' "$SCRIPT_DIR/toggle-all-widgets.sh"
}

@test "toggle-all-widgets.sh opens and closes windows" {
    grep -q 'eww open' "$SCRIPT_DIR/toggle-all-widgets.sh"
}