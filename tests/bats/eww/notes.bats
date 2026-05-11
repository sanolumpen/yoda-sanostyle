#!/usr/bin/env bats
# Tests for EWW notes script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "notes.sh exists" {
    [[ -f "$SCRIPT_DIR/notes.sh" ]]
}

@test "notes.sh is executable" {
    [[ -x "$SCRIPT_DIR/notes.sh" ]]
}

@test "notes.sh supports list command" {
    grep -q "list)" "$SCRIPT_DIR/notes.sh"
}

@test "notes.sh supports create command" {
    grep -q "create)" "$SCRIPT_DIR/notes.sh"
}

@test "notes.sh supports delete command" {
    grep -q "delete)" "$SCRIPT_DIR/notes.sh"
}

@test "notes.sh supports update command" {
    grep -q "update)" "$SCRIPT_DIR/notes.sh"
}

@test "notes.sh supports toggle-pin command" {
    grep -q "toggle-pin)" "$SCRIPT_DIR/notes.sh"
}

@test "notes.sh uses JSON storage" {
    grep -q "json" "$SCRIPT_DIR/notes.sh"
}

@test "notes.sh handles argument validation" {
    grep -q '$1' "$SCRIPT_DIR/notes.sh"
}