#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit
killall -q polybar

# Logs
echo "---" | tee -a /tmp/polybar.log
polybar personal 2>&1 | tee -a /tmp/polybar.log &
disown
