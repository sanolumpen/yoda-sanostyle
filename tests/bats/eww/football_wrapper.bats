#!/usr/bin/env bats
# Tests for EWW football_wrapper.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "football_wrapper.sh exists" {
    [[ -f "$SCRIPT_DIR/football_wrapper.sh" ]]
}

@test "football_wrapper.sh is executable" {
    [[ -x "$SCRIPT_DIR/football_wrapper.sh" ]]
}

@test "football_wrapper.sh calls football.py" {
    grep -q 'football.py' "$SCRIPT_DIR/football_wrapper.sh"
}

@test "football_wrapper.sh uses python3" {
    grep -q 'python3' "$SCRIPT_DIR/football_wrapper.sh"
}

@test "football_wrapper.sh has fallback output" {
    grep -q 'echo "\[\]"' "$SCRIPT_DIR/football_wrapper.sh"
}