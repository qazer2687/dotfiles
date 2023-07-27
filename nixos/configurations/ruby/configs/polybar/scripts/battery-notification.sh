#!/usr/bin/env bash

battery_capacity=$(cat /sys/class/power_supply/BAT1/capacity)
dunstify -a "Polybar" "Battery Percentage: $battery_capacity%"