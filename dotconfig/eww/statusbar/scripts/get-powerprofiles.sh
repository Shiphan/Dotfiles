profile=$(powerprofilesctl get)

if [ $profile = "performance" ] ; then
	echo 3
elif [ $profile = "balanced" ] ; then
	echo 2
elif [ $profile = "power-saver" ] ; then
	echo 1
else
	echo 0
fi
