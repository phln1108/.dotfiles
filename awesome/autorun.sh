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
    echo "aaa"
    run "xrandr" --output DP-1 --primary --left-of VGA-1 
    run "picom" --experimental-backends --config ~/.config/picom/picom.conf
    run "/usr/lib/x86_64-linux-gnu/polkit-mate/polkit-mate-authentication-agent-1"
elif [ "$usr" = "/home/ph" ]; then
    run "picom" --config ~/.config/picom/picom.conf
fi



