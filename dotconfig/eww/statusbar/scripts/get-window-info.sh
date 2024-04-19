getinfo(){
	hyprctl activewindow -j | jq '{"class", "title", "fullscreen", "floating", "xwayland"}' -c
}

getinfo
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line ; do
	if [[ $line =~ "activewindow>>" ]] || [[ $line =~ "changefloatingmode>>" ]] || [[ $line =~ "fullscreen>>" ]] ; then
	 	getinfo
	fi
done
