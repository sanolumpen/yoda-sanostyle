#!/usr/bin/env bats
# Tests for Hyprland GDevelop wrapper script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../hypr/scripts" && pwd)"

@test "gdevelop.sh exists" {
    [[ -f "$SCRIPT_DIR/gdevelop.sh" ]]
}

@test "gdevelop.sh is executable" {
    [[ -x "$SCRIPT_DIR/gdevelop.sh" ]]
}

@test "gdevelop.sh contains GPU fix" {
    grep -q "disable-gpu" "$SCRIPT_DIR/gdevelop.sh"
}

@test "gdevelop.sh calls gdevelop" {
    grep -q "gdevelop" "$SCRIPT_DIR/gdevelop.sh"
}