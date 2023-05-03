chosen=$(printf 'Integrated\nHybrid\n%s (active)' "$(system76-power graphics)" | rofi -dmenu -i -theme-str '@import "power.rasi"')

case "$chosen" in
"Integrated")
	system76-power graphics integrated
	dunstify "Integrated graphics selected" "This change will take effect after restarting"
	;;
"Hybrid")
	system76-power graphics hybrid
	dunstify "Hybrid graphics selected" "This change will take effect after restarting"
	;;
*)
	exit 1
	;;
esac
