#!/usr/bin/env bash

external="DP-1"
internal="eDP-1"
refresh_rate=60
all_monitors="hyprctl monitors all -j"

cat /sys/class/power_supply/AC*/online | grep -q 0
is_on_battery=$?

is_laptop_monitor_disabled=$($all_monitors | jq '.[] | select(.name==$internal) | .disabled' --arg internal $internal)
external_connected=$($all_monitors | jq '.[] | select(.name==$external and .disabled==false) | .name' --arg external $external -e)

if [ ! -z "$external_connected" ]; then
    [ "$is_laptop_monitor_disabled" = 'false' ] && hyprctl keyword monitor "$internal,disable"
    [ $is_on_battery = 1 ] && refresh_rate=165
    hyprctl keyword monitor "$external,2560x1440@$refresh_rate,0x0,1"
else
    [ $is_on_battery = 1 ] && refresh_rate=144
    hyprctl keyword monitor "$internal,1920x1080@$refresh_rate,0x0,1"
fi
