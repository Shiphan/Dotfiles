profile=$(powerprofilesctl | grep "*" | awk '{print $2}')

if [ $profile = "performance:" ] ; then
	level=3
elif [ $profile = "balanced:" ] ; then
	level=2
elif [ $profile = "power-saver:" ] ; then
	level=1
else
	level=0
fi

echo $level
