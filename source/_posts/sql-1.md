---
title: 使用url采集器+超级SQL注入工具+SQLiDumper对公网的SQL注入进行批量检测
date: 2019-08-14 16:11:05
categories: SQL注入
---

- url采集器的使用
- SQL注入工具的使用
- SQLliDumper工具的使用
- 我已经将打包好的url采集器、python脚本、超级SQL注入工具、SQLiDumper存放在压缩包的同目录下，您的电脑需要提供python环境，Microsoft .NET framework4.5（推荐）

<!---more--->

# 一、使用url采集器搜集公网可能存在注入的url

## 1.在关键词部分输入 inurl:php?id=  

![1.png](../sql-1/1.png)

## 2.采集完成之后，右键下方url部分，导出

![2.png](../sql-1/2.png)

## 3.过滤url

- 由于使用的百度搜索引擎，他的语法不是很好用，我们要使用python脚本进行一遍过滤，我们把导出的ok.txt文件放在磁盘的根磁盘下，python脚本里有读取和写入文件的路径

![3.png](../sql-1/3.png)

- 过滤过的url都变成了?id=这种格式的

![4.png](../slq-1/4.png)

# 二、使用超级SQL注入工具进行SQL注入批量检测

- 在这一步我们可以使用两种不同的注入工具，超级SQL注入工具或者sqlmap，我用的是超级注入工具

## 1.注入扫描里有一个导入模块，将刚刚我们导出的txt文件导入

![5.png](../sql-1/5.png)

## 2.进行注入点扫描，在右侧会显示可能存在注入的url，需要进行手工验证

![6.png](../sql-1/6.png)

## 3.我们手工验证了一下，发现确实存在

![7.png](../sql-1/7.png)

## 三、使用SQLi Dumper进行SQL注入

## 1.将刚刚存在注入的url添加到软件中


## 2.开始注入
- 点击Exploitables->start Exploiter （此软件针对报错注入很完美，可以无视ips），如果刚刚导入的是存在注入的此页面是存在此网页的一些基本信息的

![8.png](../sql-1/8.png)

- 点击injectables start Analize，就会出现存在注入的url

![10.png](../sql-1/10.png)

- 右键Go to Dumper，我们就可以看到所有此网站的数据以及表了，通过getdump等按钮还可以直接获取表的信息

![11.png](../sql-1/11.png)

![12.png](../sql-1/12.png)

![13.png](../sql-1/13.png)



