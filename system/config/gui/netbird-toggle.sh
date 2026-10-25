#!/usr/bin/env bash
status=$(netbird status 2>/dev/null)
if echo "$status" | grep -q "NetBird IP:" && ! echo "$status" | grep -q "NetBird IP: N/A"; then
  netbird down
  pkill -RTMIN+9 waybar
else
  netbird up
  i=0
  while ! netbird status 2>/dev/null | grep -v "N/A" | grep -q "NetBird IP:" && [ $i -lt 15 ]; do
    sleep 1
    i=$((i + 1))
  done
  pkill -RTMIN+9 waybar
fi
