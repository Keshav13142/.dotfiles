chosen=$(printf '  Battery\n  Balanced\n  Performance\n%s (active)' "$(system76-power profile | grep -oP 'Power Profile: \K\w+')" | rofi -dmenu -i -theme-str '@import "power.rasi"')

case "$chosen" in
	"  Battery") system76-power profile battery ;;
	"  Balanced") system76-power profile balanced ;;
	"  Performance") system76-power profile performance ;;
	*) exit 1 ;;
esac
