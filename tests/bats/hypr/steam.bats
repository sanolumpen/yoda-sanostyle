#!/usr/bin/env bats
# Tests for Hyprland Steam wrapper script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../hypr/scripts" && pwd)"

@test "steam.sh exists" {
    [[ -f "$SCRIPT_DIR/steam.sh" ]]
}

@test "steam.sh is executable" {
    [[ -x "$SCRIPT_DIR/steam.sh" ]]
}

@test "steam.sh contains WAYLAND fix" {
    grep -q "no-cef-sandbox" "$SCRIPT_DIR/steam.sh"
}

@test "steam.sh calls steam binary" {
    grep -q "steam" "$SCRIPT_DIR/steam.sh"
}