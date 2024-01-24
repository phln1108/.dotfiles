#!/bin/bash

source ~/.config/i3/functions/consts.sh

res=$(echo "lock|suspend|logout|restart|shutdown" | rofi -sep '|' -config $1 -dmenu -p "»" -l 5);
echo $1
case $res in
    lock)
        i3lock -i $path/lock.png -u -c 000000
        ;;
    logout) 
        i3-msg exit
        ;;
    suspend) 
        i3lock -i $path/lock.png -u -c 000000 && systemctl suspend
        ;;
    shutdown) 
        systemctl poweroff -i
        ;; 
    restart) 
        systemctl reboot
        ;;
esac;
