#!/bin/bash
export HOME=/home/sanodesu
export DBUS_SESSION_BUS_ADDRESS="${DBUS_SESSION_BUS_ADDRESS:-unix:path=/run/user/1000/bus}"
export XDG_RUNTIME_DIR="/run/user/1000"
python3 /home/sanodesu/.config/eww/scripts/gcal.py "$@" 2>/dev/null || echo "[]"
