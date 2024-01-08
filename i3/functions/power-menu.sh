#!/bin/bash

res=$(echo "lock|suspend|logout|restart|shutdown" | rofi -sep '|' -config $1 -dmenu -p "»" -l 5);
echo $1
case $res in
    lock)
        i3lock -i ~/.dotfiles/i3/lock.png -u
        ;;
    logout) 
        i3-msg exit
        ;;
    suspend) 
        i3lock -i ~/.dotfiles/i3/lock.png && systemctl suspend
        ;;
    shutdown) 
        systemctl poweroff -i
        ;; 
    restart) 
        systemctl reboot
        ;;
esac;
