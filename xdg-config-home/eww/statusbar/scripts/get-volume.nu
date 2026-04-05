#!/usr/bin/env nu

def print_info [] {
	let info = wpctl get-volume @DEFAULT_AUDIO_SINK@
		| split row -n 3 -r '\s+'
	let volume = ($info | get --optional 1 | default 0 | into float) * 100 | into int
	let muted = ($info | get --optional 2) == "[MUTED]"
	let level = if $volume >= 50 {
		2
	} else if $volume > 0 {
		1
	} else {
		0
	}

	{
		value: $volume,
		level: $level,
		muted: $muted,
	} | to json --raw | print
}

while (wpctl get-volume @DEFAULT_AUDIO_SINK@ | is-empty) {
	sleep 0.5sec
}

print_info

pactl subscribe
	| lines
	| where $it =~ "^Event '(change|new|remove)' on sink "
	| each { print_info }
