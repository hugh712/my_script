#! /bin/bash
zenity --calendar \
	--title="請選擇一個日期" \
	--text="點按日期即可選擇" \
	--day=19 --month=5 --year=2017 \
	1> ans.txt
