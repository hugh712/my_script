#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: ./transpose file "
	exit 1
fi


if [ ! -f $1 ]; then
	echo file $1 not exist
	exit 1
fi

awk '
{ 
    for (i=1; i<=NF; i++)  {
        a[NR,i] = $i
    }
}
NF>p { p = NF }
END {    
    for(j=1; j<=p; j++) {
        str=a[1,j]
        for(i=2; i<=NR; i++){
            str=str" "a[i,j];
        }
        print str
    }
}' $1

