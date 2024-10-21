#!/usr/bin/env bash

value=$(cat /sys/class/power_supply/BAT1/capacity)

if [[ $value -gt 95 ]] ; then
	echo 7;
elif [[ $value -gt 85 ]] ; then
	echo 6;
elif [[ $value -gt 70 ]] ; then
	echo 5;
elif [[ $value -gt 55 ]] ; then
	echo 4;
elif [[ $value -gt 40 ]] ; then
	echo 3;
elif [[ $value -gt 25 ]] ; then
	echo 2;
elif [[ $value -gt 10 ]] ; then
	echo 1;
else
	echo 0;
fi
