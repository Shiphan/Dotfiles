#!/usr/bin/env nu

powerprofilesctl get | print

dbus-monitor --system "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',sender='org.freedesktop.UPower.PowerProfiles'" err> /dev/null
	| lines
	| window 2
	| where (($it.0 | str trim) == "string \"ActiveProfile\"")
	| each {
		get 1
		| str trim
		| split row -n 3 -r '\s+'
		| get 2
		| str trim --char "\""
		| print
	}
