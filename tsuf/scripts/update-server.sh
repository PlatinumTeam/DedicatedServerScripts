#!/bin/bash

DIR=`echo $0 | sed -E 's/\/[^\/]+$/\//'`
if [ "X$0" != "X$DIR" ]; then
	cd "$DIR"
fi

findproc() {
        name=$1
        ps=$(ps aux | egrep $1 | egrep -v 'wineconsole' | egrep -v 'grep')
        pid=$(echo $ps | sed -r 's/\S+ (\S+) .*/\1/g')
        echo $pid
}

# See if MBP is running
proc=$(findproc 'marbleblast.exe')

restart=0

# If the proc is running in the first place, don't do anything
if [ -n "$proc" ]
then
	echo "Detected running server... stopping it now and will restart on completion of update"
        restart=1
        ./stop-server.sh
fi

# Game directory
cd ..

MONO=$(which mono)
$MONO ./MBLauncher-Cli.exe pq $(pwd)

if [ $restart -eq 1 ]
then
        ./scripts/start-server.sh
fi
