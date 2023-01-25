#!/bin/bash
while true; do
status=$(cat /sys/class/power_supply/BAT0/status)
battery_percent=$(cat /sys/class/power_supply/BAT0/capacity)
  if [ "$status" == Discharging ] && [ "$battery_percent" -le 4 ]; then 
    notify-send "Critical Battery Percentage " "Save Your Work Bitch..!!"
    sleep 58
    notify-send "Shutting Down" ":("
    sleep 2
    shutdown now
fi
  sleep 240
done
