#!/bin/bash

source ~/.config/i3/functions/consts.sh

icon=$path/wallpaper_icon.png
name="Animated wallpaper"

gifs=$(ls $path/gifs)
echo $gifs
choice=$(echo "Static Gif" | rofi -sep ' ' -config $1 -dmenu)
if [[ $choice = "" ]]; then
    notify-send "$name" "Operation Canceled" --icon="$icon" 
    exit
fi

res=$(echo $gifs | rofi -sep ' ' -config $1 -dmenu);

echo $res
if [[ $res = "" ]]; then
    notify-send "$name" "Operation Canceled" --icon="$icon" 
    exit
fi

time=$(echo "0.001s 0.01s 0.05s 0.1s" | rofi -sep ' ' -config $1 -dmenu);
case $option in
    "0.01s") time=0.01;;
    "0.1s") time=0.1;;
    "0.05s") time=0.05;;
    "0.001s") time=0.001;;
    \?) # Invalid option
        notify-send "$name" "Operation Canceled" --icon="$icon"
        exit;;
esac

killall loop_pngs.sh

if [[ $choice = "Static" ]]; then
    feh --no-fehbg --bg-fill $path/gifs/$res
    notify-send "$name" "Wallpaper changed to $res successfully" --icon="$icon" 
    exit
fi

notify-send "$name" "Wallpaper is updating!" --icon="$icon"  

$path/functions/generate_pngs.sh $path/gifs/$res $path/animated_background/

notify-send "$name" "Wallpaper changed to $res successfully" --icon="$icon" 

$($path/functions/loop_pngs.sh -p $path/animated_background -t $time) &
