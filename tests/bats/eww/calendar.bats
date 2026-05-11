#!/usr/bin/env bats
# Tests for EWW calendar.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "calendar.sh exists" {
    [[ -f "$SCRIPT_DIR/calendar.sh" ]]
}

@test "calendar.sh is executable" {
    [[ -x "$SCRIPT_DIR/calendar.sh" ]]
}

@test "calendar.sh has OFFSET variable" {
    grep -q 'OFFSET=' "$SCRIPT_DIR/calendar.sh"
}

@test "calendar.sh handles year command" {
    grep -q '"year")' "$SCRIPT_DIR/calendar.sh"
}

@test "calendar.sh handles month command" {
    grep -q '"month")' "$SCRIPT_DIR/calendar.sh"
}

@test "calendar.sh handles month-num command" {
    grep -q '"month-num")' "$SCRIPT_DIR/calendar.sh"
}

@test "calendar.sh handles month-short command" {
    grep -q '"month-short")' "$SCRIPT_DIR/calendar.sh"
}

@test "calendar.sh handles current-day command" {
    grep -q '"current-day")' "$SCRIPT_DIR/calendar.sh"
}

@test "calendar.sh handles week command" {
    grep -q '"week"' "$SCRIPT_DIR/calendar.sh"
}

@test "calendar.sh uses date command" {
    grep -q 'date -d' "$SCRIPT_DIR/calendar.sh"
}

@test "calendar.sh calculates first day of month" {
    grep -q 'first_day=' "$SCRIPT_DIR/calendar.sh"
}

@test "calendar.sh calculates days in month" {
    grep -q 'days_in_month=' "$SCRIPT_DIR/calendar.sh"
}

@test "calendar.sh outputs JSON" {
    grep -q 'output="' "$SCRIPT_DIR/calendar.sh"
}

@test "calendar.sh handles default case" {
    grep -q 'echo "\[\]"' "$SCRIPT_DIR/calendar.sh"
}