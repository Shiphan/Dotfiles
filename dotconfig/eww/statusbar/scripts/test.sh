i=0
while [[ $i -lt 10 ]]; do
	echo $i
	i=$(($i + 1))
	sleep 1
done | while read -r line ; do
	stty -F pipe icrnl icanon echo

	echo "${line}0"
	sleep 0.5
	echo $line
done
