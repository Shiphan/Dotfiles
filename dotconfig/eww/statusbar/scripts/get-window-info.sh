getinfo(){
	hyprctl activewindow -j | jq '{"class", "title", "fullscreen", "floating", "xwayland"}' -c
}

getinfo
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line ; do
	if [[ $line =~ "activewindow>>" ]] || [[ $line =~ "changefloatingmode>>" ]] || [[ $line =~ "fullscreen>>" ]] ; then
	 	getinfo
	fi
done

: '
class=""
title=""
fullscreen=0
floating=false
xwayland=false

getinfo(){
	case $1 in
		monitoradded*) do_something ;;
		focusedmon*) do_something_else ;;
	esac

	echo "{\"class\": \"$class\", \"title\": \"$title\", \"fullscreen\": $fullscreen, \"floating\": $floating, \"xwayland\": $floating}"
}

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line ; do
	getinfo "$line"
done
'
