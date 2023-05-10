chosen=$(printf '  Battery\n  Balanced\n  Performance\n%s (active)' "$(system76-power profile | grep -oP 'Power Profile: \K\w+')" | rofi -dmenu -i -theme-str '@import "power.rasi"')

case "$chosen" in
"  Battery")
	system76-power profile battery
	xrandr -s 1920x1080 -r 60
	dunstify " Battery saver mode activated"
	;;
"  Balanced")
	system76-power profile balanced
	dunstify " Balanced mode activated"
	;;
"  Performance")
	system76-power profile performance
	dunstify " Performance mode activated"
	;;
*) exit 1 ;;
esac
