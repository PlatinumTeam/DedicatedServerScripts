#!/bin/bash -x

send() {
	name=$1
	command="${2}"
	screen -S $name -X stuff "${command}"`echo -ne '\015'`
}

send 'mbp' "${1}"
