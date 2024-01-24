#!/bin/bash

path=~/.config/i3

gifs=$(ls $path/gifs)
echo $gifs
res=$(echo $gifs | rofi -sep ' ' -config $1 -dmenu);

workspace=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num' | cut -d"\"" -f2)

# "i3-msg" workspace 0 

kitty -o allow_remote_control=yes cbonsai -l -i -m "waiting for loading background :D" &

# "$path/functions/i3-new-workspace.sh" -c


$path/functions/generate_pngs.sh $path/gifs/$res $path/animated_background/

notify-send "Wallpaper changed to $res successfully" 
kill $!

sleep 2

i3-msg workspace number "$workspace"
