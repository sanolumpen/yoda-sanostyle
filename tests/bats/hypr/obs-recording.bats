#!/usr/bin/env bats
# Tests for Hyprland OBS recording script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../hypr/scripts" && pwd)"

@test "obs-recording.sh exists" {
    [[ -f "$SCRIPT_DIR/obs-recording.sh" ]]
}

@test "obs-recording.sh is executable" {
    [[ -x "$SCRIPT_DIR/obs-recording.sh" ]]
}

@test "obs-recording.sh handles OBS binary" {
    grep -q "obs" "$SCRIPT_DIR/obs-recording.sh"
}

@test "obs-recording.sh handles running check" {
    grep -q "pgrep" "$SCRIPT_DIR/obs-recording.sh"
}