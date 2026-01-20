#!/bin/bash

# 1. Try to see if the window is open
IF_OPEN=$(eww active-windows | grep "clock-calendar")

if [ -n "$IF_OPEN" ]; then
    # If it's open, try to close it gracefully
    eww close clock-calendar
    # Give it a millisecond to breathe, then kill any lingering eww processes 
    # just to be safe so the daemon stays clean
    sleep 0.1
else
    # If it's NOT open (or eww is bugged), kill everything and start fresh
    pkill eww
    eww daemon
    sleep 0.2 # Wait for daemon to wake up
    eww open clock-calendar
fi

