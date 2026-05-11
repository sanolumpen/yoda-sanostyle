#!/bin/bash

OFFSET=${2:-0}

case "$1" in
    "year")
        date -d "${OFFSET} months" '+%Y'
        ;;
    "month")
        date -d "${OFFSET} months" '+%B'
        ;;
    "month-num")
        date -d "${OFFSET} months" '+%-m'
        ;;
    "month-short")
        date -d "${OFFSET} months" '+%b' | tr '[:lower:]' '[:upper:]'
        ;;
    "current-day")
        date '+%d' | sed 's/^0//'
        ;;
    "week"*)
        week_num="${1#week}"

        current_year=$(date -d "${OFFSET} months" '+%Y')
        current_month=$(date -d "${OFFSET} months" '+%m')
        current_day=$(date '+%d' | sed 's/^0//')

        # %u = 1 (Mon) to 7 (Sun) - convert to 0-6 starting Monday
        first_day=$(date -d "${current_year}-${current_month}-01" '+%u')
        first_day=$((first_day - 1))

        days_in_month=$(date -d "${current_year}-${current_month}-01 +1 month -1 day" '+%d')

        output="["
        day_counter=1

        start_pos=$((week_num * 7))
        end_pos=$((start_pos + 7))

        for ((i=start_pos; i<end_pos; i++)); do
            if [ $i -lt $first_day ]; then
                output="${output}{\"day\":\"\",\"current\":\"false\"}"
            elif [ $day_counter -le $days_in_month ]; then
                day_value=$((i - first_day + 1))
                if [ $day_value -le $days_in_month ] && [ $day_value -gt 0 ]; then
                    is_current="false"
                    if [ $day_value -eq $current_day ]; then
                        is_current="true"
                    fi
                    output="${output}{\"day\":\"$day_value\",\"current\":\"$is_current\"}"
                    day_counter=$((day_value + 1))
                else
                    output="${output}{\"day\":\"\",\"current\":\"false\"}"
                fi
            else
                output="${output}{\"day\":\"\",\"current\":\"false\"}"
            fi

            if [ $i -lt $((end_pos - 1)) ]; then
                output="${output},"
            fi
        done

        output="${output}]"
        echo "$output"
        ;;
    *)
        echo "[]"
        ;;
esac
