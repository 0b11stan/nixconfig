#!/usr/bin/env bash
mullvad connect
i=0
while ! mullvad status | grep -q Connected && [ $i -lt 15 ]; do
  sleep 1
  i=$((i + 1))
done
pkill -RTMIN+8 waybar
