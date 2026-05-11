#!/bin/bash

case $1 in
    volume)
        vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{print int($2 * 100)}')
        [ -z "$vol" ] && vol=50
        echo "$vol"
        ;;
    muted)
        wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | grep -q "MUTED" && echo "true" || echo "false"
        ;;
    icon)
        vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{print int($2 * 100)}')
        [ -z "$vol" ] && vol=50
        muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | grep -q "MUTED" && echo "true" || echo "false")

        if [ "$muted" = "true" ]; then
            echo "󰝟"
        elif [ $vol -ge 70 ]; then
            echo "󰕾"
        elif [ $vol -ge 30 ]; then
            echo "󰖀"
        else
            echo "󰕿"
        fi
        ;;
    *)
        echo "50"
        ;;
esac
