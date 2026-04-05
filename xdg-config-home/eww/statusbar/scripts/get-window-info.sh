#!/usr/bin/env bash

getinfo(){
	hyprctl activewindow -j | jq -c '{class, title, fullscreen, floating, xwayland}'
}

getinfo

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line ; do
	if [[ $line =~ "activewindow>>" ]] || [[ $line =~ "changefloatingmode>>" ]] || [[ $line =~ "fullscreen>>" ]] ; then
	 	getinfo
	fi
done
