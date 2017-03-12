#!/bin/sh

case $BLOCK_BUTTON in
  1) gsimplecal ;;
esac

datetime () {
  echo "$(date +'%a %d %b') <b>$(date +'%T')</b> "
}

datetime