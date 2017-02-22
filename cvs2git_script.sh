#!/bin/bash

#$1=project name

if [ ! -d $1 ]; then
  echo "$1 not  found"
  exit 0	
fi

echo "found $1"

fbname=$(basename "$1")


rm -rf temp


mkdir -p temp/dat/$fbname
mkdir -p temp/project/$fbname
mkdir -p  project/$fbname

echo -e "\033[32m run the conversion \033[0m"
cvs2git \
	--encoding=utf_8\
	--encoding=big5\
	--blobfile=git-blob.dat \
	--dumpfile=git-dump.dat \
	--username=cvs2git \
  $1

mv git-blob.dat temp/dat/$fbname/
mv git-dump.dat temp/dat/$fbname/

echo -e "\033[32m Initialize a git repository  \033[0m"
git init --bare temp/project/${fbname}.git
cd temp/project/${fbname}.git
pwd



echo -e "\033[32m Load the dump files into the new git repository \033[0m"
pwd
cat ../../dat/$fbname/git-blob.dat ../../dat/$fbname/git-dump.dat | git fast-import


echo -e "\033[32m Re-compact the repository and discard any garbage \033[0m"
git gc --prune=now

cd ../../../project/$fbname
pwd

echo -e "\033[32m make a non-bare clone \033[0m"
git clone ../../temp/project/${fbname}.git


echo -e "\033[32m remove local remote info \033[0m"
cd ${fbname}
git remote rm origin
