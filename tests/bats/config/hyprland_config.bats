#!/usr/bin/env bats
# Tests for Hyprland configuration validation
# Source: [testing_expert](./skills/testing_expert.md)

CONFIG_DIR="${HOME}/.config/hypr"
CONFIG_FILE="$CONFIG_DIR/hyprland.conf"

# ---------------------------------------------------------------
# File existence and basic structure
# ---------------------------------------------------------------

@test "hyprland.conf exists" {
    [[ -f "$CONFIG_FILE" ]]
}

@test "hyprland.conf is not empty" {
    [[ -s "$CONFIG_FILE" ]]
}

@test "hyprland.conf has header with Yoda theme" {
    grep -q "YODA" "$CONFIG_FILE"
}

@test "hyprland.conf header shows correct Hyprland version" {
    grep -q "HYPRLAND 0.54" "$CONFIG_FILE"
}

@test "hyprland.conf header shows NVIDIA RTX 3060" {
    grep -q "NVIDIA.*3060" "$CONFIG_FILE"
}

@test "hyprland.conf has backports install note" {
    grep -q "trixie-backports" "$CONFIG_FILE"
}

@test "hyprland.conf has Lua migration warning" {
    grep -q "0.55+ migra a Lua" "$CONFIG_FILE"
}

# ---------------------------------------------------------------
# NVIDIA configuration
# ---------------------------------------------------------------

@test "hyprland.conf has LIBVA_DRIVER_NAME env" {
    grep -q "LIBVA_DRIVER_NAME" "$CONFIG_FILE"
}

@test "hyprland.conf has XDG_SESSION_TYPE env" {
    grep -q "XDG_SESSION_TYPE" "$CONFIG_FILE"
}

@test "hyprland.conf has GBM_BACKEND env" {
    grep -q "GBM_BACKEND" "$CONFIG_FILE"
}

@test "hyprland.conf has nvidia_anti_flicker" {
    grep -q "nvidia_anti_flicker" "$CONFIG_FILE"
}

# ---------------------------------------------------------------
# Monitor and input
# ---------------------------------------------------------------

@test "hyprland.conf has monitor configuration" {
    grep -q "monitor=" "$CONFIG_FILE"
}

@test "hyprland.conf has keyboard layout" {
    grep -q "kb_layout" "$CONFIG_FILE"
}

@test "hyprland.conf has touchpad config" {
    grep -q "touchpad" "$CONFIG_FILE"
}

# ---------------------------------------------------------------
# Decoration and effects
# ---------------------------------------------------------------

@test "hyprland.conf has decoration section" {
    grep -q "^decoration" "$CONFIG_FILE"
}

@test "hyprland.conf has blur enabled" {
    grep -q "blur" "$CONFIG_FILE"
}

@test "hyprland.conf has shadow enabled" {
    grep -q "shadow" "$CONFIG_FILE"
}

@test "hyprland.conf has dim_inactive" {
    grep -q "dim_inactive" "$CONFIG_FILE"
}

@test "hyprland.conf has dim_strength" {
    grep -q "dim_strength" "$CONFIG_FILE"
}

# ---------------------------------------------------------------
# Animations
# ---------------------------------------------------------------

@test "hyprland.conf has animations enabled" {
    grep -q "animations" "$CONFIG_FILE"
}

@test "hyprland.conf has yodaOut bezier curve" {
    grep -q "yodaOut" "$CONFIG_FILE"
}

@test "hyprland.conf has yodaIn bezier curve" {
    grep -q "yodaIn" "$CONFIG_FILE"
}

@test "hyprland.conf has window animation" {
    grep -q "animation.*windows.*yodaOut" "$CONFIG_FILE"
}

@test "hyprland.conf has border animation" {
    grep -q "animation.*border" "$CONFIG_FILE"
}

@test "hyprland.conf has workspace animation" {
    grep -q "animation.*workspaces" "$CONFIG_FILE"
}

# ---------------------------------------------------------------
# Layout (general + dwindle)
# ---------------------------------------------------------------

@test "hyprland.conf has layout set to dwindle" {
    grep -q "layout = dwindle" "$CONFIG_FILE"
}

@test "hyprland.conf has dwindle section" {
    grep -q "^dwindle" "$CONFIG_FILE"
}

@test "hyprland.conf has smart_split enabled" {
    grep -q "smart_split" "$CONFIG_FILE"
}

@test "hyprland.conf has smart_resizing enabled" {
    grep -q "smart_resizing" "$CONFIG_FILE"
}

@test "hyprland.conf has preserve_split enabled" {
    grep -q "preserve_split" "$CONFIG_FILE"
}

@test "hyprland.conf has pseudotile enabled" {
    grep -q "pseudotile" "$CONFIG_FILE"
}

# ---------------------------------------------------------------
# Gestures
# ---------------------------------------------------------------

@test "hyprland.conf has gestures section" {
    grep -q "^gestures" "$CONFIG_FILE"
}

@test "hyprland.conf has workspace_swipe enabled" {
    grep -q "workspace_swipe = true" "$CONFIG_FILE"
}

@test "hyprland.conf uses 3 finger swipe" {
    grep -q "workspace_swipe_fingers = 3" "$CONFIG_FILE"
}

# ---------------------------------------------------------------
# Window rules
# ---------------------------------------------------------------

@test "hyprland.conf has exec-once section" {
    grep -q "exec-once" "$CONFIG_FILE"
}

@test "hyprland.conf has window rules" {
    grep -q "windowrule" "$CONFIG_FILE"
}

@test "hyprland.conf has thunar float rule" {
    grep -q "thunar" "$CONFIG_FILE"
}

@test "hyprland.conf has brave workspace rule" {
    grep -q "brave.*workspace" "$CONFIG_FILE"
}

@test "hyprland.conf has discord workspace rule" {
    grep -q "discord.*workspace" "$CONFIG_FILE"
}

@test "hyprland.conf has steam workspace rule" {
    grep -q "steam.*workspace" "$CONFIG_FILE"
}

@test "hyprland.conf has blender workspace rule" {
    grep -q "blender.*workspace" "$CONFIG_FILE"
}

@test "hyprland.conf has brave popup float rule" {
    grep -q "brave.*popup" "$CONFIG_FILE"
}

# ---------------------------------------------------------------
# Misc settings
# ---------------------------------------------------------------

@test "hyprland.conf has window swallowing" {
    grep -q "enable_swallow" "$CONFIG_FILE"
}

@test "hyprland.conf swallows alacritty and kitty" {
    grep -q "swallow_regex" "$CONFIG_FILE"
}

@test "hyprland.conf has Hyprland logo disabled" {
    grep -q "disable_hyprland_logo" "$CONFIG_FILE"
}

@test "hyprland.conf has splash disabled" {
    grep -q "disable_splash_rendering" "$CONFIG_FILE"
}

@test "hyprland.conf has mouse dragging animation" {
    grep -q "animate_mouse_windowdragging" "$CONFIG_FILE"
}

@test "hyprland.conf has focus_on_activate" {
    grep -q "focus_on_activate" "$CONFIG_FILE"
}

# ---------------------------------------------------------------
# Keybinds
# ---------------------------------------------------------------

@test "hyprland.conf has alacritty keybind" {
    grep -q "SUPER.*R.*alacritty" "$CONFIG_FILE"
}

@test "hyprland.conf has brave keybind" {
    grep -q "SUPER.*E.*brave" "$CONFIG_FILE"
}

@test "hyprland.conf has thunar keybind" {
    grep -q "SUPER.*F.*thunar" "$CONFIG_FILE"
}

@test "hyprland.conf has discord keybind" {
    grep -q "SUPER.*C.*discord" "$CONFIG_FILE"
}

@test "hyprland.conf has steam keybind" {
    grep -q "SUPER.*S.*steam" "$CONFIG_FILE"
}

@test "hyprland.conf has wofi keybind" {
    grep -q "SUPER.*D.*wofi" "$CONFIG_FILE"
}

@test "hyprland.conf has screenshot keybind" {
    grep -q "grim.*slurp" "$CONFIG_FILE"
}

@test "hyprland.conf has media keys keybinds" {
    grep -q "XF86AudioRaiseVolume" "$CONFIG_FILE"
}

@test "hyprland.conf has brightness keybinds" {
    grep -q "XF86MonBrightness" "$CONFIG_FILE"
}

@test "hyprland.conf has workspace keybinds" {
    grep -q "SUPER.*1.*workspace" "$CONFIG_FILE"
}

@test "hyprland.conf has move-to-workspace keybinds" {
    grep -q "SUPERSHIFT.*1.*movetoworkspace" "$CONFIG_FILE"
}

@test "hyprland.conf has focus movement keybinds" {
    grep -q "SUPER.*H.*movefocus" "$CONFIG_FILE"
}

@test "hyprland.conf has fcitx5 toggle keybind" {
    grep -q "fcitx5-remote -t" "$CONFIG_FILE"
}

@test "hyprland.conf has hyprlock keybind" {
    grep -q "hyprlock" "$CONFIG_FILE"
}

# ---------------------------------------------------------------
# Border config
# ---------------------------------------------------------------

@test "hyprland.conf has border_size 3" {
    grep -q "border_size = 3" "$CONFIG_FILE"
}

@test "hyprland.conf has active gradient border" {
    grep -q "col.active_border.*00ff99" "$CONFIG_FILE"
}

@test "hyprland.conf has inactive gradient border" {
    grep -q "col.inactive_border.*00ff99" "$CONFIG_FILE"
}

# ---------------------------------------------------------------
# Balanced bracket check (basic syntax)
# ---------------------------------------------------------------

@test "hyprland.conf has balanced braces" {
    local open=$(grep -o '{' "$CONFIG_FILE" | wc -l)
    local close=$(grep -o '}' "$CONFIG_FILE" | wc -l)
    [[ "$open" -eq "$close" ]]
}
