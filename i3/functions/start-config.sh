#!/bin/bash

run() {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

usr=$(hostname)
echo $usr
#settings for computer from vortex
if [ "$usr" = "DTEC65048486" ]; then
    xrandr --output DP-1 --pos 0x0 --output VGA-1 --pos 1920x256
    xrandr --output DP-1 --pos 0x0 --output VGA-1 --pos 1920x256
    xrandr --output DP-1 --pos 0x0 --output VGA-1 --pos 1920x256
    
fi

    run "picom" --config ~/.config/picom/picom.conf