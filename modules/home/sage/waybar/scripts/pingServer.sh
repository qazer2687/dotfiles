#!/usr/bin/env bash

SERVER="mica"

if ping -c 1 -W 1 "$SERVER" &> /dev/null; then
    echo '{"text":"MICA: ONLINE","class":"up"}'
else
    echo '{"text":"MICA: OFFLINE","class":"down"}'
fi
