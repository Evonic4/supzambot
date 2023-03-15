#!/bin/bash
#supzambot

ftb=/usr/share/trbot2/
fm="$ftb"mail.txt
home_trbot=$ftb




function Init2()
{
logger "init2 start"
#load conf
token=$(sed -n 1"p" $ftb"settings.conf" | tr -d '\r')
#log=$(sed -n 2"p" $ftb"settings.conf" | tr -d '\r')
lid=$(sed -n 3"p" $ftb"settings.conf" | tr -d '\r')
echo $lid > $ftb"lastid.txt"
fPID=$(sed -n 4"p" $ftb"settings.conf" | tr -d '\r')
f_send=$(sed -n 5"p" $ftb"settings.conf" | tr -d '\r')
sec=$(sed -n 6"p" $ftb"settings.conf" | tr -d '\r')
sec4=$(sed -n "8p" $ftb"settings.conf" | tr -d '\r')
sec4=$((sec4/1000))
chat_id1=$(sed -n 9"p" $ftb"settings.conf" | tr -d '\r')
chat_id_tech=$(sed -n 10"p" $ftb"settings.conf" | tr -d '\r')
loglevel=$(sed -n 11"p" $ftb"settings.conf" | tr -d '\r')

user1=$(sed -n 12"p" $ftb"settings.conf" | tr -d '\r')
pass1=$(sed -n 13"p" $ftb"settings.conf" | tr -d '\r')
urlpoint1=$(sed -n 14"p" $ftb"settings.conf" | tr -d '\r')
urlpoint2=$(sed -n 15"p" $ftb"settings.conf" | tr -d '\r')
urlpoint=$urlpoint1$urlpoint2
echo "machine "$urlpoint2" login "$user1 "password "$pass1 > $home_trbot"cr.txt"

tmode=$(sed -n 16"p" $ftb"settings.conf" | tr -d '\r')
n_mode=0
nade=0
progsz=$(sed -n 17"p" $ftb"settings.conf" | tr -d '\r')
ztich=$(sed -n 18"p" $ftb"settings.conf" | tr -d '\r')

mdt_start=$(sed -n 19"p" $ftb"settings.conf" |sed 's/\://g'|sed 's/\-//g'|sed 's/ //g'| tr -d '\r')
mdt_end=$(sed -n 20"p" $ftb"settings.conf" |sed 's/\://g'|sed 's/\-//g'|sed 's/ //g' | tr -d '\r')
pochto=$(sed -n 21"p" $ftb"settings.conf" | tr -d '\r')

logger "init2 stop"
}

Init2;
ibc=$progsz
coolk=0
starten=1

function logger()
{
local date1=`date '+ %Y-%m-%d %H:%M:%S'`
echo $date1" supzambot: "$1
}

mkdir -p $ftb





ticket_status ()
{
logger "start ticket_status"
ttst=$(echo $text | awk '{print $2}' | tr -d '\r')
logger "ticket_status ttst="$ttst

curl -s -m 60 --netrc-file $home_trbot"cr.txt" $urlpoint/api/v1/tickets/search?query=number:$ttst | jq '.' > $home_trbot"zticket.txt" #'.assets.Ticket'
[ "$loglevel" -gt "1" ] && logger "ticket_status superlog" && cat $home_trbot"zticket.txt"

str_col2=$(grep -cv "^#" $home_trbot"zticket.txt")
logger "ticket_status str_col2="$str_col2

if [ "$str_col2" -gt "6" ]; then

statet=`cat $home_trbot"zticket.txt" | grep -m1 state_id | awk '{print $2}' | sed 's/\"/ /g' | sed 's/\,/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//'`
groupt=`cat $home_trbot"zticket.txt" | grep -m1 group_id | awk '{print $2}' | sed 's/\"/ /g' | sed 's/\,/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//'`
priorityt=`cat $home_trbot"zticket.txt" | grep -m1 priority_id | awk '{print $2}' | sed 's/\"/ /g' | sed 's/\,/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//'`
titlett=`cat $home_trbot"zticket.txt" | grep title | sed 's/: /TQ4534534/g' | awk -F"TQ4534534" '{print $2}' | sed 's/\"/ /g' | sed 's/\,/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//'`
customer=`cat $home_trbot"zticket.txt" | grep -A8 User | grep login | sed 's/: /TQ4534534/g' | awk -F"TQ4534534" '{print $2}' | sed 's/\"/ /g' | sed 's/\,/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//'`

statet1=$(sed -n $statet"p" $home_trbot"t_st.txt" | tr -d '\r')
groupt1=$(sed -n $groupt"p" $home_trbot"t_gr.txt" | tr -d '\r')
priorityt1=$(sed -n $priorityt"p" $home_trbot"t_pr.txt" | tr -d '\r')
#logger "ticket_status statet1="$statet1

echo "Ticket="$ttst > $home_trbot"tst.txt"
echo $titlett >> $home_trbot"tst.txt"
echo "customer: "$customer >> $home_trbot"tst.txt"
echo "group: "$groupt1 >> $home_trbot"tst.txt"
echo "state: "$statet1 >> $home_trbot"tst.txt"
echo "priority: "$priorityt1 >> $home_trbot"tst.txt"
echo "---- " >> $home_trbot"tst.txt"

logger "ticket_status send"
#rm -f $home_trbot

else
logger "ticket_status NO send"
echo "tickets not found" > $home_trbot"tst.txt"
fi

otv=$ftb"tst.txt"
send;

}


roborob () 
{
date1=`date '+ %d.%m.%Y %H:%M:%S'`
#logger "roborob text="$text
otv=""

if [ "$text" = "/start" ] || [ "$text" = "/?" ] || [ "$text" = "/help" ] || [ "$text" = "/h" ]; then
	otv=$ftb"help.txt"
	send;
fi
if [ "$text" = "/ss" ] || [ "$text" = "/status" ]; then
	otv=$ftb"ss.txt"
	send;
fi
if [ "$text" = "/j" ] || [ "$text" = "/job" ]; then
	jobs_status;
fi
if [[ "$text" == /t* ]]; then
	ticket_status;
fi
if [[ "$text" == /nm* ]]; then
	night_mode;
fi

logger "roborob otv="$otv
}



night_mode ()  	
{
logger "start night_mode"
nmst=$(echo $text | awk '{print $2}' | tr -d '\r')
logger "nmst="$nmst

if [ "$nmst" = "off" ]; then
	nade=2
	n_mode=0
	echo "night mode off" > $ftb"nade.txt"
	otv=$ftb"nade.txt";	send;
fi
if [ "$nmst" = "on" ]; then
	nade=1
	tmode=1
	n_mode=1
	echo "night mode on" > $ftb"nade.txt"
	otv=$ftb"nade.txt";	send;
fi
if [ "$nmst" = "def" ]; then
	nade=0
	tmode=$(sed -n 15"p" $ftb"settings.conf" | tr -d '\r')
	echo "night mode default" > $ftb"nade.txt"
	otv=$ftb"nade.txt";	send;
fi
if [ "$nmst" = "" ]; then
	[ "$nade" -eq "2" ] && echo "night mode off" > $ftb"nade.txt"
	[ "$nade" -eq "1" ] && echo "night mode on" > $ftb"nade.txt"
	[ "$nade" -eq "0" ] && echo "night mode default" > $ftb"nade.txt"
	otv=$ftb"nade.txt";	send;
fi
}


send1 ()
{

logger "send1 start"
sleep 1

echo $chat_id1 > $ftb"send.txt"
echo $otv >> $ftb"send.txt"

rm -f $ftb"out.txt"
file=$ftb"out.txt"; 
$ftb"cucu2.sh" &
pauseloop;

if [ -f $ftb"out.txt" ]; then
	logger "send1 superlog1"
	cat $file
	
	if [ "$(cat $ftb"out.txt" | grep ":true,")" ]; then
		logger "send1 OK"
	else
		logger "send1 file+, timeout.."
		sleep 1
	fi
else
	logger "send1 FAIL"
	if [ -f $ftb"cu2_pid.txt" ]; then
		logger "send1 kill cucu2"
		cu_pid=$(sed -n 1"p" $ftb"cu2_pid.txt" | tr -d '\r')
		killall cucu2.sh
		kill -9 $cu_pid
		rm -f $ftb"cu2_pid.txt"
	fi
fi

logger "send1 exit"

}

send ()
{
logger "send start"
rm -f $ftb"send.txt"

chat_id1=$(sed -n 9"p" $ftb"settings.conf" | sed 's/z/-/g' | tr -d '\r')

dl=$(wc -m $otv | awk '{ print $1 }')
echo "dl="$dl
if [ "$dl" -gt "4000" ]; then
	sv=$(echo "$dl/4000" | bc)
	logger "send sv="$sv
	$ftb"rex.sh" $otv
	
	for (( i=1;i<=$sv;i++)); do
		otv=$fhome"rez"$i".txt"
		send1;
		rm -f $fhome"rez"$i".txt"
	done
	
else
	send1;
fi


logger "send exit"
}

pauseloop () 
{
sec1=0
again0="yes"
while [ "$again0" = "yes" ]
do
sec1=$((sec1+1))
sleep 1
if [ -f $file ] || [ "$sec1" -eq "$sec" ]; then
	again0="go"
	logger "pauseloop sec1="$sec1
fi
done
}


input () 
{
logger "input start"

rm -f $ftb"in.txt"
file=$ftb"in.txt";
$ftb"cucu1.sh" &
pauseloop;

if [ -f $ftb"in.txt" ]; then
	[ "$loglevel" -gt "1" ] && logger "input superlog" && cat $home_trbot"in.txt"

	if [ "$(cat $ftb"in.txt" | grep ":true,")" ]; then
		logger "input OK"
	else
		logger "input file+, timeout.."
		sleep 2
	fi
else	#подвис
	logger "input FAIL"
	if [ -f $ftb"cu1_pid.txt" ]; then
		logger "input kill cucu1"
		cu_pid=$(sed -n 1"p" $ftb"cu1_pid.txt" | tr -d '\r')
		#killall cucu1.sh
		kill -9 $cu_pid
		rm -f $ftb"cu1_pid.txt"
	fi
fi

logger "input exit"
}



starten_furer ()  				
{

if [ "$starten" -eq "1" ]; then
	logger "starten_furer starten=1"
	mess_id=$(cat $ftb"in.txt" | jq ".result[].message.message_id" | tail -1 | tr -d '\r')
	logger "starten_furer mess_id="$mess_id
	if ! [ -z "$mess_id" ]; then
		echo $mess_id > $ftb"lastid.txt"
	fi
	logger "starten_furer mess_id="$mess_id
	starten=0
fi

}


parce ()
{
logger "parce"
date1=`date '+ %d.%m.%Y %H:%M:%S'`
mi_col=$(cat $ftb"in.txt" | grep -c message_id | tr -d '\r')
logger "parce col mi_col ="$mi_col
mess_id=$(sed -n 1"p" $ftb"lastid.txt" | tr -d '\r')

for (( i=1;i<=$mi_col;i++)); do
	i1=$((i-1))
	mi=$(cat $ftb"in.txt" | jq ".result[$i1].message.message_id" | tr -d '\r')
	logger "parce mi="$mi

	[ -z "$mi" ] && mi=0
	
	logger "parce ffufuf mess_id="$mess_id", mi="$mi
	if [ "$mess_id" -ge "$mi" ] || [ "$mi" -eq "0" ]; then
		ffufuf=1
		else
		ffufuf=0
	fi
	logger "parce ffufuf ffufuf="$ffufuf
	
	
	if [ "$ffufuf" -eq "0" ]; then
		chat_id=$(cat $ftb"in.txt" | jq ".result[$i1].message.chat.id" | sed 's/-/z/g' | tr -d '\r')
		logger "parce chat_id="$chat_id
		if [ "$(echo $chat_id1|sed 's/-/z/g'| tr -d '\r'| grep $chat_id)" ]; then
			logger "parse chat_id="$chat_id" -> OK"
			text=$(cat $ftb"in.txt" | jq ".result[$i1].message.text" | sed 's/\"/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//' | tr -d '\r')
			logger "parse text="$text
			#echo $text > $home_trbot"t.txt"
			roborob;
			
			logger "parce ok"
		else
			logger "parce dont! chat_id="$chat_id" NOT OK"
		fi
	fi
done
echo $mi > $ftb"lastid.txt"

}


prelibomb ()
{
cp -f $3 $1
echo "$(cat $2)" >> $1
echo "----" >> $1
}


jobs_status ()
{
logger "jobs_status start"
curl -s  -m 60 --netrc-file $home_trbot"cr.txt" $urlpoint/api/v1/tickets/search?query=9 | jq '.' | grep -A6 "group_id\"\: 6" | grep -A3 "state_id\"\: 2" | grep number | awk -F":" '{print $2}' | sed 's/\"/ /g' | sed 's/,/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//' > $home_trbot"jobs.txt"
[ "$loglevel" -gt "1" ] && logger "jobs_status superlog" && cat $home_trbot"jobs.txt"

str_co2=$(grep -cv "^#" $home_trbot"jobs.txt")
logger "jobs_status str_co2="$str_co2

if [ "$str_co2" -gt "0" ]; then
	prelibomb $home_trbot"zammad.txt" $home_trbot"jobs.txt" $home_trbot"zammad2.txt"
	logger "jobs_status send"; otv=$ftb"zammad.txt"; send;
else
	echo "no open tickets" > $home_trbot"zammad.txt"
	logger "jobs_status send"; otv=$ftb"zammad.txt"; send;
fi
logger "jobs_status stop"
}


auth_stat()
{
ibc=$((ibc+1))
if [ "$ibc" -gt "$progsz" ]; then
	logger "auth_stat check credentials Zammad"
	curl -s -m 60 --netrc-file $home_trbot"cr.txt" $urlpoint/api/v1/tickets/search?query=number:$ztich | jq '.' > $home_trbot"zticket_ch.txt"
	if [ "$(grep "Invalid BasicAuth credentials" $home_trbot"zticket_ch.txt")" ]; then
		logger "auth_stat Invalid BasicAuth credentials Zammad"
		$home_trbot"cucu3.sh" "Invalid_BasicAuth_credentials_Zammad"
		echo "Invalid BasicAuth credentials Zammad" > $home_trbot"ss.txt"
	else
		echo "ok" > $home_trbot"ss.txt"
	fi
	ibc=0
fi
}


parce3 ()
{
logger "parce3 start"
curl -s  -m 60 --netrc-file $home_trbot"cr.txt" $urlpoint/api/v1/tickets/search?query=9 | jq '.' | grep -A6 "group_id\"\: 6" | grep -A3 "state_id\"\: 2" | grep number | awk -F":" '{print $2}' | sed 's/\"/ /g' | sed 's/,/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//' > $home_trbot"int2.txt"
#curl -s --netrc-file $home_trbot"cr.txt" $urlpoint/api/v1/tickets/search?query=9 | jq '.' | grep -A6 "group_id\"\: 6" | grep -A3 "state_id\"\: 1" | grep number | awk -F":" '{print $2}' | sed 's/\"/ /g' | sed 's/,/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//' > $home_trbot"int1.txt"
logger "parce3 superlog1" && cat $home_trbot"int2.txt"

str_co2=$(grep -cv "^#" $home_trbot"int2.txt")
#str_col=$(grep -cv "^#" $home_trbot"int1.txt")
logger "parce3 str_co2="$str_co2

if [ "$str_co2" -gt "0" ]; then
	for (( i=1;i<=$str_co2;i++)); do
	test=$(sed -n $i"p" $home_trbot"int2.txt" | tr -d '\r')
	logger "parce3 test="$test
		if ! [ "$(grep $test $home_trbot"int3.txt")" ]; then
			if [ "$n_mode" -eq "0" ] || ! [ "$(grep $test $home_trbot"arh.txt")" ]; then
				echo $test >> $home_trbot"int3.txt"
				echo $test >> $home_trbot"arh.txt"
				logger "parce3 n_mode false, add open ticket "$test
				cp -f $home_trbot"zammad1.txt" $home_trbot"zammad.txt"
				echo $test >> $home_trbot"zammad.txt"
				curl -s --netrc-file $home_trbot"cr.txt" $urlpoint/api/v1/tickets/search?query=number:$test | jq '.assets.Ticket' | grep title | sed 's/: /TQ4534534/g' | awk -F"TQ4534534" '{print $2}' | sed 's/\"/ /g' | sed 's/\,/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//' > $home_trbot"tmp1.txt"
				echo "$(cat $home_trbot"tmp1.txt")" >> $home_trbot"zammad.txt"
				echo "----" >> $home_trbot"zammad.txt"
				#numtick=$(sed -n 1"p" $home_trbot"tick.txt" | tr -d '\r')
				#[ "$test" -gt "numtick" ] && echo $test > $home_trbot"tick.txt"
				logger "parce3 send"; otv=$ftb"zammad.txt"; send;
			else
				logger "parce3 n_mode true, "$test" in arh"
				echo $test >> $home_trbot"n_buf.txt"
			fi
		fi
	done
	echo "$(cat $home_trbot"int2.txt")" > $home_trbot"int3.txt"
else
	k=`curl -s -I -m 60 --netrc-file $home_trbot"cr.txt" $urlpoint | grep "HTTP" | awk '{print $2}'`
	if [ "$k" -eq "200" ]; then
		coolk=$((coolk+1))
		if [ "$coolk" -gt "10" ]; then
			rm -f $home_trbot"int3.txt"	
			touch $home_trbot"int3.txt"
			coolk=0
		fi
	else
		coolk=0
	fi

fi


logger "parce3 stop"
}

parce4 ()
{
logger " "
logger "parce4 start"
cd /home/en/fetchmail/mail/new/; fetchmail -v -f /home/en/fetchmail/fetchmail.conf
#su en -c 'cd /home/en/fetchmail/mail/new/; fetchmail -v -f /home/en/fetchmail/fetchmail.conf' -s /bin/bash
grep "Subject: " /home/en/fetchmail/mail/new/* > $home_trbot"int2.txt"

str_co4=$(grep -cv "^#" $home_trbot"int2.txt")
logger "parce4 str_co4="$str_co4
if [ "$str_co4" -gt "0" ]; then
	for (( i=1;i<=$str_co4;i++)); do
	url=$(sed -n $i"p" $home_trbot"int2.txt" | awk '{print $2}' | tr -d '\r')
	numtick=$(sed -n $i"p" $home_trbot"int2.txt" | awk '{print $3}' | tr -d '\r')
	tematick=$(curl -s --netrc-file $home_trbot"cr.txt" $urlpoint/api/v1/tickets/search?query=number:$numtick | jq '.assets.Ticket' | grep title | sed 's/: /TQ4534534/g' | awk -F"TQ4534534" '{print $2}' | sed 's/\"/ /g' | sed 's/\,/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//')
	logger "parce4 url="$url" numtick="$numtick" tematick="$tematick
	if [ "$n_mode" -eq "1" ]; then
		logger "parce4 n_mode ON, "$numtick" in n_buf.txt"
		echo $numtick >> $home_trbot"n_buf.txt"
	else
		logger "parce4 n_mode OFF"
		cp -f $home_trbot"zammad1.txt" $home_trbot"zammad.txt"
		echo $numtick >> $home_trbot"zammad.txt"
		echo $tematick >> $home_trbot"zammad.txt"
		echo $url >> $home_trbot"zammad.txt"
		echo "----" >> $home_trbot"zammad.txt"
		logger "parce4 send"; otv=$ftb"zammad.txt"; send;
	fi
	done
else
	logger "parce4 no data";
fi
mv -f mv /home/en/fetchmail/mail/new/* /home/en/fetchmail/mail/cur/
}









if ! [ -f $fPID ]; then		#-----------------------
PID=$$
echo $PID > $fPID

logger " "
logger "start bot, loglevel="$loglevel", chat_id1="$chat_id1", chat_id_tech="$chat_id_tech
#starten_furer;
otv=$home_trbot"start.txt"; send;


while true
do
sleep $sec4

if [ "$tmode" -gt "0" ]; then
	if [ "$nade" -eq "0" ]; then
		mdt1=$(date '+%H%M%S')
		logger "mdt1="$mdt1" mdt_start="$mdt_start" mdt_end="$mdt_end
		#mdt_start="000000"
		#mdt_end="090000"
		if [ "$mdt1" \> "$mdt_start" ] && [ "$mdt1" \< "$mdt_end" ]; then
			n_mode=1
		else
			n_mode=0
		fi
	fi
else
	n_mode=0
fi
logger "tmode="$tmode", nade="$nade", n_mode="$n_mode
[ "$n_mode" -eq "0" ] && [ -f $home_trbot"n_buf.txt" ] && prelibomb $home_trbot"zammad.txt" $home_trbot"n_buf.txt" $home_trbot"zammad3.txt" && otv=$ftb"zammad.txt" && send && rm -f $home_trbot"n_buf.txt" && echo "" > /home/en/fetchmail/procmail.log
[ "$pochto" -eq "0" ] && parce3;
[ "$pochto" -eq "0" ] && auth_stat;
[ "$pochto" -eq "1" ] && parce4;

#if ! [ -f $f_send ]; then		#НЕ файл с оповещением
#	chat_id1=$(sed -n 9"p" $ftb"settings.conf" | sed 's/z/-/g' | tr -d '\r')
#	input;
#	parce;
#else 
#	chat_id1=$(sed -n 9"p" $ftb"settings.conf" | sed 's/z/-/g' | tr -d '\r')
#	otv=$f_send
#	logger "OPOVEST! chat_id="$chat_id2", otv="$otv
#	send;
#	rm -f $f_send
#	#exit 0
#fi

#kkik=$(($kkik+1))
#[ "$kkik" -eq "$progons" ] && Init2

done


else #-----------------------
	logger "pid up exit"

fi #-----------------------


rm -f $fPID




