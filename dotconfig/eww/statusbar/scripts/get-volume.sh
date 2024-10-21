#!/usr/bin/env bash

getinfo(){
	info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
	value=$(echo "$info" | awk '{print $2 * 100}')
	if [[ $info =~ \[MUTED\] ]] ; then
		muted=true
	else
		muted=false
	fi

	if [[ $value -gt 50 ]] ; then
		level=2
	elif [[ $value -gt 0 ]] ; then
		level=1
	else
		level=0
	fi

	echo "{\"value\":$value,\"level\":$level,\"muted\":$muted}"
}

getinfo
pactl subscribe | while read -r line ; do
	if [[ $line =~ "Event 'change' on sink " ]] ; then
		getinfo
	fi
done
