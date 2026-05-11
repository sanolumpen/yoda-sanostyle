#!/usr/bin/env bats
# Tests for Hyprland start script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../hypr/scripts" && pwd)"

@test "start-hyprland.sh exists" {
    [[ -f "$SCRIPT_DIR/start-hyprland.sh" ]]
}

@test "start-hyprland.sh is executable" {
    [[ -x "$SCRIPT_DIR/start-hyprland.sh" ]]
}

@test "start-hyprland.sh executes Hyprland" {
    grep -q 'exec Hyprland' "$SCRIPT_DIR/start-hyprland.sh"
}