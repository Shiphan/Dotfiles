#!/usr/bin/env nu

mut info = do {
	let info = (bluetoothctl show | lines | str trim)
	let enabled = $info
		| where $it starts-with "Powered: "
		| first
		| $in == "Powered: yes"
	let searching = $info
		| where $it starts-with "Discovering: "
		| first
		| $in == "Discovering: yes"
	let connected = bluetoothctl devices Connected
		| lines
		| str replace -r "^Device (.{17}).*$" "$1"
	{
		enabled: $enabled,
		searching: $searching,
		connected: $connected,
	}
}

def print_info [info] {
	{
		enabled: $info.enabled,
		searching: $info.searching,
		connected: ($info.connected | is-not-empty),
	} | to json --raw | print
}

print_info $info

for line in (^sleep infinity | bluetoothctl | lines | where $it =~ "Controller" or $it =~ "Device") {
	if $line =~ "Controller .{17} Powered: " {
		if $line ends-with "yes" {
			$info.enabled = true
		} else {
			$info.enabled = false
			$info.searching = false
			$info.connected = []
		}
	} else if $line =~ "Controller .{17} Discovering: " {
		$info.searching = $line ends-with "yes"
	} else if $line =~ "Device .{17} Connected: " {
		let address = $line | str replace -r "^.*Device (.{17}).*$" "$1"
		if $line ends-with "yes" {
			$info.connected = $info.connected | append $address
		} else {
			$info.connected = $info.connected | where $it != $address
		}
	} else {
		continue
	}

	print_info $info
}
