#!/usr/bin/env bats
# Tests for EWW storage.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "storage.sh exists" {
    [[ -f "$SCRIPT_DIR/storage.sh" ]]
}

@test "storage.sh is executable" {
    [[ -x "$SCRIPT_DIR/storage.sh" ]]
}

@test "storage.sh handles total command" {
    grep -q 'total)' "$SCRIPT_DIR/storage.sh"
}

@test "storage.sh handles used command" {
    grep -q 'used)' "$SCRIPT_DIR/storage.sh"
}

@test "storage.sh handles free command" {
    grep -q 'free)' "$SCRIPT_DIR/storage.sh"
}

@test "storage.sh handles percent command" {
    grep -q 'percent)' "$SCRIPT_DIR/storage.sh"
}

@test "storage.sh uses df" {
    grep -q 'df -h' "$SCRIPT_DIR/storage.sh"
}

@test "storage.sh uses awk" {
    grep -q 'awk' "$SCRIPT_DIR/storage.sh"
}

@test "storage.sh checks root partition" {
    grep -q 'df -h /' "$SCRIPT_DIR/storage.sh"
}