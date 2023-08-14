#!/usr/bin/env bash

battery_capacity=$(cat /sys/class/power_supply/BAT1/capacity)

if [ "$(hostname)" == "jade" ]; then
    dunstify -a "Error" "No Battery Detected"
elif [ "$(hostname)" == "ruby" ]; then
    dunstify -a "Polybar" "Battery Percentage: $battery_capacity%"echo "Hostname is ruby. Performing action for ruby..."
else
    dunstify -a "Error" "Wrong Host"
fi

