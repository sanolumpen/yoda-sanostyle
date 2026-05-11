#!/usr/bin/env bats
# Tests for EWW dashboard-status.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "dashboard-status.sh exists" {
    [[ -f "$SCRIPT_DIR/dashboard-status.sh" ]]
}

@test "dashboard-status.sh is executable" {
    [[ -x "$SCRIPT_DIR/dashboard-status.sh" ]]
}

@test "dashboard-status.sh checks eww active-windows" {
    grep -q 'eww active-windows' "$SCRIPT_DIR/dashboard-status.sh"
}

@test "dashboard-status.sh handles dashboard_window" {
    grep -q 'dashboard_window' "$SCRIPT_DIR/dashboard-status.sh"
}

@test "dashboard-status.sh outputs JSON with class active" {
    grep -q '"class":"active"' "$SCRIPT_DIR/dashboard-status.sh"
}

@test "dashboard-status.sh outputs JSON with class empty" {
    grep -q 'class":""' "$SCRIPT_DIR/dashboard-status.sh"
}

@test "dashboard-status.sh outputs tooltip" {
    grep -q 'tooltip' "$SCRIPT_DIR/dashboard-status.sh"
}