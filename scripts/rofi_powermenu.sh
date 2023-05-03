case "$(printf " Power off\n Restart\n Lock\n Sleep\n Logout" | rofi -dmenu -i -theme-str '@import "~/.config/rofi/power.rasi"')" in
" Power off") systemctl poweroff ;;
" Restart") systemctl reboot ;;
" sleep") systemctl suspend ;;
" Lock") betterlockscreen -l ;;
" Logout") i3-msg exit ;;
*) exit 1 ;;
esac
