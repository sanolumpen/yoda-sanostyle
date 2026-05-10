#!/bin/bash
OFFSET_FILE="$HOME/.cache/eww_cal_offset"
DAY_FILE="$HOME/.cache/eww_selected_day"

refresh_calendar() {
    OFFSET=$(cat "$OFFSET_FILE" 2>/dev/null || echo 0)
    eww update calendar_year="$(~/.config/eww/scripts/calendar.sh year $OFFSET)"
    eww update calendar_month="$(~/.config/eww/scripts/calendar.sh month $OFFSET)"
    eww update calendar_month_num="$(~/.config/eww/scripts/calendar.sh month-num $OFFSET)"
    eww update calendar_week0="$(~/.config/eww/scripts/calendar.sh week0 $OFFSET)"
    eww update calendar_week1="$(~/.config/eww/scripts/calendar.sh week1 $OFFSET)"
    eww update calendar_week2="$(~/.config/eww/scripts/calendar.sh week2 $OFFSET)"
    eww update calendar_week3="$(~/.config/eww/scripts/calendar.sh week3 $OFFSET)"
    eww update calendar_week4="$(~/.config/eww/scripts/calendar.sh week4 $OFFSET)"
    eww update calendar_week5="$(~/.config/eww/scripts/calendar.sh week5 $OFFSET)"
}

case "$1" in
    "prev")
        current=$(cat "$OFFSET_FILE" 2>/dev/null || echo 0)
        echo $((current - 1)) > "$OFFSET_FILE"
        refresh_calendar
        ;;
    "next")
        current=$(cat "$OFFSET_FILE" 2>/dev/null || echo 0)
        echo $((current + 1)) > "$OFFSET_FILE"
        refresh_calendar
        ;;
    "reset")
        echo 0 > "$OFFSET_FILE"
        refresh_calendar
        ;;
    "toggle_picker")
        current=$(eww state | grep "^cal_show_picker" | awk '{print $2}')
        if [ "$current" = "true" ]; then
            eww update cal_show_picker=false
        else
            eww update cal_show_picker=true
        fi
        ;;
    "year_prev")
        current=$(cat "$OFFSET_FILE" 2>/dev/null || echo 0)
        echo $((current - 12)) > "$OFFSET_FILE"
        refresh_calendar
        ;;
    "year_next")
        current=$(cat "$OFFSET_FILE" 2>/dev/null || echo 0)
        echo $((current + 12)) > "$OFFSET_FILE"
        refresh_calendar
        ;;
    "goto_month")
        OFFSET=$(cat "$OFFSET_FILE" 2>/dev/null || echo 0)
        CURRENT_YEAR=$(~/.config/eww/scripts/calendar.sh year $OFFSET)
        TODAY_MONTH=$(date '+%-m')
        TODAY_YEAR=$(date '+%Y')
        NEW_OFFSET=$(( ($CURRENT_YEAR - $TODAY_YEAR) * 12 + $2 - $TODAY_MONTH ))
        echo $NEW_OFFSET > "$OFFSET_FILE"
        eww update cal_show_picker=false
        refresh_calendar
        ;;
    "day")
        DAY_NUM=$(printf '%02d' $2)
        OFFSET=$(cat "$OFFSET_FILE" 2>/dev/null || echo 0)
        FULL_DATE=$(date -d "$(date '+%Y-%m-01') ${OFFSET} month" "+%Y-%m-${DAY_NUM}")
        echo "$FULL_DATE" > "$DAY_FILE"
        eww update cal_selected_day="$FULL_DATE"
        eww update cal_show_day=true
        eww update gcal_day_events="$(python3 /home/sanodesu/.config/eww/scripts/gcal.py day $FULL_DATE)"
        ;;
    "hide_day")
        eww update cal_show_day=false
        eww update cal_selected_day=""
        ;;
esac
