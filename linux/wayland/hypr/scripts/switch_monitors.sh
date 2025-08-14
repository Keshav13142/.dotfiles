#!/usr/bin/env bash

INTERNAL_MONITOR="eDP-1"
EXTERNAL_MONITOR="DP-1"

NUM_MONITORS_ACTIVE=$(wlr-randr | grep -E --count "\bDP-1")

if [ "$NUM_MONITORS_ACTIVE" -ge 1 ]; then
    [ "$(wlr-randr | grep "eDP-1" -A 5 | grep "Enabled" | awk -F":" '{print $2}' | xargs)" = "yes" ] && hyprctl keyword monitor "$INTERNAL_MONITOR,disable"
    [ "$(wlr-randr | grep "DP-1" -A 5 | grep "Enabled" | awk -F":" '{print $2}' | xargs)" = "yes" ] && hyprctl keyword monitor "$EXTERNAL_MONITOR,2560x1440@144,0x0,1"
else
    hyprctl keyword monitor "$INTERNAL_MONITOR,1920x1080@144,0x0,1"
fi
