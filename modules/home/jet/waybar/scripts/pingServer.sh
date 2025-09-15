#!/usr/bin/env bash

SERVER="mica"

if ping -c 1 -W 1 "$SERVER" &> /dev/null; then
    echo '{"text": "MICA: UP", "class": "up"}'
else
    echo '{"text": "MICA: DOWN", "class": "down"}'
fi