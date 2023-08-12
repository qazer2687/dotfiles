#!/usr/bin/env bash

wifi_interface="wlp3s0"
wifi_signal=$(grep "^\s*w" /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

if [ "$(hostname)" == "jade" ]; then
    dunstify -a "Error" "No WiFi Adapted Detected"
elif [ "$(hostname)" == "ruby" ]; then
    dunstify -a "Polybar" "Signal Strength: $wifi_signal%"
else
    dunstify -a "Error" "Wrong Host"
fi