#!/bin/bash

#按日归档特定目录下的文件

#获取当前日期
DATE=$(date +%y%m%d)

#设置归档文件名
FILE=archive${DATE}.tar.gz

#设置配置文件的路径和目的文件名
CONFIG_FILE=/archive/Files_To_Backup
DESTINATION=/archive/$FILE

#脚本开始
#检查配置文件是否存在
if [ -f $CONFIG_FILE ]
then
	echo
else
	echo
	echo "$CONFIG_FILE文件不存在"
	echo
	exit
fi

#检查需要归档的文件是否存在
FILE_NO=1   #配置文件的开始第一个行
exec < $CONFIG_FILE    #重定向标准输入到配置文件
read FILE_NAME        #读文件一行记录

while [ $?-eq 0 ]
do
	if [ -f $FILE_NAME -o -d $FILE_NAME ];then
		FILE_LIST="$FILE_LIST $FILE_NAME"
	else
		echo
		echo"$FILE_NAME不存在"
		echo"当前不归档此文件"
		echo"此文件在配置文件的$FILE_NO行"
		echo"继续归档...."
		echo
	fi
	FILE_NO=$[%FILE_NO+1]  #增加行
	read FILE_NAME
done

#归档并压缩文件
echo "开始归档..."
echo
tar -zcf $DESTINATION $FILE_LIST 2> /dev/null  
echo"归档完成"
echo"归档文件在$DESTINATION"
echo

exit


###################################################
#按日进行的归档
#！/bin/bash
CONFIG_FILE=/archive/hourly/Files_To_Backup

#设置归档目录
BASEDEST=/archive/hourly

DAY=$(date +%d)
MONTH=$(date +%m)
TIME=$(date +%k0%M)

mkdir -p $BASEDEST/$MONTH/$DAY

DESTINATION=$BASEDEST/$MONTH/$DAY/archive$TIME.tar.gz



	