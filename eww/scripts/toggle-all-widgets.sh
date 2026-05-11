#!/bin/bash

case "$1" in
    dashboard)
        if eww active-windows 2>/dev/null | grep -q "dashboard_window"; then
            eww close dashboard_window
        else
            eww open dashboard_window
        fi
        ;;
    calendar)
        if eww active-windows 2>/dev/null | grep -q "date_window"; then
            eww close date_window
        else
            eww open date_window
        fi
        ;;
    football)
        if eww active-windows 2>/dev/null | grep -q "football_window"; then
            eww close football_window
        else
            eww open football_window
        fi
        ;;
    notes)
        if eww active-windows 2>/dev/null | grep -q "notes_window"; then
            eww close notes_window
        else
            eww open notes_window
        fi
        ;;
esac