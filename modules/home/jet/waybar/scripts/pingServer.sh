#!/usr/bin/env bash
SERVER="mica"
LATENCY=$(ping -c 1 -W 0.5 "$SERVER" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}')
if [ -n "$LATENCY" ]; then
    echo "{\"text\":\"/////\",\"class\":\"up\"}"
else
    echo "{\"text\":\"\\\\\\\\\\\\\\\\\\\\\",\"class\":\"down\"}"
fi
