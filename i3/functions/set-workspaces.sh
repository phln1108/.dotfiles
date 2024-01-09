#!/bin/bash

findMonitors=~/.dotfiles/i3/functions/find-monitor-name.sh
monitors=$($findMonitors)
ws=1
for((i=1; i<=monitors; i++)); do
    monitor=$($findMonitors $i)
    i3-msg workspace "$ws",move workspace to output "$monitor"
    ws=$((ws+10))
    done
    i3-msg workspace 1
done
