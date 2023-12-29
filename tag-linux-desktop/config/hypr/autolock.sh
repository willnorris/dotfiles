#!/bin/bash

source "${HOME}/.config/shell/_base.sh"

if has swayidle; then
	swayidle -w timeout 300 'swaylock -f' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
else
	echo "swayidle not installed"
fi
