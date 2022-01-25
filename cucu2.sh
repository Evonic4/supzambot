#!/bin/bash

#telegramm bot rada - SEND

ftb=/usr/share/trbot2/
fPID=$ftb"cu2_pid.txt"

Z1=$1


if ! [ -f $fPID ]; then		#----------------------- старт------------------
PID=$$
echo $PID > $fPID
token=$(sed -n "1p" $ftb"settings.conf" | tr -d '\r')
chat_id=$(sed -n "1p" $ftb"send.txt" | tr -d '\r')
f_text=$(sed -n "2p" $ftb"send.txt" | tr -d '\r')
proxy=$(sed -n 7"p" $ftb"settings.conf" | tr -d '\r')

IFS=$'\x10'
text=`cat $f_text`


echo "token="$token
echo "chat_id="$chat_id
echo $text

if [ -z "$proxy" ]; then
curl -L -s -X POST https://api.telegram.org/bot$token/sendMessage -F chat_id="$chat_id" -F text=$text > $ftb"out0.txt"
else
curl --proxy $proxy -L -s -X POST https://api.telegram.org/bot$token/sendMessage -F chat_id="$chat_id" -F text=$text > $ftb"out0.txt"
fi

mv $ftb"out0.txt" $ftb"out.txt"

fi #----------------------- конец старт------------------
rm -f $fPID
