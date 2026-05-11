#!/usr/bin/env bats
# Tests for EWW gcal_auth.py script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "gcal_auth.py exists" {
    [[ -f "$SCRIPT_DIR/gcal_auth.py" ]]
}

@test "gcal_auth.py is executable" {
    [[ -x "$SCRIPT_DIR/gcal_auth.py" ]]
}

@test "gcal_auth.py uses python3" {
    grep -q 'python3' "$SCRIPT_DIR/gcal_auth.py"
}

@test "gcal_auth.py imports google auth" {
    grep -q 'google.auth' "$SCRIPT_DIR/gcal_auth.py"
}

@test "gcal_auth.py imports google auth oauthlib" {
    grep -q 'google_auth_oauthlib' "$SCRIPT_DIR/gcal_auth.py"
}

@test "gcal_auth.py imports googleapiclient" {
    grep -q 'googleapiclient' "$SCRIPT_DIR/gcal_auth.py"
}

@test "gcal_auth.py defines SCOPES" {
    grep -q 'SCOPES' "$SCRIPT_DIR/gcal_auth.py"
}

@test "gcal_auth.py defines CREDS_FILE" {
    grep -q 'CREDS_FILE' "$SCRIPT_DIR/gcal_auth.py"
}

@test "gcal_auth.py defines TOKEN_FILE" {
    grep -q 'TOKEN_FILE' "$SCRIPT_DIR/gcal_auth.py"
}

@test "gcal_auth.py has get_service function" {
    grep -q 'def get_service' "$SCRIPT_DIR/gcal_auth.py"
}

@test "gcal_auth.py handles token refresh" {
    grep -q 'creds.refresh' "$SCRIPT_DIR/gcal_auth.py"
}

@test "gcal_auth.py handles new credentials" {
    grep -q 'InstalledAppFlow' "$SCRIPT_DIR/gcal_auth.py"
}