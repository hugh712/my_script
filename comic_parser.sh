#!/bin/bash

bookmark=~/.config/google-chrome/Default/Bookmarks


checkNextChapter()
{

	#$1 = url
	#echo $1
	if [ ! -z `echo $1 | grep "http://tw.ikanman.com"` ]; then
		echo $1

	elif [ ! -z `echo $1 | grep "http://www.dm5.com"` ]; then
		echo $1

	fi
#	if [ $1 == "http://tw.ikanman.com" ]; then
#		echo 123 
#	fi


	#page=`curl $url`
}




#0=get name, #1=get url, else= something wrong
lastAction=-1;



awk /parse-start/,/parse-end/ $bookmark > comic.tmp



while read line
do
	name=`echo $line | grep "\"name\":"` 
	if [ ! -z "$name" ];then
		echo "$name" | awk -F: '{print $2}'
		lastAction=0;
		continue;
	fi

	if [ $lastAction == 0 ]; then
		url=`echo $line | grep "\"url\":" | sed s/\"url\"://g | sed s/\"//g `
		if [ ! -z "$url" ];then
			echo "[URL] = $url"

			checkNextChapter $url
			

			lastAction=1;
			continue;
		fi
	fi
	
done < comic.tmp




