#!/usr/bin/env bash

dir="$HOME/.config/rofi/styles"
theme='wifi-blue'

# 1. Force a rescan of available networks
notify-send "Scanning for Wi-Fi networks..."
nmcli device wifi rescan

# Give it a brief moment to populate the new list
sleep 2

# 2. Get the refreshed list
wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
	toggle="󰖪  Disable Wi-Fi"
else
	toggle="󰖩  Enable Wi-Fi"
fi

# 3. Use rofi to select wifi network
chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | rofi -dmenu -i -selected-row 1 -p "Wi-Fi SSID: " -theme "${dir}/${theme}.rasi")

# Exit if Escaped
if [ -z "$chosen_network" ]; then
	exit
fi

# Trim the icon and spaces
chosen_id=$(echo "${chosen_network:3}" | xargs)

if [ "$chosen_network" = "󰖩  Enable Wi-Fi" ]; then
	nmcli radio wifi on
elif [ "$chosen_network" = "󰖪  Disable Wi-Fi" ]; then
	nmcli radio wifi off
else
	success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."
	
	if nmcli connection show "$chosen_id" > /dev/null 2>&1; then
		if ! nmcli connection up id "$chosen_id" > /dev/null 2>&1; then
			nmcli connection delete id "$chosen_id"
			
			if [[ "$chosen_network" =~ "" ]]; then
				wifi_password=$(rofi -dmenu -p "Password: " -password -theme "${dir}/${theme}.rasi")
				[ -z "$wifi_password" ] && exit
				nmcli device wifi connect "$chosen_id" password "$wifi_password" && notify-send "Connection Established" "$success_message"
			else
				nmcli device wifi connect "$chosen_id" && notify-send "Connection Established" "$success_message"
			fi
		else
			notify-send "Connection Established" "$success_message"
		fi
	else
		if [[ "$chosen_network" =~ "" ]]; then
			wifi_password=$(rofi -dmenu -p "Password: " -password -theme "${dir}/${theme}.rasi")
			[ -z "$wifi_password" ] && exit
			nmcli device wifi connect "$chosen_id" password "$wifi_password" && notify-send "Connection Established" "$success_message"
		else
			nmcli device wifi connect "$chosen_id" && notify-send "Connection Established" "$success_message"
		fi
	fi
fi
