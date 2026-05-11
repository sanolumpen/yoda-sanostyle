#!/usr/bin/env bats
# Tests for EWW football.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "football.sh exists" {
    [[ -f "$SCRIPT_DIR/football.sh" ]]
}

@test "football.sh is executable" {
    [[ -x "$SCRIPT_DIR/football.sh" ]]
}

@test "football.sh has CACHE_FILE variable" {
    grep -q 'CACHE_FILE=' "$SCRIPT_DIR/football.sh"
}

@test "football.sh has CACHE_TIME variable" {
    grep -q 'CACHE_TIME=' "$SCRIPT_DIR/football.sh"
}

@test "football.sh has fetch_from_espn function" {
    grep -q 'fetch_from_espn()' "$SCRIPT_DIR/football.sh"
}

@test "football.sh has get_demo_data function" {
    grep -q 'get_demo_data()' "$SCRIPT_DIR/football.sh"
}

@test "football.sh uses curl" {
    grep -q 'curl' "$SCRIPT_DIR/football.sh"
}

@test "football.sh uses jq" {
    grep -q 'jq' "$SCRIPT_DIR/football.sh"
}

@test "football.sh handles json command" {
    grep -q '"json")' "$SCRIPT_DIR/football.sh"
}

@test "football.sh handles live command" {
    grep -q '"live")' "$SCRIPT_DIR/football.sh"
}

@test "football.sh has fallback to demo data" {
    grep -q 'get_demo_data' "$SCRIPT_DIR/football.sh"
}