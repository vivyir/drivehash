#!/bin/bash

doomnum=1
iterator=0
echo $$ > /tmp/verifyPogGers/o.pid

while [ 1 = 1 ]; do

	let "doomnum = $doomnum + 2"
	let "iterator = $iterator + 1"

	inpnum=""$1"-"$doomnum""
	hashinp=$(printf "$inpnum" | sha256sum)
	verifier=${hashinp:0:4}

	if [ $verifier = "0000" ]; then

		echo "$hashinp $inpnum" > /tmp/verifyPogGers/result

		echo "verifyOdd.sh Finished!" > /tmp/verifyPogGers/finish

		break
	fi

done
