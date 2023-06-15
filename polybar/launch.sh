#!/usr/bin/env bash

pkill polybar

echo "---" | tee -a /tmp/polybar.log
polybar --config=~/.config/polybar/config.ini personal 2>&1 | tee -a /tmp/polybar.log &
disown
