#!/bin/bash
f1=/usr/share/trbot2/

cd $f1
useradd -d /dev/null -G adm -p 12345 -s /bin/bash mastmetric 
chown -R mastmetric:mastmetric /usr/share/trbot2/
cp -r -f ./logrotate /etc/logrotate.d/ && cd /etc/logrotate.d/ && chown root:root * && chmod 640 *
mkdir -p /var/log/trbot/ && chown -R mastmetric:mastmetric /var/log/trbot/

cd $f1
ls | sed -n '/.sh/p' | sed 's/setup.sh//g' | sed '/^$/d' > $f1"fs"

for x in `cat $f1"fs"|grep -v \#`
do
chmod +rx $x
perl -pi -e "s/\r\n/\n/" $x
echo $x
done


ls | sed -n '/.php/p' | sed '/^$/d' > $f1"fs"

for x in `cat $f1"fs"|grep -v \#`
do
chmod +rx $x
perl -pi -e "s/\r\n/\n/" $x
echo $x
done

ls | sed -n '/.py/p' | sed '/^$/d' > $f1"fs"

for x in `cat $f1"fs"|grep -v \#`
do
chmod +rx $x
perl -pi -e "s/\r\n/\n/" $x
echo $x
done

