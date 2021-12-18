#!/bin/bash -x

DIR=`echo $0 | sed -E 's/\/[^\/]+$/\//'`
if [ "X$0" != "X$DIR" ]; then
        cd "$DIR"
fi

findproc() {
        name="$1"
        ps=$(ps aux | egrep "$1" | egrep -v 'grep')
        pid=$(echo "$ps" | sed -E 's/[[:alnum:]]+[[:space:]]+([[:alnum:]]+).*/\1/g')
        echo $pid
}

# See if MBP is running
proc=$(findproc 'MarbleBlast Gold')

restart=0

# Game directory
cd ..

# If the proc is running in the first place, don't do anything
if [ -n "$proc" ]
then
        echo "Detected running server... stopping it now and will restart on completion of update"
        restart=1
        ./scripts/stop-server.sh
fi

MONO=$(which mono)
$MONO ./scripts/MBLauncher-Cli.exe pq $(pwd)

if [ $restart -eq 1 ]
then
        ./scripts/start-server.sh
fi

