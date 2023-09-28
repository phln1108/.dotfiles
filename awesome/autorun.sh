#!/usr/bin/sh

run() {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

usr=$HOME
echo $usr
#settings for computer from vortex
if [ "$usr" = "/home/pedroh" ]; then
    #run "xrandr" --output DP-1 --primary --pos 0x0 --output VGA-1 --pos 1920x256
    run "xrandr" --output DP-1 --pos 0x0 --output VGA-1 --pos 1920x256
    run "picom" --experimental-backends --config ~/.config/picom/picom.conf
    run "/usr/lib/x86_64-linux-gnu/polkit-mate/polkit-mate-authentication-agent-1"
    run "setxkbmap" -layout us -variant intl
    
elif [ "$usr" = "/home/ph" ]; then
    run "picom" --config ~/.config/picom/picom.conf
fi



