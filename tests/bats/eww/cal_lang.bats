#!/usr/bin/env bats
# Tests for EWW cal_lang.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "cal_lang.sh exists" {
    [[ -f "$SCRIPT_DIR/cal_lang.sh" ]]
}

@test "cal_lang.sh is executable" {
    [[ -x "$SCRIPT_DIR/cal_lang.sh" ]]
}

@test "cal_lang.sh has LANG_FILE variable" {
    grep -q 'LANG_FILE=' "$SCRIPT_DIR/cal_lang.sh"
}

@test "cal_lang.sh handles toggle command" {
    grep -q 'toggle)' "$SCRIPT_DIR/cal_lang.sh"
}

@test "cal_lang.sh handles get command" {
    grep -q 'get)' "$SCRIPT_DIR/cal_lang.sh"
}

@test "cal_lang.sh toggles between es and en" {
    grep -q 'echo "en"' "$SCRIPT_DIR/cal_lang.sh"
}