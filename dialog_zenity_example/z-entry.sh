#! /bin/bash
if ! zenity --entry \
	--title="密碼維護" \
	--text="請輸入您的密碼:" \
	--entry-text "654123789" \
	--hide-text
then echo "您並沒有輸入密碼！"
fi > ans.txt