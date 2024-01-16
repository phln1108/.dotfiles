#!/bin/bash

i3status -c ~/.config/i3/i3status.conf | while :
do
    read line
    task=$(pls count-undone)
    msg="❌"

    # Start building our JSON string
    task_json='"name":"task","instance":"pls","full_text":'
    
    if [[ $task = 0 ]] ; then
        msg="✅"
        task=""
    fi

    # Encode the $playing string to JSON and append it
    task_json+=$(echo -n "$task$msg" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')

    # Close our newly created JSON object and start a new one 
    task_json+='},{'

    # Inject our JSON into $line after the first [{
    line=${line/[{/[{$task_json}

    echo $line || exit 1

done