#!/bin/bash

send() {
        name=$1
        command=$2
        screen -S $name -X stuff $2`echo -ne '\015'`
}

findproc() {
	name=$1
	ps=$(ps aux | egrep $1 | egrep -v 'wineconsole' | egrep -v 'grep')
	pid=$(echo $ps | sed -r 's/\S+ (\S+) .*/\1/g')
	echo $pid
}

# See if MBP is running
proc=$(findproc 'marbleblast.exe')

# If the proc isn't running in the first place, don't do anything
if [ -z $proc ]
then
	exit 0
fi

# Try quitting it via screen
send 'mbp' 'quit'
sleep 2

# Check to see if the proc is still running
kill -0 $proc 2&> /dev/null
test=$?

# If it is running (returned 0/success)
if [ $test -eq 0 ]
then
	kill -9 $proc
fi
