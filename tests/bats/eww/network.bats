#!/usr/bin/env bats
# Tests for EWW network.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "network.sh exists" {
    [[ -f "$SCRIPT_DIR/network.sh" ]]
}

@test "network.sh is executable" {
    [[ -x "$SCRIPT_DIR/network.sh" ]]
}

@test "network.sh has get_interface function" {
    grep -q 'get_interface()' "$SCRIPT_DIR/network.sh"
}

@test "network.sh has INTERFACE variable" {
    grep -q 'INTERFACE=' "$SCRIPT_DIR/network.sh"
}

@test "network.sh has CACHE_DIR variable" {
    grep -q 'CACHE_DIR=' "$SCRIPT_DIR/network.sh"
}

@test "network.sh uses ip route" {
    grep -q 'ip route' "$SCRIPT_DIR/network.sh"
}

@test "network.sh handles upload command" {
    grep -q 'upload)' "$SCRIPT_DIR/network.sh"
}

@test "network.sh handles download command" {
    grep -q 'download)' "$SCRIPT_DIR/network.sh"
}

@test "network.sh handles upload_speed command" {
    grep -q 'upload_speed)' "$SCRIPT_DIR/network.sh"
}

@test "network.sh handles download_speed command" {
    grep -q 'download_speed)' "$SCRIPT_DIR/network.sh"
}

@test "network.sh reads tx_bytes" {
    grep -q 'tx_bytes' "$SCRIPT_DIR/network.sh"
}

@test "network.sh reads rx_bytes" {
    grep -q 'rx_bytes' "$SCRIPT_DIR/network.sh"
}

@test "network.sh uses awk for calculations" {
    grep -q 'awk' "$SCRIPT_DIR/network.sh"
}