#!/usr/bin/env bats
# Tests for EWW battery.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "battery.sh exists" {
    [[ -f "$SCRIPT_DIR/battery.sh" ]]
}

@test "battery.sh is executable" {
    [[ -x "$SCRIPT_DIR/battery.sh" ]]
}

@test "battery.sh has BATTERY_PATH variable" {
    grep -q 'BATTERY_PATH=' "$SCRIPT_DIR/battery.sh"
}

@test "battery.sh handles BAT0" {
    grep -q 'BAT0' "$SCRIPT_DIR/battery.sh"
}

@test "battery.sh handles BAT1 fallback" {
    grep -q 'BAT1' "$SCRIPT_DIR/battery.sh"
}

@test "battery.sh handles no battery case" {
    grep -q 'No Battery' "$SCRIPT_DIR/battery.sh"
}

@test "battery.sh handles percent command" {
    grep -q 'percent)' "$SCRIPT_DIR/battery.sh"
}

@test "battery.sh handles status command" {
    grep -q 'status)' "$SCRIPT_DIR/battery.sh"
}

@test "battery.sh handles icon command" {
    grep -q 'icon)' "$SCRIPT_DIR/battery.sh"
}

@test "battery.sh reads capacity" {
    grep -q 'capacity' "$SCRIPT_DIR/battery.sh"
}

@test "battery.sh reads status" {
    grep -q 'status' "$SCRIPT_DIR/battery.sh"
}

@test "battery.sh maps percent to icons" {
    grep -q 'echo "󰁹"' "$SCRIPT_DIR/battery.sh"
}

@test "battery.sh handles charging state" {
    grep -q 'Charging' "$SCRIPT_DIR/battery.sh"
}