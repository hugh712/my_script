#!/bin/bash
# Description: To check the situation which processes keep Cache and buffer 
# Ref  : http://colobu.com/2017/03/07/what-is-in-linux-cached/
# Ref  : https://github.com/tobert/pcstat

#you have to install pcstat
PCSTAT=/usr/local/bin/pcstat

if [ ! -f $PCSTAT ]
then
    echo "You haven't installed pcstat yet"
		echo "prepare to download and install pcstat"
		if [ $(uname -m) == "x86_64" ] ; then
    	curl -L -o pcstat https://github.com/tobert/pcstat/raw/2014-05-02-01/pcstat.x86_64
		else
    	curl -L -o pcstat https://github.com/tobert/pcstat/raw/2014-05-02-01/pcstat.x86_32
		fi
		chmod 755 pcstat
		sudo mv pcstat /usr/local/bin		
fi

#find the top 10 processs' cache file
ps -e -o pid,rss|sort -nk2 -r|head -10 |awk '{print $1}'>/tmp/cache.pids

#find all the processs' cache file
#ps -e -o pid>/tmp/cache.pids
if [ -f /tmp/cache.files ]
then
    echo "the cache.files is exist, removing now "
    rm -f /tmp/cache.files
fi

while read line
do
    lsof -p $line 2>/dev/null|awk '{print $9}' >>/tmp/cache.files 
done</tmp/cache.pids

if [ -f /tmp/cache.pcstat ]
then
    echo "the cache.pcstat is exist, removing now"
    rm -f /tmp/cache.pcstat
fi

for i in `cat /tmp/cache.files`
do
    if [ -f $i ]
    then
        echo $i >>/tmp/cache.pcstat
    fi
done

$PCSTAT `cat /tmp/cache.pcstat`
rm -f /tmp/cache.{pids,files,pcstat}

