#!/usr/bin/env bash

getinfo(){
	workspaces=$(hyprctl workspaces -j | jq -c 'sort_by(.id) | [ .[] | {"id","name","windows"} ]')
	echo "{\"active\":{\"spaceId\":$spaceId, \"specialId\":$specialId, \"onSpecial\":$isSpecial}, \"spaceInfo\":$(echo $workspaces | jq -c '[ .[] | select(.id>0) ]'), \"specialInfo\":$(echo $workspaces | jq -c '[ .[] | select(.id<0) ]')}"
}

initactive=$(hyprctl monitors -j)
spaceId=$(echo $initactive | jq '.[0].activeWorkspace.id')
specialId=$(echo $initactive | jq '.[0].specialWorkspace.id')
if [[ $specialId == 0 ]] ; then
	isSpecial=false
else
	isSpecial=true
fi
getinfo
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line ; do
	if [[ $line == "workspace>>"* ]] ; then
		spaceId=$(echo $line | sed "s/^workspace>>//")
		getinfo
	elif [[ $line == "createworkspace>>"* ]] || [[ $line =~ "destroyworkspace>>"* ]] ; then
		getinfo
	elif [[ $line == "activespecial>>,"* ]] ; then
		isSpecial=false
		getinfo
	elif [[ $line == "activespecial>>"* ]] ; then
		specialId=$(hyprctl monitors -j | jq '.[0].specialWorkspace.id')
		isSpecial=true
		getinfo
	fi
done
