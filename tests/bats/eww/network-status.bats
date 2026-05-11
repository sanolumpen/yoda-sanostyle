#!/usr/bin/env bats
# Tests for EWW network-status.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "network-status.sh exists" {
    [[ -f "$SCRIPT_DIR/network-status.sh" ]]
}

@test "network-status.sh is executable" {
    [[ -x "$SCRIPT_DIR/network-status.sh" ]]
}

@test "network-status.sh has get_interface function" {
    grep -q 'get_interface()' "$SCRIPT_DIR/network-status.sh"
}

@test "network-status.sh has get_interface_type function" {
    grep -q 'get_interface_type()' "$SCRIPT_DIR/network-status.sh"
}

@test "network-status.sh has get_wifi_ssid function" {
    grep -q 'get_wifi_ssid()' "$SCRIPT_DIR/network-status.sh"
}

@test "network-status.sh handles icon command" {
    grep -q 'icon)' "$SCRIPT_DIR/network-status.sh"
}

@test "network-status.sh handles type command" {
    grep -q 'type)' "$SCRIPT_DIR/network-status.sh"
}

@test "network-status.sh handles ssid command" {
    grep -q 'ssid)' "$SCRIPT_DIR/network-status.sh"
}

@test "network-status.sh handles interface command" {
    grep -q 'interface)' "$SCRIPT_DIR/network-status.sh"
}

@test "network-status.sh detects wifi" {
    grep -q '/wireless' "$SCRIPT_DIR/network-status.sh"
}

@test "network-status.sh handles disconnected state" {
    grep -q 'disconnected' "$SCRIPT_DIR/network-status.sh"
}

@test "network-status.sh maps wifi to icon" {
    grep -q 'echo "󰤨"' "$SCRIPT_DIR/network-status.sh"
}