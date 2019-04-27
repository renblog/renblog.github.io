---
title: Metasploit-6-2 web应用渗透之漏洞扫描神器W3AF
date: 2019-04-20 16:32:37
categories: Metasploit魔鬼训练营笔记
---
**一、扫描神器W3AF（Web Application Attack and Audit Framework）
1.W3AF简介**
W3AF是阿根廷人Andres Riancho创建的一个开源项目，目标是成为一个Web应用攻击和统计的平台。目前W3AF分为主要两个部分——核心模块和插件部分。
核心模块负责进程的调度和插件的使用，插件部分则负责查找并攻击Web安全漏洞。
插件部分根据功能的不同，又分为8类模块，包括：发现模块、审计模块、搜索模块、攻击模块、输出模块、修改模块、入侵模块、破解模块，他们之间的运行关系如图：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190326164557136.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjE1MTcwOQ==,size_16,color_FFFFFF,t_70)
**2.各模块的功能
（1）发现模块**
负责查找HTTP信息，并探测服务器、数据库、web应用防火墙等信息例如halberd、hmap、afd、fingetprint等信息。在发现模块中，最重要的插件是webSpider，它基于爬虫技术爬取网站的每个链接和表单，这是进行漏洞探测不可或缺的信息。
**（2）暴力破解**
破解哪些需要认证的页面，在发现过过程中，经常会遇到认证登陆页面，暴力破解模块支持对基本认证机制的破解（需要配置字典），以及表单登陆机制的暴力破解。
**（3）审计模块**
探测漏洞的模块，W3AF支持目前主流的web应用漏洞类型的探测，例如SQLi、XSS等，探测漏洞的方法也是多种多样的，例如模式匹配、基于显示错误的方法、基于时间延迟的方法、远程创建、响应差别（如采用不同的参数输入AND 1=1、AND 1=2）等，当确定存在安全漏洞的同时，存在漏洞的URL会被保存，等待攻击模块对它实施攻击。
**（4）搜索Grep**
捕获HTTP请求与应答过程中的一些关注信息（例如IP、Email地址、信用卡信息等），它仅能用来分析数据，统统是修改模块允许使用者基于正则表达式修改相关的请求和应答消息。
**（5）攻击模块**
用来读取前面扫描获取的扫描信息，然后试图通过该类模块中的各种插件来攻击安全漏洞，例如：sql_webshell、advshell、sqlmap、xssbeef、remote file include shell、os command shell等。
**3.W3AF使用**
