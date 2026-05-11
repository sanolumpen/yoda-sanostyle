#!/usr/bin/env bats
# Tests for Hyprland launch-app script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../hypr/scripts" && pwd)"

@test "launch-app.sh exists" {
    [[ -f "$SCRIPT_DIR/launch-app.sh" ]]
}

@test "launch-app.sh is executable" {
    [[ -x "$SCRIPT_DIR/launch-app.sh" ]]
}

@test "launch-app.sh has GPU_OPTS" {
    grep -q 'GPU_OPTS=' "$SCRIPT_DIR/launch-app.sh"
}

@test "launch-app.sh has NVIDIA_OPTS" {
    grep -q 'NVIDIA_OPTS=' "$SCRIPT_DIR/launch-app.sh"
}

@test "launch-app.sh has launch_steam function" {
    grep -q 'launch_steam()' "$SCRIPT_DIR/launch-app.sh"
}

@test "launch-app.sh has launch_brave function" {
    grep -q 'launch_brave()' "$SCRIPT_DIR/launch-app.sh"
}

@test "launch-app.sh has launch_discord function" {
    grep -q 'launch_discord()' "$SCRIPT_DIR/launch-app.sh"
}

@test "launch-app.sh has launch_gdevelop function" {
    grep -q 'launch_gdevelop()' "$SCRIPT_DIR/launch-app.sh"
}

@test "launch-app.sh has launch_spotify function" {
    grep -q 'launch_spotify()' "$SCRIPT_DIR/launch-app.sh"
}

@test "launch-app.sh has launch_obs function" {
    grep -q 'launch_obs()' "$SCRIPT_DIR/launch-app.sh"
}

@test "launch-app.sh uses --no-cef-sandbox for steam" {
    grep -q 'no-cef-sandbox' "$SCRIPT_DIR/launch-app.sh"
}

@test "launch-app.sh uses --use-gl=desktop for discord" {
    grep -q 'use-gl=desktop' "$SCRIPT_DIR/launch-app.sh"
}

@test "launch-app.sh uses --ozone-platform=wayland" {
    grep -q 'ozone-platform=wayland' "$SCRIPT_DIR/launch-app.sh"
}

@test "launch-app.sh handles invalid app" {
    grep -q 'echo "Uso:' "$SCRIPT_DIR/launch-app.sh"
}

@test "launch-app.sh checks for running processes" {
    grep -q 'pgrep' "$SCRIPT_DIR/launch-app.sh"
}