#!/usr/bin/env bats
# Tests for EWW date_lang.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "date_lang.sh exists" {
    [[ -f "$SCRIPT_DIR/date_lang.sh" ]]
}

@test "date_lang.sh is executable" {
    [[ -x "$SCRIPT_DIR/date_lang.sh" ]]
}

@test "date_lang.sh has LANG_FILE variable" {
    grep -q 'LANG_FILE=' "$SCRIPT_DIR/date_lang.sh"
}

@test "date_lang.sh handles month command" {
    grep -q 'month)' "$SCRIPT_DIR/date_lang.sh"
}

@test "date_lang.sh handles weekday command" {
    grep -q 'weekday)' "$SCRIPT_DIR/date_lang.sh"
}

@test "date_lang.sh handles time command" {
    grep -q 'time)' "$SCRIPT_DIR/date_lang.sh"
}

@test "date_lang.sh exports LC_TIME" {
    grep -q 'export LC_TIME=' "$SCRIPT_DIR/date_lang.sh"
}

@test "date_lang.sh uses date command" {
    grep -q 'date' "$SCRIPT_DIR/date_lang.sh"
}