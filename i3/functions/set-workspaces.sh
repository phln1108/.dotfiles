#!/bin/bash

findMonitors=~/.dotfiles/i3/functions/find-monitor-name.sh
monitors=$($findMonitors)
ws=1
for((i=1; i<=monitors; i++)); do
    monitor=$($findMonitors $i)
    for y in {1..10}; do
        echo $ws
        ws=$((ws+1))
    done
done
