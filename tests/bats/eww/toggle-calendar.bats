#!/usr/bin/env bats
# Tests for EWW toggle-calendar.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "toggle-calendar.sh exists" {
    [[ -f "$SCRIPT_DIR/toggle-calendar.sh" ]]
}

@test "toggle-calendar.sh is executable" {
    [[ -x "$SCRIPT_DIR/toggle-calendar.sh" ]]
}

@test "toggle-calendar.sh checks eww active-windows" {
    grep -q 'eww active-windows' "$SCRIPT_DIR/toggle-calendar.sh"
}

@test "toggle-calendar.sh handles calendar_window" {
    grep -q 'calendar_window' "$SCRIPT_DIR/toggle-calendar.sh"
}

@test "toggle-calendar.sh closes eww window" {
    grep -q 'eww close' "$SCRIPT_DIR/toggle-calendar.sh"
}

@test "toggle-calendar.sh opens eww window" {
    grep -q 'eww open' "$SCRIPT_DIR/toggle-calendar.sh"
}