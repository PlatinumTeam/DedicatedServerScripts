#!/bin/bash

DIR=`echo $0 | sed -E 's/\/[^\/]+$/\//'`
if [ "X$0" != "X$DIR" ]; then
        cd "$DIR"
fi

cd ..

if [ -f run.pid ]
then
	# See if MBP is running
	proc=$(cat run.pid)
	
	# If the proc is running in the first place, don't do anything
	kill -0 "$proc"
	running=$?
	if [ $running ]
	then
	        exit 0
	fi
fi

# Backup the old server's log
backupfile=$(stat -f "%Sm" -t "consoles/console-%F %T %z" console.log)
mv console.log "$backupfile"
gzip "$backupfile"

# Pretty simple server starting script
screen -dmS mbp ./run.sh
