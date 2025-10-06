#!/bin/bash
echo " "   # power icon (FontAwesome)
if [[ $BLOCK_BUTTON == 1 ]]; then
    systemctl poweroff
fi

