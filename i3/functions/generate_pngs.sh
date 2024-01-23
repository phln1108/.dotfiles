#!/bin/bash

# set -x

if [ -z $1 ]
then
    exit -1
else
    base="$(basename -- $1)"
    name="${base%.*}"
    count=1
    if [[ ! $3 = "" ]]; then
        count=$3
    fi
fi

if [ -z $2 ]
then
    dir=$name
else
    dir=$2
fi
rm -r $dir
mkdir $dir
for i in $(seq 1 $((count))) ; do
    convert $1 -coalesce $dir"/"$name$i"%03d.png"
done
