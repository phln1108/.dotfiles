#!/bin/bash

carry="false"
inc=0

function show_help {
    echo "USAGE:"
    echo "    i3-new-workspace [-1|+1] [OPTION]"
    echo
    echo "OPTION:"
    echo "    -c, --carry  Carry (move and focus) current container to the new workspace"
}

while [ $# -gt 0 ] ; do
    case $1 in
        "--carry"|"-c") carry="true" ;;
        "-1"|"+1"|"1") 
            if [[ $inc = 0 ]]; then
                inc=$(($1))
            else
                show_help 
                exit 1
            fi
            ;;
        "--help"|"-h"|"-?") show_help ; exit 0 ;;
        *) 
            show_help 
            exit 1 
            ;;
    esac
    shift
done

actual_num=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num' | cut -d"\"" -f2)
monitor=$(($actual_num / 10))
ws_json=$(i3-msg -t get_workspaces)
for i in {1..10} ; do
    go=$((i*inc+actual_num))
    if [ "$go" -gt "$((($monitor+1)*10))" ]; then
        go=$((go-10))
    elif [ "$go" -lt "$(($monitor*10+1))" ]; then
        go=$((go+10))
    fi
    echo $go
    [[ $ws_json =~ \"num\":\ ?$go ]] || continue
    

    case $carry in
        "false") i3-msg workspace number "$go" ;;
        "true")  i3-msg move container to workspace number "$go", workspace number "$go" ;;
    esac
    break
done
