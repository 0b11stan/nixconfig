#!/usr/bin/env bash
status=$(mullvad status 2>/dev/null)

if echo "$status" | grep -q "Connected"; then
  echo '{"text":"󰒃","class":"connected","tooltip":"Mullvad: connected"}'
else
  echo '{"text":"󰒃","class":"disconnected","tooltip":"Mullvad: disconnected"}'
fi
