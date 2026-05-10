#!/bin/bash

# Get current fcitx5 input method
current=$(fcitx5-remote -n 2>/dev/null)

if [[ -z "$current" ]]; then
    echo "󰟓  EN"
    exit 0
fi

# Map input method to display text with Nerd Font icons
case "$current" in
    *keyboard-us*|*"keyboard-en"*)
        echo "󰟓  EN"
        ;;
    *mozc*|*anthy*|*kkc*|*skk*|*japanese*)
        echo "󰟓  JP"
        ;;
    *)
        echo "󰟓  $current"
        ;;
esac
