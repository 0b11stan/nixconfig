#!/usr/bin/env bash
status=$(netbird status 2>/dev/null)

if echo "$status" | grep -q "NetBird IP:" && ! echo "$status" | grep -q "NetBird IP: N/A"; then
  echo '{"text":"󰌘","class":"connected","tooltip":"Netbird: connected"}'
else
  echo '{"text":"󰌙","class":"disconnected","tooltip":"Netbird: disconnected"}'
fi
