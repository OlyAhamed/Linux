#!/bin/bash
echo " "   # restart icon (FontAwesome)
if [[ $BLOCK_BUTTON == 1 ]]; then
    systemctl reboot
fi

