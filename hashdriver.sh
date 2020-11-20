#!/bin/bash

RUNONCE=1
SECONDS=0
MINPOG=0
LAUNCHPATH="$HOME/project-drivehash"

mkdir /tmp/verifyPogGers 2>/dev/null
touch /tmp/verifyPogGers/e.pid 2>/dev/null
touch /tmp/verifyPogGers/f.pid 2>/dev/null
touch /tmp/verifyPogGers/o.pid 2>/dev/null
touch /tmp/verifyPogGers/result 2>/dev/null
touch /tmp/verifyPogGers/rundriver 2>/dev/null
touch /tmp/verifyPogGers/finish 2>/dev/null

echo "1" > /tmp/verifyPogGers/rundriver
echo "No one yet" > /tmp/verifyPogGers/finish

RUNNINGQ=$(cat "/tmp/verifyPogGers/rundriver")

while [ $RUNNINGQ = 1 ]; do

	FINISHER=$(cat "/tmp/verifyPogGers/finish")

	if [ "$SECONDS" = 60 ]; then

		SECONDS=0
		let "MINPOG = $MINPOG + 1"

	fi

	if [ $RUNONCE = 1 ]; then

		$LAUNCHPATH/verifyFive.sh "$1" &
		echo "verifyFive.sh initialized."
		$LAUNCHPATH/verifyEven.sh "$1" &
		echo "verifyEven.sh initialized."
		$LAUNCHPATH/verifyOdd.sh "$1" &
		echo "verifyOdd.sh initialized."

		epid=$(cat "/tmp/verifyPogGers/e.pid")
		fpid=$(cat "/tmp/verifyPogGers/f.pid")
		opid=$(cat "/tmp/verifyPogGers/o.pid")

		RUNONCE=0

	fi

	echo -n -e "Time elapsed : $MINPOG:$SECONDS / Finisher : $FINISHER\r"

	if [ "$FINISHER" = "No one yet" ]; then

		echo -n -e "Time elapsed : $MINPOG:$SECONDS / Finisher : $FINISHER\r"

	else

		results=$(cat "/tmp/verifyPogGers/result")
	
		echo -n -e "Time elapsed : $MINPOG:$SECONDS / Finisher : $FINISHER\r\n"
		echo "Hash and verified input : $results"

		kill "$epid" 2>/dev/null
		kill "$fpid" 2>/dev/null
		kill "$opid" 2>/dev/null

		RUNNINGQ=0

	fi
done
