#!/bin/bash

DIR=`echo $0 | sed -E 's/\/[^\/]+$/\//'`
if [ "X$0" != "X$DIR" ]; then
        cd "$DIR"
fi

./stop-server.sh
./start-server.sh
