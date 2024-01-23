#!/bin/bash

kitty &
ps wx | awk '/awk/{next} /Brave/{print $$}' | head -n1