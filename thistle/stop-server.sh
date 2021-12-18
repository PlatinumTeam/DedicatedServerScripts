#!/bin/bash -x

DIR=`echo $0 | sed -E 's/\/[^\/]+$/\//'`
if [ "X$0" != "X$DIR" ]; then
        cd "$DIR"
fi

cd ..

send() {
        command="$2"
        echo "$2" > platinum/input.txt
        sleep 1 # So it goes through
        echo "" > platinum/input.txt
}

if [ ! -f run.pid ]
then
	exit 0
fi

# See if MBP is running
proc=$(cat run.pid)

# If the proc is running in the first place, don't do anything
kill -0 "$proc"
running=$?
if [ ! $running ]
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

