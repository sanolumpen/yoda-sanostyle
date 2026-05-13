#!/bin/bash

current=$(fcitx5-remote -n 2>/dev/null)

if [[ -z "$current" ]]; then
    echo "  EN"
    exit 0
fi

case "$current" in
    *keyboard-us*|*"keyboard-en"*)
        echo "  EN"
        ;;
    *mozc*|*anthy*|*kkc*|*skk*|*japanese*)
        echo "  JP"
        ;;
    *)
        echo "  $current"
        ;;
esac
