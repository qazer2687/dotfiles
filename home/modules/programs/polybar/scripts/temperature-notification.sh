#!/usr/bin/env bash

temperature=$(cat /sys/class/thermal/thermal_zone0/temp)
temperature_celsius=$(awk "BEGIN {print $temperature/1000}")
dunstify -a "Polybar" "Current Temperature: $temperature_celsius°C"