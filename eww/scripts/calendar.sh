#!/bin/bash
# Calendar script para eww — con soporte de navegación por offset de mes e idioma ES/EN
# Uso: calendar.sh <year|month|weekN> [offset]

OFFSET="${2:-$(cat ~/.cache/eww_cal_offset 2>/dev/null || echo 0)}"
LANG_PREF=$(cat ~/.cache/eww_cal_lang 2>/dev/null || echo "es")

# Calcular año y mes con el offset aplicado
TARGET=$(date -d "$(date '+%Y-%m-01') ${OFFSET} month" '+%Y-%m')
TARGET_YEAR=$(echo "$TARGET" | cut -d'-' -f1)
TARGET_MONTH=$(echo "$TARGET" | cut -d'-' -f2)

CURRENT_DAY=$(date '+%d' | sed 's/^0//')
CURRENT_MONTH=$(date '+%m')
CURRENT_YEAR=$(date '+%Y')

# Nombres de meses en español
declare -A MES_ES=(
    [1]="enero" [2]="febrero" [3]="marzo" [4]="abril"
    [5]="mayo" [6]="junio" [7]="julio" [8]="agosto"
    [9]="septiembre" [10]="octubre" [11]="noviembre" [12]="diciembre"
)

get_month_name() {
    local month_num=$((10#$TARGET_MONTH))
    if [ "$LANG_PREF" = "es" ]; then
        echo "${MES_ES[$month_num]}"
    else
        LC_TIME=en_US.UTF-8 date -d "${TARGET_YEAR}-${TARGET_MONTH}-01" '+%B'
    fi
}

# Header días: ES = D L M X J V S, EN = S M T W T F S
get_days_header() {
    if [ "$LANG_PREF" = "es" ]; then
        echo '["D","L","M","X","J","V","S"]'
    else
        echo '["S","M","T","W","T","F","S"]'
    fi
}

case "$1" in
    "year")
        echo "$TARGET_YEAR"
        ;;
    "month")
        get_month_name
        ;;
    "month-short")
        if [ "$LANG_PREF" = "es" ]; then
            month_num=$((10#$TARGET_MONTH))
            echo "${MES_ES[$month_num]}" | cut -c1-3
        else
            LC_TIME=en_US.UTF-8 date -d "${TARGET_YEAR}-${TARGET_MONTH}-01" '+%b' | tr '[:lower:]' '[:upper:]'
        fi
        ;;
    "days-header")
        get_days_header
        ;;
    "lang")
        echo "$LANG_PREF"
        ;;
    "current-day")
        echo "$CURRENT_DAY"
        ;;
    "month-num")
        echo "$((10#$TARGET_MONTH))"
        ;;
    "week"*)
        week_num="${1#week}"

        first_day=$(date -d "${TARGET_YEAR}-${TARGET_MONTH}-01" '+%u')
        [ "$first_day" -eq 7 ] && first_day=0

        days_in_month=$(date -d "${TARGET_YEAR}-${TARGET_MONTH}-01 +1 month -1 day" '+%d')

        output="["
        start_pos=$((week_num * 7))
        end_pos=$((start_pos + 7))

        for ((i=start_pos; i<end_pos; i++)); do
            if [ $i -lt $first_day ]; then
                cell="{\"day\":\"\",\"current\":\"false\"}"
            else
                day_value=$((i - first_day + 1))
                if [ $day_value -le $days_in_month ] && [ $day_value -gt 0 ]; then
                    is_current="false"
                    if [ "$day_value" -eq "$CURRENT_DAY" ] && \
                       [ "$TARGET_MONTH" -eq "$CURRENT_MONTH" ] && \
                       [ "$TARGET_YEAR" -eq "$CURRENT_YEAR" ]; then
                        is_current="true"
                    fi
                    cell="{\"day\":\"$day_value\",\"current\":\"$is_current\"}"
                else
                    cell="{\"day\":\"\",\"current\":\"false\"}"
                fi
            fi

            output="${output}${cell}"
            [ $i -lt $((end_pos - 1)) ] && output="${output},"
        done

        output="${output}]"
        echo "$output"
        ;;
    *)
        echo "Usage: $0 {year|month|month-short|days-header|lang|current-day|week0-5} [offset]"
        exit 1
        ;;
esac
