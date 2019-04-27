---
title: Metasploit-6-1 Web应用渗透之基础知识与Wmap扫描操作
date: 2019-04-20 16:29:31
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
    
    .-.-.-..-.-.-..---..---.
    | | | || | | || | || |-'
    `-----'`-'-'-'`-^-'`-'
    [WMAP 1.5.1] ===  et [  ] metasploit.com 2012
    [*] Successfully loaded plugin: wmap
    msf5 > help
    
    wmap Commands
    =============
    
    Command       Description
    -------       -----------
    wmap_modules  Manage wmap modules        
    wmap_nodes    Manage nodes							
    wmap_run      Test targets
    wmap_sites    Manage sites								
    wmap_targets  Manage targets
    wmap_vulns    Display web vulns
    msf5 > wmap_sites -a http://10.10.10.129              (1)
    [*] Site created.
    msf5 > wmap_sites -l                                  (2)
    [*] Available sites
    ===============
    
         Id  Host          Vhost         Port  Proto  # Pages  # Forms
         --  ----          -----         ----  -----  -------  -------
         0   10.10.10.129  10.10.10.129  80    http   0        0

通过命令添加要扫描的网站（1）查看扫描的targest（2）

    msf5 > wmap_targets -t http://10.10.10.129                           （3）
    msf5 > wmap_run -t                                                   （4）
    [*] Testing target:
    [*] 	Site: 10.10.10.129 (10.10.10.129)
    [*] 	Port: 80 SSL: false
    ============================================================
    [*] Testing started. 2019-03-26 03:59:14 -0400
    [*] Loading wmap modules...
    
    [*] 39 wmap enabled modules loaded.
    [*] 
    =[ SSL testing ]=
    ============================================================
    [*] Target is not SSL. SSL modules disabled.
    [*] 
    =[ Web Server testing ]=
    ............................................skip
添加网站作为扫描目标（3），同时查看哪些模块将会在扫描中使用（4）

    msf5 > wmap_run -e                                                      （5）
    [+] 10.10.10.129:80 Apache/2.2.14 (Ubuntu) mod_mono/2.4.3 PHP/5.3.2-1ubuntu4.5 with Suhosin-Patch mod_python/3.3.1 Python/2.6.5 mod_perl/2.0.4 Perl/v5.10.1
    （6）
    [+] Contents of Robots.txt:                                             （7）
    User-agent: *
    Disallow: /administrator/
    Disallow: /cache/
    msf5 > vulns                                                             (8)
    
    Vulnerabilities
    ===============
    
    Timestamp                Host          Name                       References
    ---------                ----          ----                       ----------
    2019-03-26 08:01:35 UTC  10.10.10.129  HTTP Trace Method Allowed  CVE-2005-3398,CVE-2005-3498,OSVDB-877,BID-11604,BID-9506,BID-9561
查看wmap扫描结果并进行攻击（5）看到目标服务器的旗标等信息（6），同时找到服务器敏感信息（7），最后通过vulns显示扫描出来的漏洞信息（8）
