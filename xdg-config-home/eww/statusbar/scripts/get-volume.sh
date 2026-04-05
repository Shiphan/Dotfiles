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

	jq -nc \
		--argjson value "$value" \
		--argjson level $level \
		--argjson muted $muted \
		'$ARGS.named'
}

getinfo
pactl subscribe | while read -r line ; do
	if [[ $line =~ "Event 'change' on sink " ]] || [[ $line =~ "Event 'new' on sink" ]] || [[ $line =~ "Event 'remove' on sink" ]] ; then
		getinfo
	fi
done
