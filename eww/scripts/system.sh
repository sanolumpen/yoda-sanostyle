#!/bin/bash

export LC_NUMERIC=C

case $1 in
    cpu)
        cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
        [ -z "$cpu_usage" ] && cpu_usage=0
        printf "%.0f" "$cpu_usage"
        ;;
    memory)
        mem_info=$(free | grep Mem)
        total=$(echo $mem_info | awk '{print $2}')
        used=$(echo $mem_info | awk '{print $3}')
        [ -z "$total" ] && total=1
        mem_usage=$(awk "BEGIN {printf \"%.0f\", ($used/$total)*100}")
        [ -z "$mem_usage" ] && mem_usage=0
        echo "$mem_usage"
        ;;
    disk)
        disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
        [ -z "$disk_usage" ] && disk_usage=0
        echo "$disk_usage"
        ;;
    temp)
        if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
            temp=$(cat /sys/class/thermal/thermal_zone0/temp)
            temp=$(awk "BEGIN {printf \"%.1f\", $temp/1000}")
            echo "$temp"
        elif command -v sensors &> /dev/null; then
            temp=$(sensors | grep -i 'Core 0' | awk '{print $3}' | sed 's/+//;s/°C//' | head -n1)
            [ -z "$temp" ] && temp="45.0"
            echo "$temp"
        else
            echo "45.0"
        fi
        ;;
    cpu_percent)
        cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
        [ -z "$cpu_usage" ] && cpu_usage=0
        printf "%.0f" "$cpu_usage"
        ;;
    *)
        echo "0"
        ;;
esac
