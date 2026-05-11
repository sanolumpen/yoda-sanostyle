#!/usr/bin/env bats
# Tests for EWW active-workspace.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "active-workspace.sh exists" {
    [[ -f "$SCRIPT_DIR/active-workspace.sh" ]]
}

@test "active-workspace.sh is executable" {
    [[ -x "$SCRIPT_DIR/active-workspace.sh" ]]
}

@test "active-workspace.sh uses hyprctl" {
    grep -q 'hyprctl' "$SCRIPT_DIR/active-workspace.sh"
}

@test "active-workspace.sh uses jq" {
    grep -q 'jq' "$SCRIPT_DIR/active-workspace.sh"
}

@test "active-workspace.sh uses socat" {
    grep -q 'socat' "$SCRIPT_DIR/active-workspace.sh"
}

@test "active-workspace.sh listens for workspace changes" {
    grep -q 'workspace>>' "$SCRIPT_DIR/active-workspace.sh"
}

@test "active-workspace.sh uses stdbuf" {
    grep -q 'stdbuf' "$SCRIPT_DIR/active-workspace.sh"
}