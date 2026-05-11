#!/usr/bin/env bats
# Tests for Hyprland wallpaper wrapper script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../hypr/scripts" && pwd)"

@test "wallpaper.sh exists" {
    [[ -f "$SCRIPT_DIR/wallpaper.sh" ]]
}

@test "wallpaper.sh is executable" {
    [[ -x "$SCRIPT_DIR/wallpaper.sh" ]]
}

@test "wallpaper.sh is a wrapper for wallpaper_v2.sh" {
    grep -q 'wallpaper_v2.sh' "$SCRIPT_DIR/wallpaper.sh"
}

@test "wallpaper.sh uses exec" {
    grep -q 'exec' "$SCRIPT_DIR/wallpaper.sh"
}