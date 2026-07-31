#!/bin/bash

declare -A fired

while true; do
    bat=$(cat /sys/class/power_supply/BAT1/capacity)
    status=$(cat /sys/class/power_supply/BAT1/status)

    if [ "$status" != "Charging" ]; then
        if [ "$bat" -le 25 ] && [ -z "${fired[25]}" ]; then
            fired[25]=1
            notify-send "Battery is low!"
        fi
        if [ "$bat" -le 15 ] && [ -z "${fired[15]}" ]; then
            fired[15]=1
            notify-send -u critical "Battery is critically low!"
        fi
        if [ "$bat" -le 10 ] && [ -z "${fired[10]}" ]; then
            fired[10]=1
            notify-send -u critical "Battery is critically low!"
        fi
        if [ "$bat" -le 5 ] && [ -z "${fired[5]}" ]; then
            fired[5]=1
            notify-send -u critical "Battery is critically low!"
        fi
    else
        fired=()
    fi

    sleep 60
done
