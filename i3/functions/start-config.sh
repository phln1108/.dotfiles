#!/bin/bash

i3_path=~/.config/i3
functions_path=~/.config/i3/functions

run() {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

killall polybar

usr=$(hostname)
echo $usr
#settings for computer from vortex
if [ "$usr" = "VRP65048486" ]; then
    xrandr --output DP-2 --pos 0x0 --primary --output VGA-1 --pos 1920x256
    run "picom" --experimental-backends --config ~/.config/picom/picom.conf
    # polybar example --config=~/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar1.log & disown
elif [ "$usr" = "localhost.localdomain"  ]; then
    run "picom" --config ~/.config/picom/picom.conf
    xinput --set-prop 10 'libinput Natural Scrolling Enabled' 1
fi

killall loop_pngs.sh
# $($functions_path/loop_pngs.sh $i3_path/animated_background) &
$($functions_path/change-background.sh ~/.dotfiles/rofi/rofipm.rasi)
# run "$functions_path/loop_pngs.sh" $i3_path/animated_background