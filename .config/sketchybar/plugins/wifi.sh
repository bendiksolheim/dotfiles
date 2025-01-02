#!/usr/bin/env sh

CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(ipconfig getsummary en0 | awk -F ' SSID : ' '/ SSID : / {print $2}')"

if [ "$SSID" = "" ]; then
  sketchybar --set $NAME label="" icon=󰤯
else
  sketchybar --set $NAME label="$SSID" icon=󰤨
fi
