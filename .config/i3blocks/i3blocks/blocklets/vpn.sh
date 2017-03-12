#!/usr/bin/env bash

if [[ -f "/var/run/ppp0.pid" ]]; then
    str="\uf046\n\n#009900"
else
    str="\uf096"
fi

echo -e "$str"

