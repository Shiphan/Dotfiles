#!/usr/bin/env bash

active=$(powerprofilesctl get)
if [[ $1 == "prev" ]] ; then
	prev=true
else
	prev=false
fi

if [[ $active == "performance" ]] ; then
	if $prev ; then
		powerprofilesctl set power-saver
	else
		powerprofilesctl set balanced
	fi
elif [[ $active == "balanced" ]] ; then
	if $prev ; then
		powerprofilesctl set performance
	else
		powerprofilesctl set power-saver
	fi
elif [[ $active == "power-saver" ]] ; then
	if $prev ; then
		powerprofilesctl set balanced
	else
		powerprofilesctl set performance
	fi
fi
