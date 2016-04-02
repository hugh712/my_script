#!/bin/bash	

Ref="from-sd-card.img"

echo -e "Image is \033[32m $1 \033[0m"
echo -e "Device is \033[32m $2 \033[0m"

echo " "
echo -e "\033[32m dd image to device \033[0m"
echo "dd bs=4M if=$1 of=$2"
dd bs=4M if=$1 of=$2

echo " "
echo -e "\033[32m dd content back to host \033[0m"
echo "dd bs=4M if=/dev/sdd of=from-sd-card.img"
dd bs=4M if=$2 of=$REF

echo " "
echo -e "\033[32m truncate \033[0m"
echo "truncate --reference $1 $REF"
truncate --reference $1 $REF

echo " "
echo -e "\033[32m diff \033[0m"
echo "diff -s $REF $1"
diff -s $REF $1

echo " "
echo "sync"
sync;sync;sync



