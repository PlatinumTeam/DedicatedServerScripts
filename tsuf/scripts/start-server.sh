#!/bin/bash -x

DIR=`echo $0 | sed -E 's/\/[^\/]+$/\//'`
if [ "X$0" != "X$DIR" ]; then
	cd "$DIR"
fi

cd ..

findproc() {
	name=$1
	ps=$(ps aux | egrep $1 | egrep -v 'wineconsole' | egrep -v 'grep')
	pid=$(echo $ps | sed -r 's/\S+ (\S+) .*/\1/g')
	echo $pid
}

# See if MBP is running
proc=$(findproc 'marbleblast.exe')

# If the proc is running in the first place, don't do anything
if [ -n "$proc" ]
then
	exit 0
fi

# Backup the old server's log
backupfile=$(stat --printf "consoles/console-%y" console.log)
mv console.log "$backupfile"
gzip "$backupfile"

# Pretty simple server starting script
screen -dmS mbp wineconsole ./marbleblast.exe -dedicated
