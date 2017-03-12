#!/bin/sh
# check auto-mute state
amixer sget 'Auto-Mute Mode' | grep Item0 | grep -q Disabled
if [ "$?" -eq "0" ]; then
# unmute the headphones and mute the speakers
    amixer -c 0 sset "Auto-Mute Mode" Enabled
    amixer -c 0 sset "Headphone,1" unmute
else
# mute the headphones and umunte the spearkers
    amixer -c 0 sset "Auto-Mute Mode" Disabled
    amixer -c 0 sset "Headphone,1" mute
fi

