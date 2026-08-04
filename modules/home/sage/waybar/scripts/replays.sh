#!/usr/bin/env bash

STATE="/tmp/replays"

if [ ! -f "$STATE" ]; then
  echo '{"text":"REPLAYS","tooltip":"Waiting for first sync","class":"waiting"}'
  exit 0
fi

STATUS=$(sed -n '1p' "$STATE")
MESSAGE=$(sed -n '2p' "$STATE")
TIMESTAMP=$(sed -n '3p' "$STATE")
FORMATTED=$(date -d "$TIMESTAMP" "+%d %b, %H:%M" 2>/dev/null || echo "--")

case "$STATUS" in
  ok)
    echo "{\"text\":\"REPLAYS\",\"tooltip\":\"Last sync: $FORMATTED\\r$MESSAGE\",\"class\":\"ok\"}"
    ;;
  *)
    echo "{\"text\":\"REPLAYS\",\"tooltip\":\"Last sync: $FORMATTED\\r$MESSAGE\",\"class\":\"error\"}"
    ;;
esac
