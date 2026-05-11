#!/usr/bin/env bats
# Tests for EWW gcal_wrapper.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "gcal_wrapper.sh exists" {
    [[ -f "$SCRIPT_DIR/gcal_wrapper.sh" ]]
}

@test "gcal_wrapper.sh is executable" {
    [[ -x "$SCRIPT_DIR/gcal_wrapper.sh" ]]
}

@test "gcal_wrapper.sh exports HOME" {
    grep -q 'export HOME=' "$SCRIPT_DIR/gcal_wrapper.sh"
}

@test "gcal_wrapper.sh exports DBUS_SESSION_BUS_ADDRESS" {
    grep -q 'export DBUS_SESSION_BUS_ADDRESS' "$SCRIPT_DIR/gcal_wrapper.sh"
}

@test "gcal_wrapper.sh exports XDG_RUNTIME_DIR" {
    grep -q 'export XDG_RUNTIME_DIR' "$SCRIPT_DIR/gcal_wrapper.sh"
}

@test "gcal_wrapper.sh calls gcal.py" {
    grep -q 'gcal.py' "$SCRIPT_DIR/gcal_wrapper.sh"
}

@test "gcal_wrapper.sh uses python3" {
    grep -q 'python3' "$SCRIPT_DIR/gcal_wrapper.sh"
}

@test "gcal_wrapper.sh has fallback output" {
    grep -q 'echo "\[\]"' "$SCRIPT_DIR/gcal_wrapper.sh"
}