#!/usr/bin/env bats
# Tests for Hyprland wallpaper script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../hypr/scripts" && pwd)"

@test "wallpaper_v2.sh exists" {
    [[ -f "$SCRIPT_DIR/wallpaper_v2.sh" ]]
}

@test "wallpaper_v2.sh is executable" {
    [[ -x "$SCRIPT_DIR/wallpaper_v2.sh" ]]
}

@test "wallpaper_v2.sh calls swww" {
    grep -q "swww" "$SCRIPT_DIR/wallpaper_v2.sh"
}

@test "wallpaper_v2.sh starts daemon" {
    grep -q "swww-daemon" "$SCRIPT_DIR/wallpaper_v2.sh"
}

@test "wallpaper_v2.sh has transition settings" {
    grep -q "transition" "$SCRIPT_DIR/wallpaper_v2.sh"
}