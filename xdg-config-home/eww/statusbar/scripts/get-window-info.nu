#!/usr/bin/env nu

def print_info [] {
	hyprctl activewindow -j
		| from json
		| select --optional class title fullscreen floating xwayland
		| to json --raw
		| print
}

print_info

socat -U - $"UNIX-CONNECT:($env.XDG_RUNTIME_DIR)/hypr/($env.HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock"
	| lines
	| where $it starts-with "activewindowv2>>" or $it starts-with "changefloatingmode>>" or $it starts-with "fullscreen>>"
	| each { print_info }
