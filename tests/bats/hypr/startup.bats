#!/usr/bin/env bats
# Tests for Hyprland startup script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../hypr/scripts" && pwd)"

@test "startup.sh exists" {
    [[ -f "$SCRIPT_DIR/startup.sh" ]]
}

@test "startup.sh is executable" {
    [[ -x "$SCRIPT_DIR/startup.sh" ]]
}

@test "startup.sh sets LOG variable" {
    grep -q 'LOG=' "$SCRIPT_DIR/startup.sh"
}

@test "startup.sh creates cache directory" {
    grep -q 'mkdir -p ~/.cache' "$SCRIPT_DIR/startup.sh"
}

@test "startup.sh waits for PipeWire" {
    grep -q 'pipewire' "$SCRIPT_DIR/startup.sh"
}

@test "startup.sh calls wallpaper_v2.sh" {
    grep -q 'wallpaper_v2.sh' "$SCRIPT_DIR/startup.sh"
}

@test "startup.sh handles nm-applet" {
    grep -q 'nm-applet' "$SCRIPT_DIR/startup.sh"
}

@test "startup.sh handles mako notifications" {
    grep -q 'mako' "$SCRIPT_DIR/startup.sh"
}

@test "startup.sh manages waybar" {
    grep -q 'waybar' "$SCRIPT_DIR/startup.sh"
}

@test "startup.sh manages eww" {
    grep -q 'eww daemon' "$SCRIPT_DIR/startup.sh"
}

@test "startup.sh handles fcitx5" {
    grep -q 'fcitx5' "$SCRIPT_DIR/startup.sh"
}

@test "startup.sh handles clipboard" {
    grep -q 'wl-copy' "$SCRIPT_DIR/startup.sh"
}

@test "startup.sh configures swayidle" {
    grep -q 'swayidle' "$SCRIPT_DIR/startup.sh"
}

@test "startup.sh has cleanup logic" {
    grep -q 'rm -f' "$SCRIPT_DIR/startup.sh"
}

@test "startup.sh uses set -euo pipefail" {
    grep -q 'set -euo pipefail' "$SCRIPT_DIR/startup.sh"
}