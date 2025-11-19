#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers/"
theme='style-5'

## Run
rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
