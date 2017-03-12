#!/bin/sh

CARD="${1:-0}"
MIXER="${2:-default}" # use pulse for pulseaudio, default is alsa
SCONTROL="${3:-Master}"

case $BLOCK_BUTTON in
  3) pactl set-sink-mute @DEFAULT_SINK@ toggle ;; # right click, mute/unmute
  4) pactl set-sink-volume @DEFAULT_SINK@ -- +5% && pactl set-sink-mute @DEFAULT_SINK@ 0 ;;    # scroll down, decrease
  5) pactl set-sink-volume @DEFAULT_SINK@ -- -5% && pactl set-sink-mute @DEFAULT_SINK@ 0 ;;    # scroll up, increase
esac

volume () {
  amixer -c $CARD -M -D $MIXER get $SCONTROL
}

format () {
  perl -ne 'if (/\[(\d+%)\].*\[(on|off)\]/) {CORE::say $2 eq "off" ? "$1\n\n#cc241d" : "$1"; exit}'
}

volume|format