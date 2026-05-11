#!/usr/bin/env bats
# Tests for EWW audio.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "audio.sh exists" {
    [[ -f "$SCRIPT_DIR/audio.sh" ]]
}

@test "audio.sh is executable" {
    [[ -x "$SCRIPT_DIR/audio.sh" ]]
}

@test "audio.sh handles volume command" {
    grep -q 'volume)' "$SCRIPT_DIR/audio.sh"
}

@test "audio.sh handles muted command" {
    grep -q 'muted)' "$SCRIPT_DIR/audio.sh"
}

@test "audio.sh handles icon command" {
    grep -q 'icon)' "$SCRIPT_DIR/audio.sh"
}

@test "audio.sh uses wpctl" {
    grep -q 'wpctl' "$SCRIPT_DIR/audio.sh"
}

@test "audio.sh uses @DEFAULT_AUDIO_SINK@" {
    grep -q '@DEFAULT_AUDIO_SINK@' "$SCRIPT_DIR/audio.sh"
}

@test "audio.sh uses awk for volume calculation" {
    grep -q 'awk' "$SCRIPT_DIR/audio.sh"
}

@test "audio.sh maps volume to icons" {
    grep -q 'echo "󰕾"' "$SCRIPT_DIR/audio.sh"
}

@test "audio.sh handles muted state" {
    grep -q 'MUTED' "$SCRIPT_DIR/audio.sh"
}