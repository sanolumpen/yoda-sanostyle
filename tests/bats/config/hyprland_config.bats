#!/usr/bin/env bats
# Tests for Hyprland configuration validation
# Source: [testing_expert](./skills/testing_expert.md)

CONFIG_DIR="${HOME}/.config/hypr"

@test "hyprland.conf exists" {
    [[ -f "$CONFIG_DIR/hyprland.conf" ]]
}

@test "hyprland.conf has NVIDIA env variables" {
    grep -q "LIBVA_DRIVER_NAME" "$CONFIG_DIR/hyprland.conf"
}

@test "hyprland.conf has monitor configuration" {
    grep -q "monitor=" "$CONFIG_DIR/hyprland.conf"
}

@test "hyprland.conf has exec-once section" {
    grep -q "exec-once" "$CONFIG_DIR/hyprland.conf"
}

@test "hyprland.conf has window rules" {
    grep -q "windowrule" "$CONFIG_DIR/hyprland.conf"
}