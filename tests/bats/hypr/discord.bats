#!/usr/bin/env bats
# Tests for Hyprland Discord wrapper script
# Source: [testing_expert](./skills/testing_expert.md)

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../../../hypr/scripts" && pwd)"

@test "discord.sh exists" {
    [[ -f "$SCRIPT_DIR/discord.sh" ]]
}

@test "discord.sh is executable" {
    [[ -x "$SCRIPT_DIR/discord.sh" ]]
}

@test "discord.sh contains NVIDIA fix" {
    grep -q "use-gl=desktop" "$SCRIPT_DIR/discord.sh"
}

@test "discord.sh uses correct Discord path" {
    grep -q "discord" "$SCRIPT_DIR/discord.sh"
}