#!/bin/bash
#
#********************************************************************
#Author:               Stone
#QQ：                  346035967
#Date：                2019-10-09-03-18
#FileName：            create_random_name_file.sh
#Description：         The test script
#Copyright (C)：      2019 All rights reserved
#********************************************************************
#
#*****定义变量********
#
#定义当前目录
cur_dir=`pwd`
#********生产文件********
#
create_doc () {
	for i in `seq 1 10`
		do
			random_strings=`head -c 100 /dev/urandom | tr -dc a-zA-Z | tr [A-Z] [a-z] | head -c 8`
			# 核实字符串必须有8个字长
			strings_length=$random_strings | wc -c 
			if [ $strings_length -eq 8 ];then
				doc_name=${random_strings}_luffy.html
			    #判断没有同名文件时
				if [ ! -f $cur_dir/$doc_name ];then
					touch $cur_dir/$doc_name
					if [ $? -eq 0 ];then
						echo "$doc_name创建成功!"
					else
						echo "$doc_name创建失败!"
						exit 1
					fi
				else
					echo "$cur_dir/目录下有同名文件，请核对!"
					exit 1
				fi
			else
				# 产生不足8个字符的，继续执行，直到找到
				continue
			fi
done

}

#********执行函数********
#
create_doc
