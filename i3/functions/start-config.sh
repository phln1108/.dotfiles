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
    xrandr --output DP-2 --pos 0x0 --primary --output VGA-1 --pos 1920x256
    
    
fi

    run "picom" --config ~/.config/picom/picom.conf