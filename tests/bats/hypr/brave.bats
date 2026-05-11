#!/usr/bin/env bats
# Tests for Hyprland Brave wrapper script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../hypr/scripts" && pwd)"

@test "brave.sh exists" {
    [[ -f "$SCRIPT_DIR/brave.sh" ]]
}

@test "brave.sh is executable" {
    [[ -x "$SCRIPT_DIR/brave.sh" ]]
}

@test "brave.sh contains GPU fix flags" {
    grep -q "disable-gpu-memory-buffer-video-frames" "$SCRIPT_DIR/brave.sh"
}

@test "brave.sh calls brave browser" {
    grep -q "brave" "$SCRIPT_DIR/brave.sh"
}