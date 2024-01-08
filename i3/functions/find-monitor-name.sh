#!/bin/bash
#returns the monitor connected
monitors=("")
count=0

while read -r output hex conn; do
    [[ -z "$conn" ]] && conn=${output%%-*}
    count=$((count+1))
    monitors[$count]=$output
    # echo "$output"
done < <(xrandr --prop | awk '
    !/^[ \t]/ {
        if (output && hex) print output, hex, conn
        output=$1
        
        hex=""
    }
    /ConnectorType:/ {conn=$2}
    /[:.]/ && h {
        sub(/.*000000fc00/, "", hex)
        hex = substr(hex, 0, 26) "0a"
        sub(/0a.*/, "", hex)
        h=0
    }
    h {sub(/[ \t]+/, ""); hex = hex $0}
    /EDID.*:/ {h=1}
    END {if (output && hex) print output, hex, conn}
    ' | sort
)

case $1 in
    "") echo $count;;
    *) echo ${monitors[$1]};;
esac;
