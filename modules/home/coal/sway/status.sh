#!/bin/bash

# Seed CPU baseline
read -r cpu_line < /proc/stat
read -ra cpu_fields <<< "$cpu_line"
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

net="NET: disconnected"
last_net_update=0

while true; do
    bat=$(cat /sys/class/power_supply/BAT1/capacity)
    status=$(cat /sys/class/power_supply/BAT1/status)

    case "$status" in
        Charging) sym="+" ;;
        Discharging|Not\ charging) sym="-" ;;
        *) sym="?" ;;
    esac

    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{print int($2*100)}')

    now=$(date +%s)
    if [ $((now - last_net_update)) -ge 10 ]; then
        ssid=$(nmcli -t -f ACTIVE,SSID dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2)
        [ -n "$ssid" ] && net="NET: ${ssid}" || net="NET: disconnected"
        last_net_update=$now
    fi

    # CPU usage this second
    read -r cpu_line < /proc/stat
    read -ra cpu_fields <<< "$cpu_line"
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
    # shellcheck disable=SC2154 # old is assigned via eval above
    sum=$((sum - old + cpu_usage))
    eval "v$idx=$cpu_usage"
    idx=$(((idx + 1) % max))
    [ "$count" -lt "$max" ] && count=$((count + 1))

    avg=$((sum / count))

    # MEM
    mem=$(free -m | awk '/Mem:/ {printf "%.0f", 100*$3/$2}')

    # Temperature
    temp="N/A"
    for f in /sys/class/thermal/thermal_zone*/temp; do
        [ -r "$f" ] || continue
        read -r temp_raw < "$f"
        temp=$((temp_raw / 1000))
        break
    done

    # Brightness
    brightness="N/A"
    for f in /sys/class/backlight/*/brightness; do
        [ -r "$f" ] || continue
        read -r bl < "$f"
        read -r blmax < "${f%/*}/max_brightness"
        if [ "$blmax" -ne 0 ]; then
            brightness=$((100 * bl / blmax))
        fi
        break
    done

    date=$(date '+%a %d %b %H:%M')

    echo "CPU: ${avg}% | MEM: ${mem}% | VOL: ${vol}% | ${net} | TEMP: ${temp}° | BACK: ${brightness}% | BAT: ${bat}% [${sym}] | ${date}"
    sleep 0.5
done
