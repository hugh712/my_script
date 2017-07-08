#!/bin/bash
# usage : download all images from this link
# from Linux Shell Scripting Cookbook [Sarath Lakshman]

if [ $# -ne 3 ];
then 
	echo "Usage : $0 URL -d Directory" 
	exit -1

fi

for i in {1..4}
do
	case $1 in
		-d) shift; directory=$1; shift ;;
		*) url=${url:-$1}; shift;;
	esac
done

mkdir -p $directory;
baseurl=$(echo $url | egrep -o "https?://[a-z.]+")

curl -s $url | egrep -o "<img src=[^>]*>"

curl -s $url | egrep -o "<img src=[^>]*>" | sed 's/<img src=\"\([^"]*\).*/\1/g' > /tmp/$$.list


sed -i "s|^/|$baseurl/|" /tmp/$$.list

cd $directory;


while read filename;
do
		curl -s -O "$filename" --silent

done </tmp/$$.list
