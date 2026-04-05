#!/usr/bin/env bash

getinfo(){
	workspaces=$(hyprctl workspaces -j | jq -c 'sort_by(.id) | [ .[] | {"id","name","windows"} ]')
	jq -nc \
		--argjson spaceId "$spaceId" \
		--argjson specialId "$specialId" \
		--argjson onSpecial "$isSpecial" \
		--argjson spaceInfo "$(echo "$workspaces" | jq -c '[ .[] | select(.id>0) ]')" \
		--argjson specialInfo "$(echo "$workspaces" | jq -c '[ .[] | select(.id<0) ]')" \
		'$ARGS.named | {active: {spaceId, specialId, onSpecial}, spaceInfo, specialInfo}'
}

initactive=$(hyprctl monitors -j)
spaceId=$(echo "$initactive" | jq '.[0].activeWorkspace.id')
specialId=$(echo "$initactive" | jq '.[0].specialWorkspace.id')
if [[ $specialId == 0 ]] ; then
	isSpecial=false
else
	isSpecial=true
fi
getinfo

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line ; do
	if [[ $line == "workspacev2>>"* ]] ; then
		spaceId=$(echo "$line" | sed "s/^workspacev2>>\(-\?[0-9]\+\),.*/\1/")
		getinfo
	elif [[ $line == "createworkspacev2>>"* ]] || [[ $line =~ "destroyworkspacev2>>"* ]] ; then
		getinfo
	elif [[ $line == "activespecialv2>>,,"* ]] ; then
		isSpecial=false
		getinfo
	elif [[ $line == "activespecialv2>>"* ]] ; then
		specialId=$(echo "$line" | sed "s/^activespecialv2>>\(-\?[0-9]\+\),.*/\1/")
		isSpecial=true
		getinfo
	fi
done
