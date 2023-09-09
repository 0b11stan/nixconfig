#!/bin/sh

CHARGE=$(acpi -b | grep -P -o [0-9]+(?=%))

notify() {
  notify-desktop --urgency=$1 -t 10000 $2 "Batterie faible ( < $3% )"
}

if [[ $CHARGE -eq 13 ]]; then
  notify 'critical' 'WARNING' $CHARGE
elif [[ $CHARGE -eq 25 ]]; then
  notify 'normal' 'Warning' $CHARGE
elif [[ $CHARGE -eq 50 ]]; then
  notify 'normal' 'Info' $CHARGE
fi
