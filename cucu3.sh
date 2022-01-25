#!/bin/bash

#telegramm bot rada - SEND2

ftb=/usr/share/trbot2/
token=$(sed -n "1p" $ftb"settings.conf" | tr -d '\r')
proxy=$(sed -n 7"p" $ftb"settings.conf" | tr -d '\r')
chat_id_tech=$(sed -n 10"p" $ftb"settings.conf" | tr -d '\r')


if [ -z "$proxy" ]; then
curl -L -s -X POST https://api.telegram.org/bot$token/sendMessage -F chat_id="$chat_id_tech" -F text=$1
else
curl --proxy $proxy -L -s -X POST https://api.telegram.org/bot$token/sendMessage -F chat_id="$chat_id_tech" -F text=$1
fi

