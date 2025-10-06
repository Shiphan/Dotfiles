#!/usr/bin/env bash

value=$(cat /sys/class/power_supply/BAT1/capacity)
status=$(cat /sys/class/power_supply/BAT1/status)

if [ "$status" = "Charging" ] ; then
	if [[ $value -gt 95 ]] ; then
		echo "";
	elif [[ $value -gt 85 ]] ; then
		echo "";
	elif [[ $value -gt 70 ]] ; then
		echo "";
	elif [[ $value -gt 55 ]] ; then
		echo "";
	elif [[ $value -gt 40 ]] ; then
		echo "";
	elif [[ $value -gt 25 ]] ; then
		echo "";
	elif [[ $value -gt 10 ]] ; then
		echo "";
	else
		echo "";
	fi
else
	if [[ $value -gt 95 ]] ; then
		echo "";
	elif [[ $value -gt 85 ]] ; then
		echo "";
	elif [[ $value -gt 70 ]] ; then
		echo "";
	elif [[ $value -gt 55 ]] ; then
		echo "";
	elif [[ $value -gt 40 ]] ; then
		echo "";
	elif [[ $value -gt 25 ]] ; then
		echo "";
	elif [[ $value -gt 10 ]] ; then
		echo "";
	else
		echo "";
	fi
fi

