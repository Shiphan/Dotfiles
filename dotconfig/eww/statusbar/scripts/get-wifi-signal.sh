value=$(nmcli --terse --get-values IN-USE,SIGNAL device wifi list | grep "\*" | sed 's/*://')

if [[ $value -gt 85 ]] ; then
	level=5
elif [[ $value -gt 65 ]] ; then
	level=4
elif [[ $value -gt 50 ]] ; then
	level=3
elif [[ $value -gt 35 ]] ; then
	level=2
elif [[ $value -gt 15 ]] ; then
	level=1
else
	level=0
fi

echo "{\"value\":$value,\"level\":$level}"
