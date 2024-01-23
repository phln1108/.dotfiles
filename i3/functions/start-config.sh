#!/bin/bash

i3_path=~/.config/i3
functions_path=~/.config/i3/functions

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

killall loop_pngs.sh
$($functions_path/loop_pngs.sh $i3_path/animated_background) &
# run "$functions_path/loop_pngs.sh" $i3_path/animated_background
run "picom" --experimental-backends --config ~/.config/picom/picom.conf