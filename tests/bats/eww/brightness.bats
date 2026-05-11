#!/usr/bin/env bats
# Tests for EWW brightness.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "brightness.sh exists" {
    [[ -f "$SCRIPT_DIR/brightness.sh" ]]
}

@test "brightness.sh is executable" {
    [[ -x "$SCRIPT_DIR/brightness.sh" ]]
}

@test "brightness.sh handles percent command" {
    grep -q 'percent)' "$SCRIPT_DIR/brightness.sh"
}

@test "brightness.sh handles icon command" {
    grep -q 'icon)' "$SCRIPT_DIR/brightness.sh"
}

@test "brightness.sh uses brightnessctl" {
    grep -q 'brightnessctl' "$SCRIPT_DIR/brightness.sh"
}

@test "brightness.sh uses awk" {
    grep -q 'awk' "$SCRIPT_DIR/brightness.sh"
}

@test "brightness.sh has fallback value" {
    grep -q 'brightness=100' "$SCRIPT_DIR/brightness.sh"
}

@test "brightness.sh maps brightness to icons" {
    grep -q 'echo "󰃠"' "$SCRIPT_DIR/brightness.sh"
}