#!/usr/bin/env bash

LED=$(xset -q|grep LED| awk '{print $10}')

if [[ $LED -gt 99 ]]; then
    layout="ru"
else
    layout="us"
fi

echo $layout

