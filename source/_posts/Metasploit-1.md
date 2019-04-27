---
title: Metasploit-1 公开信息收集
date: 2019-04-20 11:53:14
categories: Metasploit魔鬼训练营笔记
---

一、web应用渗透技术基础知识
二、web应用攻击发展趋势
三、owasp Web漏洞 TOP 10
1.SQL注入攻击
2.跨站脚本
3.跨站伪造请求
4.会话认证管理缺陷
5.安全误配置
6.不安全密码存储
7.不安全的对象参考
8.限制URL访问失败
9.缺乏传输层保护
10.未验证的重定向和跳转
四、web应用攻击典型案例

## **五、基于metasploit框架的web应用渗透技术**

**1.辅助模块**
metasploit的辅助模块基本都在modules/auxiliary/下。web应用辅助扫描、漏洞查找等模块。
**（1）wmap web扫描器**
**0x01  wmap简介**
Wmap本身不是一个独立的漏洞扫描器，而是作为Metasploit的一个模块，结合Web漏洞和Web服务相关的模块协同工作，完成目标服务器的扫描任务，也就是说，如果我们想要使用Wmap模块就需要将它在Metasploit中载入才可以使用。
**0x02  metasploit数据库准备**
在运行 Metasploit 终端前，我们需要先启动用于存储扫描结果的数据库服务：

    service postgresql start
如果是初次使用，需要初始化并启动数据库：

    msfdb init
    msfdb start
**0x03 Wmap使用**
首先打开一个终端，启动Metasploit:

    msfconsole
  然后等待msf打开之后，我们在msf中载入wmap的插件:

      load wmap

**0x04  wmap渗透测试**
实验环境：
攻击主机：kali linux 2019.1
靶机：www.dvssc.com(10.10.10.129)

    msf5 > load wmap
    
