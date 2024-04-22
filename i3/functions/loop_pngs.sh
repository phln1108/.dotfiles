#!/bin/bash

interval="0.01"
path=""
static=0
interrupt=0

function show_help {
    echo "USAGE:"
    echo "    loop_png [OPTION]"
}

while getopts "p:t:si" option; do
    case $option in
        p) path=$OPTARG;;
        
        t) interval=$OPTARG;;

        s) static=1;;

        i) interrupt=1;;

        \?) # Invalid option
            echo "Error: Invalid option";
            exit;;
   esac
done

echo $static
echo $interval
echo $path
echo $interrupt

if [ $static -eq 1 ]; then
    feh --no-fehbg --bg-fill $path;
else
    if [ $interrupt -eq 1 ]; then
        while true; do
            WINDOWS=$(xdotool search --all --onlyvisible --desktop $(xprop -notype -root _NET_CURRENT_DESKTOP | cut -c 24-) "" 2>/dev/null)
            num=$(echo -n "$WINDOWS" | wc -m)
            if [[ $num = 0 ]]; then
                images=$(ls $path)
                for image in $images; do
                    # echo $image
                    feh --no-fehbg --bg-fill $path/$image && sleep $interval;
                done
            else
                sleep 0.5;
            fi
        done
    else
        while true; do
            images=$(ls $path)
            for image in $images; do
                # echo $path/$image
                feh --no-fehbg --bg-fill $path/$image && sleep $interval;
            done
        done
    fi
fi
