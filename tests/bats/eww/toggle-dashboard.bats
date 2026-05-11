#!/usr/bin/env bats
# Tests for EWW toggle-dashboard.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "toggle-dashboard.sh exists" {
    [[ -f "$SCRIPT_DIR/toggle-dashboard.sh" ]]
}

@test "toggle-dashboard.sh is executable" {
    [[ -x "$SCRIPT_DIR/toggle-dashboard.sh" ]]
}

@test "toggle-dashboard.sh checks eww active-windows" {
    grep -q 'eww active-windows' "$SCRIPT_DIR/toggle-dashboard.sh"
}

@test "toggle-dashboard.sh handles dashboard_window" {
    grep -q 'dashboard_window' "$SCRIPT_DIR/toggle-dashboard.sh"
}

@test "toggle-dashboard.sh closes eww window" {
    grep -q 'eww close' "$SCRIPT_DIR/toggle-dashboard.sh"
}

@test "toggle-dashboard.sh opens eww window" {
    grep -q 'eww open' "$SCRIPT_DIR/toggle-dashboard.sh"
}