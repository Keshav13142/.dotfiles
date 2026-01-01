#!/usr/bin/env bash

monitor_conf_file="$XDG_CONFIG_HOME/hypr/conf/monitor.conf"
config_base="$XDG_CONFIG_HOME/hyprdynamicmonitors/hyprconfigs"

active_profile=$(basename "$(realpath "$monitor_conf_file")" | awk -F'.' '{print $1}')

profiles=(
  monitor-only-bat
  monitor-only-ac
  laptop-only-bat
  laptop-only-ac
)

menu=""
for p in "${profiles[@]}"; do
  if [[ "$p" == "$active_profile" ]]; then
		menu+="$p (active)\n"
  else
    menu+="$p\n"
  fi
done

chosen=$(printf "%b" "$menu" | rofi -dmenu -i -theme "$XDG_CONFIG_HOME/rofi/config/launcher.rasi")

chosen=${chosen% (active)}

[[ -z "$chosen" ]] && exit 1

ln -sf "$config_base/${chosen}.conf" "$monitor_conf_file"
