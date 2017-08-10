#! /bin/bash
(
echo "10" ; sleep 2
echo "# 正在更新 Apache2 記錄檔" ; sleep 2
echo "30" ; sleep 2
echo "# 正在更新郵件伺服器的記錄檔" ; sleep 2
echo "50" ; sleep 2
echo "# 正在清除工作清單之中" ; sleep 2
echo "80" ; sleep 2
echo "# 正在完成中，請稍候...." ; sleep 2
echo "100" ; sleep 2
) |
zenity --progress \
	--title="系統維護中" \
	--text="掃瞄系統..." \
	--percentage=0 \
	--pulsate

if [ "$?" = 1 ] ; then
	zenity --error \
	--text="維護作業已取消。"
fi