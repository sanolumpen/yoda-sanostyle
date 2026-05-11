#!/usr/bin/env bats
# Tests for EWW cal_nav.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "cal_nav.sh exists" {
    [[ -f "$SCRIPT_DIR/cal_nav.sh" ]]
}

@test "cal_nav.sh is executable" {
    [[ -x "$SCRIPT_DIR/cal_nav.sh" ]]
}

@test "cal_nav.sh has refresh_calendar function" {
    grep -q 'refresh_calendar()' "$SCRIPT_DIR/cal_nav.sh"
}

@test "cal_nav.sh handles prev command" {
    grep -q '"prev")' "$SCRIPT_DIR/cal_nav.sh"
}

@test "cal_nav.sh handles next command" {
    grep -q '"next")' "$SCRIPT_DIR/cal_nav.sh"
}

@test "cal_nav.sh handles reset command" {
    grep -q '"reset")' "$SCRIPT_DIR/cal_nav.sh"
}

@test "cal_nav.sh handles toggle_picker command" {
    grep -q 'toggle_picker' "$SCRIPT_DIR/cal_nav.sh"
}

@test "cal_nav.sh handles year navigation" {
    grep -q 'year_prev\|year_next' "$SCRIPT_DIR/cal_nav.sh"
}

@test "cal_nav.sh handles goto_month command" {
    grep -q 'goto_month' "$SCRIPT_DIR/cal_nav.sh"
}

@test "cal_nav.sh handles day selection" {
    grep -q '"day")' "$SCRIPT_DIR/cal_nav.sh"
}

@test "cal_nav.sh updates eww variables" {
    grep -q 'eww update' "$SCRIPT_DIR/cal_nav.sh"
}