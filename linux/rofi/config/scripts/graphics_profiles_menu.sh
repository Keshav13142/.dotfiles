#!/usr/bin/env bash

chosen=$(printf 'Integrated\nHybrid\nNvidia\n%s (active)' "$(system76-power graphics)" | rofi -dmenu -i -theme ~/.config/rofi/config/launcher.rasi)

case "$chosen" in
"Integrated")
	system76-power graphics integrated
	notify-send "Integrated graphics selected" "This change will take effect after restarting"
	;;
"Hybrid")
	system76-power graphics hybrid
	notify-send "Hybrid graphics selected" "This change will take effect after restarting"
	;;
"Nvidia")
	system76-power graphics nvidia
	notify-send "Nvidia graphics selected" "This change will take effect after restarting"
	;;
*)
	exit 1
	;;
esac
