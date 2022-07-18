#!/bin/bash

home_trbot=/usr/share/zabbix/local/trbot/
fhome=$home_trbot

f_text=$1
echo $f_text



dl=$(wc -m $f_text | awk '{ print $1 }')
echo "dl="$dl
if [ "$dl" -gt "4000" ]; then
	sv=$(echo "$dl/4000" | bc)
	sv=$((sv+1))
	echo "sv="$sv
	i1=0
	
	for (( i=1;i<=$sv;i++)); do
		[ "$i1" -gt "$str_col" ] && break
		echo "--------i="$i"------"
		str_col=$(grep -cv "^----------" $f_text)
		echo "str_col="$str_col
		
		again2="yes"
		i1=0
		odl=0
		while [ "$again2" = "yes" ]
			do
			echo "odl="$odl
			i1=$((i1+1))
			echo "i1="$i1
			test=$(sed -n $i1"p" $f_text | tr -d '\r')
			len1=${#test}
			len1=$((len1+1))
			echo "len1="$len1
			od2=$((odl+len1))
			echo "od2="$od2
			if [ "$od2" -gt "4000" ]; then
				echo "start rez"
				i1=$((i1-1))
				echo "new i1="$i1
				head -n $i1 $f_text > $fhome"rez"$i".txt"
				tcol=$((str_col-i1))
				echo "tcol="$tcol
				tail -n $tcol $f_text > $fhome"rez_tmp.txt"
				echo "rez-------------------->"
				cp -f $fhome"rez_tmp.txt" $f_text
				
				#read var1
				again2="no"
			else
				echo "not rez"
				odl=$od2
			fi
			if [ "$i1" -gt "$str_col" ]; then
				echo "end rez"$i1
				cp -f $f_text $fhome"rez"$i".txt"
				again2="no"
				break
			fi
		done
	done
	rm -f $fhome"rez_tmp.txt"
else
	cp -f $f_text $fhome"rez1.txt"
fi

