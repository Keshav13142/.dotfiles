#!/usr/bin/env bash

is_muted=$(pamixer --default-source --get-mute)
if [ "$is_muted" = "true" ]; then
	echo ""
else
	echo ""
fi
