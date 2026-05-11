#!/bin/bash

LANG_FILE="$HOME/.cache/desktop_lang"
CURRENT_LANG="es"
if [ -f "$LANG_FILE" ]; then
    CURRENT_LANG=$(cat "$LANG_FILE")
fi

if [ "$CURRENT_LANG" = "es" ]; then
    export LC_TIME="es_AR.UTF-8"
else
    export LC_TIME="en_US.UTF-8"
fi

case "$1" in
    month) date '+%b' | tr '[:lower:]' '[:upper:]' ;;
    weekday) date '+%A' | tr '[:lower:]' '[:upper:]' ;;
    time) date '+%I:%M %p' ;;
    *) date ;;
esac
