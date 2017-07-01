#!/bin/bash
# usage : list all file types in this folder
# from Linux Shell Scripting Cookbook [Sarath Lakshman]


if [ $# -ne 1 ]; then
	echo $0 basepath;
fi

path=$1

declare -A statarray;

while read line;
do 
	ftype=`file -b "$line"`
	let statarray["$ftype"]++;
done < <(find $path -type f)

echo "-------------File types and counts-------------"
for ftype in "${!statarray[@]}";
do
	echo $ftype : ${statarray["$ftype"]}
done	
