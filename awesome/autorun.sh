#!/usr/bin/sh

run() {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

HOME=$HOME

#settings for computer from vortex
if [ HOME=="home/pedroh" ]; then
    run "xrandr" --output DP-1 --primary --left-of VGA-1 
    run "picom" --experimental-backends --config ~/.config/picom/picom.conf
elif [HOME == "home/ph"  ]; then
    run "picom" --config ~/.config/picom/picom.conf
fi



