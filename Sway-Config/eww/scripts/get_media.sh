#!/bin/bash
# Real-time media listener for eww
playerctl --follow metadata --format \
'{"status": "{{status}}", "title": "{{title}}", "artist": "{{artist}}", "art": "{{mpris:artUrl}}", "time": "{{duration(position)}}", "total": "{{duration(mpris:length)}}", "perc": "{{(position/mpris:length)*100}}"}' 2>/dev/null
