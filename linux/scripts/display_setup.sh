#! /usr/bin/env bash

{
    date
    echo "Arguments"
    for arg in "$@"; do
        echo "$arg"
    done

    EXTERNAL="DP-1"
    INTERNAL="eDP-1"
    refresh_rate=60

    cat /sys/class/power_supply/AC*/online | grep -q 1
    is_on_battery=$?

    if xrandr | grep -q "^${EXTERNAL} connected"; then
        [[ $is_on_battery -eq 0 ]] && refresh_rate=165
        xrandr --output "$INTERNAL" --off --output "$EXTERNAL" --mode 2560x1440 --rate "$refresh_rate" --primary
    else
        [[ $is_on_battery -eq 0 ]] && refresh_rate=144
        xrandr --output "$INTERNAL" --mode 1920x1080 --rate "$refresh_rate" --primary
    fi

    if [[ $is_on_battery -eq 0 ]]; then
        echo "AC power connected"
        picom &
        feh --bg-fill /var/tmp/wallpaper
    else
        echo "On battery"
        pkill picom
    fi

    ~/.config/polybar/launch.sh > /dev/null 2>&1
    echo "##############################################################################################"
} >> /var/tmp/display_setup.log 2>&1
