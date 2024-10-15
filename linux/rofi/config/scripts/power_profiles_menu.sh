#!/usr/bin/env bash

chosen=$(printf '  Battery\n  Balanced\n  Performance\n%s (active)' "$(system76-power profile | grep -oP 'Power Profile: \K\w+')" | rofi -dmenu -i -theme ~/.config/rofi/config/launcher.rasi)

case "$chosen" in
"  Battery")
	system76-power profile battery
	xrandr -s 1920x1080 -r 60
	notify-send " Battery saver mode activated"
	;;
"  Balanced")
	system76-power profile balanced
	notify-send " Balanced mode activated"
	;;
"  Performance")
	system76-power profile performance
	notify-send " Performance mode activated"
	;;
*) exit 1 ;;
esac
