rofi_command="rofi -theme ~/.config/rofi/config/screenshot.rasi"

# Options
screen="󱣴"
area="󰩬"
window=""

# Variable passed to rofi
options="$screen\n$area\n$window"

chosen="$(echo "$options" | $rofi_command -p '' -dmenu -selected-row 0)"
case $chosen in
$screen)
  sleep 1;
	scrot ~/Pictures/Screenshots/%d-%b-%Y-%I:%M-%p.png;
	exec notify-send "Screenshot has been saved";
	;;
$area)
	scrot ~/Pictures/Screenshots/%d-%b-%Y-%I:%M-%p.png -s;
	exec notify-send "Screenshot has been saved";
	;;
$window)
  sleep 1
	scrot ~/Pictures/Screenshots/%d-%b-%Y-%I:%M-%p.png -u;
	exec notify-send "Screenshot has been saved";
	;;
esac
