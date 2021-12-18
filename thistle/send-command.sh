#!/bin/bash

DIR=`echo $0 | sed -E 's/\/[^\/]+$/\//'`
if [ "X$0" != "X$DIR" ]; then
        cd "$DIR"
fi

send() {
        command="$2"
        echo "$2" > ../platinum/input.txt
        sleep 1 # So it goes through
        echo "" > ../platinum/input.txt
}

findproc() {
        name="$1"
        ps=$(ps aux | egrep "$1" | egrep -v 'grep')
        pid=$(echo "$ps" | sed -E 's/[[:alnum:]]+[[:space:]]+([[:alnum:]]+).*/\1/g')
        echo $pid
}

# See if MBP is running
proc=$(findproc 'MarbleBlast Gold')

# If the proc isn't running in the first place, don't do anything
if [ -z $proc ]
then
        exit 1
fi

# Try quitting it via screen
send 'mbp' $@

