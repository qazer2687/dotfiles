#!/bin/bash

# Seed CPU baseline
read -r cpu_line < /proc/stat
cpu_fields=($cpu_line)
idle=${cpu_fields[4]}
iowait=${cpu_fields[5]}
prev_idle=$((idle + iowait))
prev_total=0
for i in "${cpu_fields[@]:1}"; do
    prev_total=$((prev_total + i))
done

idx=0
sum=0
count=0
max=15

for i in {0..14}; do
    eval "v$i=0"
done

while true; do
    bat=$(cat /sys/class/power_supply/BAT1/capacity)
    status=$(cat /sys/class/power_supply/BAT1/status)

    case "$status" in
        Charging) sym="+" ;;
        Discharging|Not\ charging) sym="-" ;;
        *) sym="?" ;;
    esac

    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{print int($2*100)}')

    ssid=$(nmcli -t -f ACTIVE,SSID dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2)
    [ -n "$ssid" ] && net="NET: ${ssid}" || net="NET: disconnected"

    # CPU usage this second
    read -r cpu_line < /proc/stat
    cpu_fields=($cpu_line)
    idle=${cpu_fields[4]}
    iowait=${cpu_fields[5]}
    total=0
    for i in "${cpu_fields[@]:1}"; do
        total=$((total + i))
    done
    diff_idle=$((idle + iowait - prev_idle))
    diff_total=$((total - prev_total))
    if [ "$diff_total" -gt 0 ]; then
        cpu_usage=$((100 * (diff_total - diff_idle) / diff_total))
    else
        cpu_usage=0
    fi
    prev_idle=$((idle + iowait))
    prev_total=$total

    # Circular buffer over 15 seconds
    eval "old=\$v$idx"
    sum=$((sum - old + cpu_usage))
    eval "v$idx=$cpu_usage"
    idx=$(((idx + 1) % max))
    [ "$count" -lt "$max" ] && count=$((count + 1))

    avg=$((sum / count))

    # MEM
    mem=$(free -m | awk '/Mem:/ {printf "%.0f", 100*$3/$2}')

    # Temperature
    temp_raw=$(cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null | head -1)
    [ -n "$temp_raw" ] && temp=$((temp_raw / 1000)) || temp="N/A"

    # Brightness
    bl=$(cat /sys/class/backlight/*/brightness 2>/dev/null | head -1)
    blmax=$(cat /sys/class/backlight/*/max_brightness 2>/dev/null | head -1)
    if [ -n "$bl" ] && [ -n "$blmax" ] && [ "$blmax" -ne 0 ]; then
        brightness=$((100 * bl / blmax))
    else
        brightness="N/A"
    fi

    date=$(date '+%a %d %b %H:%M')

    echo "CPU: ${avg}% | MEM: ${mem}% | VOL: ${vol}% | ${net} | TEMP: ${temp}° | BACK: ${brightness}% | BAT: ${bat}% (${sym}) | ${date}"
    sleep 1
done
