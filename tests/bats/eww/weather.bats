#!/usr/bin/env bats
# Tests for EWW weather.sh script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../eww/scripts" && pwd)"

@test "weather.sh exists" {
    [[ -f "$SCRIPT_DIR/weather.sh" ]]
}

@test "weather.sh is executable" {
    [[ -x "$SCRIPT_DIR/weather.sh" ]]
}

@test "weather.sh has LOCATION variable" {
    grep -q 'LOCATION=' "$SCRIPT_DIR/weather.sh"
}

@test "weather.sh has CACHE_FILE variable" {
    grep -q 'CACHE_FILE=' "$SCRIPT_DIR/weather.sh"
}

@test "weather.sh has CACHE_DURATION variable" {
    grep -q 'CACHE_DURATION=' "$SCRIPT_DIR/weather.sh"
}

@test "weather.sh has get_weather_data function" {
    grep -q 'get_weather_data()' "$SCRIPT_DIR/weather.sh"
}

@test "weather.sh uses curl" {
    grep -q 'curl' "$SCRIPT_DIR/weather.sh"
}

@test "weather.sh uses jq" {
    grep -q 'jq' "$SCRIPT_DIR/weather.sh"
}

@test "weather.sh handles temp command" {
    grep -q 'temp)' "$SCRIPT_DIR/weather.sh"
}

@test "weather.sh handles location command" {
    grep -q 'location)' "$SCRIPT_DIR/weather.sh"
}

@test "weather.sh handles condition command" {
    grep -q 'condition)' "$SCRIPT_DIR/weather.sh"
}

@test "weather.sh handles wind command" {
    grep -q 'wind)' "$SCRIPT_DIR/weather.sh"
}

@test "weather.sh handles humidity command" {
    grep -q 'humidity)' "$SCRIPT_DIR/weather.sh"
}

@test "weather.sh handles icon command" {
    grep -q 'icon)' "$SCRIPT_DIR/weather.sh"
}

@test "weather.sh maps weather codes to icons" {
    grep -q 'case $code in' "$SCRIPT_DIR/weather.sh"
}