#!/usr/bin/env bats
# Tests for EWW system.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "system.sh exists" {
    [[ -f "$SCRIPT_DIR/system.sh" ]]
}

@test "system.sh is executable" {
    [[ -x "$SCRIPT_DIR/system.sh" ]]
}

@test "system.sh handles cpu command" {
    grep -q 'cpu)' "$SCRIPT_DIR/system.sh"
}

@test "system.sh handles memory command" {
    grep -q 'memory)' "$SCRIPT_DIR/system.sh"
}

@test "system.sh handles disk command" {
    grep -q 'disk)' "$SCRIPT_DIR/system.sh"
}

@test "system.sh handles temp command" {
    grep -q 'temp)' "$SCRIPT_DIR/system.sh"
}

@test "system.sh handles cpu_percent command" {
    grep -q 'cpu_percent)' "$SCRIPT_DIR/system.sh"
}

@test "system.sh uses top for CPU" {
    grep -q 'top -bn1' "$SCRIPT_DIR/system.sh"
}

@test "system.sh uses free for memory" {
    grep -q 'free' "$SCRIPT_DIR/system.sh"
}

@test "system.sh reads thermal zone" {
    grep -q 'thermal_zone' "$SCRIPT_DIR/system.sh"
}