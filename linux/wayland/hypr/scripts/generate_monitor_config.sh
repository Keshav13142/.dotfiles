#!/usr/bin/env bash

EXTERNAL="DP-1"
INTERNAL="eDP-1"
MONCONFIG="$HOME/.config/hypr/conf/monitors.conf"
ALL_MONITORS=$(hyprctl monitors all -j)
ON_AC=1

if cat /sys/class/power_supply/AC*/online 2>/dev/null | grep -q 0; then
  ON_AC=0
fi

EXTERNAL_CONNECTED=$(echo "$ALL_MONITORS" | jq -r ".[] | select(.name==\"$EXTERNAL\" and .disabled==false) | .name")
INTERNAL_DISABLED=$(echo "$ALL_MONITORS" | jq -r ".[] | select(.name==\"$INTERNAL\") | .disabled")

INTERNAL_RATE=$([ "$ON_AC" = 1 ] && echo 144 || echo 60)
EXTERNAL_RATE=$([ "$ON_AC" = 1 ] && echo 165 || echo 60)

if [ -n "$EXTERNAL_CONNECTED" ]; then
  if [ "$INTERNAL_DISABLED" = "false" ]; then
    printf 'monitor=%s,disable\n' "$INTERNAL" > "$MONCONFIG"
  else
    : > "$MONCONFIG"
  fi
  printf 'monitor=%s,2560x1440@%s,0x0,1\n' "$EXTERNAL" "$EXTERNAL_RATE" >> "$MONCONFIG"
else
  printf 'monitor=%s,disabled\n' "$EXTERNAL" > "$MONCONFIG"
  printf 'monitor=%s,1920x1080@%s,0x0,1\n' "$INTERNAL" "$INTERNAL_RATE" >> "$MONCONFIG"
fi

