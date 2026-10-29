#!/usr/bin/env bash
status=$(mullvad status 2>/dev/null)

if echo "$status" | grep -q "Connected"; then
  location=$(echo "$status" | sed -n 's/^ *Visible location:[[:space:]]*[^,]*, \([^.]*\)\. IPv4.*/\1/p')
  echo "{\"text\":\"󰒃 ${location}\",\"class\":\"connected\",\"tooltip\":\"Mullvad: connected (${location})\"}"
else
  echo '{"text":"󰒃","class":"disconnected","tooltip":"Mullvad: disconnected"}'
fi
