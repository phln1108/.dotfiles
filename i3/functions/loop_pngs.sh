#!/bin/bash

if [ -z "$1" ]
then
    pattern="*"
else
    pattern=$1/*
fi

if [ -z "$2" ]
then
    interval="0.1"
else
    interval=$2
fi

while true;
do
    # monitor=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num' | cut -d"\"" -f2)
    WINDOWS=$(xdotool search --all --onlyvisible --desktop $(xprop -notype -root _NET_CURRENT_DESKTOP | cut -c 24-) "" 2>/dev/null)
    num=$(echo -n "$WINDOWS" | wc -m)
    # echo echo "Monitor $monitor with $num windows opened"
    # echo $WINDOWS
    if [[ $num = 0 ]]; then
        for image in $pattern;
        do
            # echo $image
            feh --bg-fill $image && sleep $interval;
        done
    else
        sleep 0.5;
    fi
done
