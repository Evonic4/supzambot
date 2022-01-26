#!/bin/bash

#telegramm bot rada INPUT
ftb=/usr/share/trbot2/
fPID=$ftb"cu1_pid.txt"

#Z1=$1

if ! [ -f $fPID ]; then	
	PID=$$
	echo $PID > $fPID
	token=$(sed -n 1"p" $ftb"settings.conf" | tr -d '\r')
	proxy=$(sed -n 7"p" $ftb"settings.conf" | tr -d '\r')

	if [ -z "$proxy" ]; then
		curl -L -m 13 https://api.telegram.org/bot$token/getUpdates > $ftb"in0.txt"
	else
		curl -m 13 --proxy $proxy -L https://api.telegram.org/bot$token/getUpdates > $ftb"in0.txt"
	fi

	mv $ftb"in0.txt" $ftb"in.txt"

fi
rm -f $fPID
