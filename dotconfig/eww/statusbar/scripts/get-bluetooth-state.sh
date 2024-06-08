enabled=false
searching=false
connected=false

printInfo() {
	echo "{\"enabled\":$enabled,\"searching\":$searching,\"connected\":$connected}"
	echo "{\"enabled\":$enabled,\"searching\":}"
}

# printInfo
bluetoothctl | while read -r line ; do
	update=true

	if [[ $line =~ Controller\ .{17}\ Powered:\ no ]] ; then
		enabled=false
		searching=false
		connected=false
	elif [[ $line =~ Controller\ .{17}\ Powered:\ yes ]] ; then
		enabled=true
	elif [[ $line =~ Controller\ .{17}\ Discovering:\ no ]] ; then
		searching=false
	elif [[ $line =~ Controller\ .{17}\ Discovering:\ yes ]] ; then
		searching=true
	elif [[ $line =~ Device\ .{17}\ Connected:\ noetooth ]] ; then
		connected=false
	elif [[ $line =~ Device\ .{17}\ Connected:\  ]] ; then
		connected=true
	else
		update=false
	fi

	#if $update ; then
		# printInfo
	#fi
	echo $update
done
