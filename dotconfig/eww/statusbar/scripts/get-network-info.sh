device="wlan0"

printInfo(){
	echo "{\"enabled\":$enabled,\"connected\":$connected,\"full\":$full,\"name\":$name}"
}

# init
if [[ $(nmcli radio wifi) =~ "enabled" ]] ; then
	enabled=true
else
	enabled=false
fi
if [[ $(nmcli networking connectivity) =~ "none" ]] ; then
	connected=false
	full=false
elif [[ $(nmcli networking connectivity) =~ "full" ]] ; then
	connected=true
	full=true
else
	connected=true
	full=false
fi
name="\"$(nmcli --get-values GENERAL.CONNECTION device show wlp1s0)\""
printInfo

nmcli monitor | while read -r line ; do
	update=true
	if [[ $line =~ "${device}: unavailable" ]] ; then
		enabled=false
	elif [[ $line =~ "${device}: " ]] && ! $enabled; then
		enabled=true
	elif [[ $line =~ "Connectivity is now 'full'" ]] ; then
		full=true
	elif [[ $line =~ "Connectivity is now " ]] ; then
		full=false
	elif [[ $line =~ "Networkmanager is now in the 'connected' state" ]] ; then
		connected=true
	elif [[ $line =~ "Networkmanager is now in the 'disconnected' state" ]] ; then
		connected=false
	elif [[ $line =~ " is now the primary connection" ]] ; then
		name=$(echo $line | sed -e "s/ is now the primary connection//" -e "s/^'/\"/" -e "s/'$/\"/")
	else
		update=false
	fi

	if $update ; then
		printInfo
	fi
done
