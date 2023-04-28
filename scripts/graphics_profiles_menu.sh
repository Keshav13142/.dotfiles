chosen=$(printf "Integrated\nHybrid\n" | rofi -dmenu -i -theme-str '@import "power.rasi"')

case "$chosen" in
	"Integrated") system76-power graphics integrated ;;
	"Hybrid") system76-power graphics hybrid ;;
	*) exit 1 ;;
esac
