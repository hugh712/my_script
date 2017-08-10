#!/bin/bash
FILE=$(zenity --file-selection --title="請選擇一個檔案")
case $? in
	0)
		echo "已選擇 \"$FILE\"";;
	1)
		echo "沒有選擇檔案.";;
	-1)
		echo "沒有選擇檔案.";;
esac