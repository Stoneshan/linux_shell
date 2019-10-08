#!/bin/bash
#
#********************************************************************
#Author:               Stone
#QQ：                  346035967
#Date：                2019-10-08-01-35
#FileName：            batch_delete_users.sh
#Description：         The is script used for deleting users batchly
#Copyright (C)：      2019 All rights reserved
#********************************************************************
#
#***************准备条件************
#
# 判断是否为root账号
if [ ! "$USER" == 'root' ];then
	echo "非特权root用户，没有权限"
	exit 1
fi

#*************设置变量*************
#
user_num=`seq -s ' ' -w 1 20`

#***********删除用户***************
#
deluser () {
for i in $user_num
	do
		userdel -rZ Luffy$i
		if [ $?==0 ];then
			echo "删除用户Luffy$i成功"
		else
			echo "删除用户Luffy$i失败"
			exit 1
		fi
done
}
#*************执行函数操作*************
#
deluser