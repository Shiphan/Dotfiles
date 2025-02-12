#!/usr/bin/env bash

printinfo() {
	jq -nc \
		--argjson enabled "$enabled" \
		--argjson searching "$searching" \
		--argjson connected "$connected" \
		'$ARGS.named'
}

# init bluetooth state
enabled=$(bluetoothctl show | while read -r line ; do
	if [[ $line =~ Powered:\ no ]] ; then
		echo false
		break
	elif [[ $line =~ Powered:\ yes ]] ; then
		echo true
		break
	fi
done)
searching=$(bluetoothctl show | while read -r line ; do
	if [[ $line =~ Discovering:\ no ]] ; then
		echo false
		break
	elif [[ $line =~ Discovering:\ yes ]] ; then
		echo true
		break
	fi
done)
connected=$(if [[ "$(bluetoothctl devices Connected)" = "" ]]; then echo false; else echo true; fi)

printinfo

sleep inf | bluetoothctl | while read -r line ; do
	update=true

	if [[ $line =~ Controller\ .{17}\ Powered:\ no ]] ; then
		enabled=false
		searching=false
		connected=false
	elif [[ $line =~ Controller\ .{17}\ Powered:\ yes ]] ; then
		enabled=true
	elif [[ $line =~ Controller\ .{17}\ Discovering:\ no ]] ; then
		searching=false
	elif [[ $line =~ Controller\ .{17}\ Discovering:\ yes ]] ; then
		searching=true
	elif [[ $line =~ Device\ .{17}\ Connected:\ no ]] ; then
		connected=false
	elif [[ $line =~ Device\ .{17}\ Connected:\  ]] ; then
		connected=true
	else
		update=false
	fi

	if $update ; then
		printinfo
	fi
done
