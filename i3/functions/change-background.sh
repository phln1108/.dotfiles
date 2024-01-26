#!/bin/bash

source ~/.config/i3/functions/consts.sh

icon=$path/wallpaper_icon.png
name="Animated wallpaper"

gifs=$(ls $path/gifs)
echo $gifs
res=$(echo $gifs | rofi -sep ' ' -config $1 -dmenu);

echo $res

if [[ $res = "" ]]; then
    notify-send "$name" "Operation Canceled" --icon="$icon" 
else
    notify-send "$name" "Wallpaper is updating, please don't go to a empty workspace" --icon="$icon"  

    WINDOWS=$(xdotool search --all --onlyvisible --desktop $(xprop -notype -root _NET_CURRENT_DESKTOP | cut -c 24-) "" 2>/dev/null)
    num=$(echo -n "$WINDOWS" | wc -m)

    if [[ $num = 0 ]]; then
        kitty -o allow_remote_control=yes cbonsai -l -i -m "waiting for loading background :D" &
    fi
        
    $path/functions/generate_pngs.sh $path/gifs/$res $path/animated_background/

    notify-send "$name" "Wallpaper changed to $res successfully" --icon="$icon" 
    
    kill $!
fi