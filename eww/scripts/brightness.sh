#!/bin/bash

case $1 in
    percent)
        brightness=$(brightnessctl -m 2>/dev/null | awk -F, '{print $4}' | tr -d '%')
        [ -z "$brightness" ] && brightness=100
        echo "$brightness"
        ;;
    icon)
        brightness=$(brightnessctl -m 2>/dev/null | awk -F, '{print $4}' | tr -d '%')
        [ -z "$brightness" ] && brightness=100

        if [ $brightness -ge 75 ]; then
            echo "󰃠"
        elif [ $brightness -ge 50 ]; then
            echo "󰃟"
        elif [ $brightness -ge 25 ]; then
            echo "󰃞"
        else
            echo "󰃝"
        fi
        ;;
    *)
        echo "100"
        ;;
esac
