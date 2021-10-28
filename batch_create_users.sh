#!/bin/bash
#
#********************************************************************
#Author:               Stone
#QQ：                  346035967
#Date：                2019-10-08-00-55
#FileName：            batch_create_users.sh
#Description：         The is script used for creating users batchly
#                      10 users with 8 random cipher
#Copyright (C)：      2019 All rights reserved
#********************************************************************
#
#*************设置变量*************
#
# 生产零时保存用户密码文件和用户编号
pw_txt=`mktemp pw.XXX`
user_num=`seq -s ' ' -w 1 20`
# 判断是否为root账号
if [ ! "$USER" = 'root' ];then
	echo "非特权root用户，没有权限"
	exit 1
fi

#*************创建用户名和设置密码*************
#
# 设置输出清单
add_user () {
	echo -e "account\t\tpassword" >user_add_result.txt
# 创建用户
for i in $user_num
       do
                useradd Luffy$i
       done
#生产随机密码到文本
cat /dev/urandom | strings -6 | egrep "^[a-zA-Z0-9]{6}$" head -n 20 >$pw_txt
for i in $user_num
	do
		pw=`head -n $i $pw_txt | tail -1`
		echo $pw | passwd --stdin Luffy$i &>/dev/null
		if [ $? = 0 ];then
			echo -e "Luffy$i\t\t$pw" >> user_add_result.txt
		else
			echo "Luffy$i created faile"
			exit 1
		fi
done
}
#*************显示创建成功,输出清单*************
#
#清屏
clear
echo "用户创建成功，密码文件为:user_add_result.txt"
cat user_add_result.txt
# 清场操作
rm -rf $pw_txt

#*************执行函数操作*************
#
adduser
