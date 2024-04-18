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
killall loop_pngs.sh

if [[ $choice = "Static" ]]; then
    feh --no-fehbg --bg-fill $path/gifs/$res
    notify-send "$name" "Wallpaper changed to $res successfully" --icon="$icon" 
    exit
fi

notify-send "$name" "Wallpaper is updating!" --icon="$icon"  

$path/functions/generate_pngs.sh $path/gifs/$res $path/animated_background/

notify-send "$name" "Wallpaper changed to $res successfully" --icon="$icon" 

$($path/functions/loop_pngs.sh $path/animated_background) &
