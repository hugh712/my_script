#!/bin/bash
# usage : find all words and count them
# from Linux Shell Scripting Cookbook [Sarath Lakshman]

if [ $# -ne 1 ];
then
	echo "Usage: $0 filename";
	exit -1
fi

filename=$1

egrep -o "\b[[:alpha:]]+\b" $filename | awk '{ count[$0]++ }
END{ printf("%-14s%s\n", "Word","Count") ;
for(ind in count)
	{ printf("%-14s%d\n",ind,count[ind]); }
}'
