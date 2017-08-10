#! /bin/bash
zenity --text-info \
	--title="修改 /etc/hosts" \
	--filename=/etc/hosts \
	--editable 1> tmp.txt;