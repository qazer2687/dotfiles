#!/usr/bin/env bash
SERVER="mica"

LATENCY=$(ping -c 1 -W 0.5 "$SERVER" 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}')

if [ -n "$LATENCY" ]; then
    printf '{"text":"MICA: CONNECTED","class":"up","latency_ms":"| %sms"}\n' "$LATENCY"
else
    printf '{"text":"MICA: DISCONNECTED","class":"down","latency_ms":""}\n'
fi
