#!/bin/bash

set -m

chmod +x ./Contents/MacOS/MBExtender
chmod +x "./Contents/MacOS/MarbleBlast Gold"
./Contents/MacOS/MBExtender -dedicated -input platinum/input.txt &
PID=$!

echo $PID > run.pid
fg %1
rm run.pid
