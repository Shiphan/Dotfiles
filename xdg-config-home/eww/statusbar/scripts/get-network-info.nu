#!/usr/bin/env nu

let device = "wlp1s0"

mut info = {
	enabled: ((nmcli radio wifi | str trim) == "enabled"),
	...(match (nmcli networking connectivity | str trim) {
		"none" => {
			connected: false,
			full: false,
		}
		"full" => {
			connected: true,
			full: true,
		}
		_ => {
			connected: true,
			full: false,
		}
	}),
	name: (nmcli connection show --active | detect columns | get 0.NAME),
}

$info | to json --raw | print

for line in (nmcli monitor | lines) {
	if ($line starts-with $"($device): ") {
		$info.enabled = $line != $"($device): unavailable"
	} else if ($line starts-with "Connectivity is now " ) {
		$info.full = $line == "Connectivity is now 'full'"
	} else if $line == "Networkmanager is now in the 'connected' state" {
		$info.connected = true;
	} else if $line == "Networkmanager is now in the 'disconnected' state" {
		$info.connected = false;
	} else if ($line ends-with " is now the primary connection" ) {
		$info.name = $line | str replace -r " is now the primary connection$" "" | str trim -c "'"
	} else {
		continue
	}

	$info | to json --raw | print
}
