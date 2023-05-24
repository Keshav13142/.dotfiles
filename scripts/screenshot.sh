rofi_command="rofi -theme ~/.config/rofi/config/screenshot.rasi"

# Error msg
msg() {
	rofi -theme "$dir/message.rasi" -e "Please install 'scrot' first."
}

# Options
screen=""
area=""
window=""

# Variable passed to rofi
options="$screen\n$area\n$window"

chosen="$(echo -e "$options" | $rofi_command -p '' -dmenu -selected-row 1)"
case $chosen in
$screen)
	if [[ -f /usr/local/bin/scrot ]]; then
		sleep 1
		scrot -e 'mv $f ~/Pictures/Screenshots/Screenshot_%Y-%m-%d-%S_$wx$h.png'
	else
		msg
	fi
	;;
$area)
	if [[ -f /usr/local/bin/scrot ]]; then
		scrot -s -e 'mv $f ~/Pictures/Screenshots/Screenshot_%Y-%m-%d-%S_$wx$h.png'
	else
		msg
	fi
	;;
$window)
	if [[ -f /usr/local/bin/scrot ]]; then
		sleep 1
		scrot -u -e 'mv $f ~/Pictures/Screenshots/Screenshot_%Y-%m-%d-%S_$wx$h.png'
	else
		msg
	fi
	;;
esac
