#!/bin/bash

bookmark=~/.config/google-chrome/Default/Bookmarks
nextchapter=0;
#0=get name, #1=get url, else= something wrong
lastAction=-1;

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

checkNextChapter()
{

	nextchapter=-1;	
	#$1 = url
	#echo $1
	echo "Getting web page content...."
	#page=`curl $url`
	page=`elinks --dump $1`
	if [ ! -z `echo $1 | grep "http://tw.ikanman.com"` ]; then
		echo "11"
	
	elif [ ! -z `echo $1 | grep "8yyls.com"` ]; then
			if [ ! -z `echo $page | grep "下一話"` ]; then
				# hava next chapter
				echo "22"
				nextchapter=1;

			else
				nextchapter=0;
			fi
			echo $page | grep "下一話"
			echo "25"

	elif [ ! -z `echo $1 | grep "http://www.dm5.com"` ]; then

			echo $page
			if [ ! -z `echo $page | grep "finalPage_4_w.png"` ]; then
				# hava next chapter
				echo "330"
				nextchapter=1;
			elif [ ! -z `echo $page | grep "Service\ Unavailable"` ]; then
				echo "331"				
				nextchapter=-2;
			else
				echo "332"
				nextchapter=0;
			fi
		echo "333"	
	else
		#unknow website
		echo "44"
		nextchapter=-1;	

	fi

}

awk /parse-start/,/parse-end/ $bookmark > comic.tmp

while read line
do
	name=`echo $line | grep "\"name\":"` 

	if [ ! -z "$name" ];then

		echo "------------------------------------------------"
		p_start=`echo $name | grep "parse-start"`
		p_end=`echo $name | grep "parse-end"`
		if [ ! -z "$p_start" ] || [ ! -z "$p_end" ]; 
		then
			continue;
		else
			echo "$name" | awk -F: '{print $2}'
			lastAction=0;
			continue;
		fi
	fi

	if [ $lastAction == 0 ]; then
		url=`echo $line | grep "\"url\":" | sed s/\"url\"://g | sed s/\"//g `
		if [ ! -z "$url" ];then
			echo "[URL] = $url"

			checkNextChapter $url

			if [ $nextchapter -eq 1 ];then
				printf "${BLUE}Have Next Chapter ${NC} \n"
			elif [ $nextchapter -eq 0 ]; then
				printf "${RED}Don't Have Next Chapter ${NC} \n"
			elif [ $nextchapter -eq -1 ]; then
				printf "${RED} Unknow Web Site ${NC} \n"
			elif [ $nextchapter -eq -2 ]; then
				printf "${RED} Service Unavailable  ${NC} \n"
			else
				printf "${RED} Unknow reson ${NC} \n"
			fi			

			lastAction=1;
			continue;
		fi
	fi
	
done < comic.tmp

rm comic.tmp



