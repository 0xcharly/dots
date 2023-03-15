#! /usr/bin/env bash

scrcpy -s 99091FFBA005TS -b 64M -t -w & disown
sleep 1 && ~/.local/bin/set-scrcpy-position.sh
