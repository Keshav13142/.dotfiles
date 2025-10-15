#!/usr/bin/env bash

EXTERNAL="DP-1"
power_state=ac

if cat /sys/class/power_supply/AC*/online 2>/dev/null | grep -q 0; then
  power_state=bat
fi

EXTERNAL_CONNECTED=$(hyprctl monitors all -j | jq -r ".[] | select(.name==\"$EXTERNAL\" and .disabled==false) | .name")

echo "$power_state"
echo "$EXTERNAL_CONNECTED"

if [ -n "$EXTERNAL_CONNECTED" ]; then
  "$HOME/.config/hypr/scripts/symlink_monitor_config.sh" "${power_state}-dp"
else
  "$HOME/.config/hypr/scripts/symlink_monitor_config.sh" "${power_state}-in"
fi

hyprctl reload
