---
title: security-2 应聘一些题目整理-1
date: 2019-05-01 15:23:34
categories: 网络安全笔记
---
security-2 面试题目整理-2
categories: 网络安全笔记
关于5月份公司招聘的一些面试题目
供自己预习学习
<!--more-->
# SDL
# 缓冲区溢出的防护措施
# 加密算法
RSA加密算法：理论上不能被破解
DES: 目前还没有攻破3DES
AES: 替代原先的DES加密
BNS: 
# 防止Session Cookie被跨站脚本执行漏洞
参考网站：https://www.cnblogs.com/forwill/p/6181984.html
## secure
- secure属性：一个cookie被设置了secure=true，那么这个cookie只能用https协议发送给服务器，http协议不发送。cookie在https的情况下创建的，而且他的Secure=true，之后你一直用https访问其他的页面（比如登录之后点击其他子页面，单点登陆），cookie会被发送到服务器，你无需重新登录就可以跳转到其他页面。如果这是你把url改成http协议访问其他页面，你就需要重新登录了，因为这个cookie不能在http协议中发送。

## httponly
- 在cookie中设置了HttpOnly属性，通过js脚本将无法读取到cookie信息，这样能有效的防止XSS攻击。

## 将session加密
## 多个session标记
# Android逆向分析工具
## Drozer
参考链接：https://wenku.baidu.com/view/f70797ab6137ee06eff91870.html
## 反编译回编译
参考链接：https://blog.csdn.net/qq_37422933/article/details/81356737#
## APKTool
APKTool是GOOGLE提供的APK编译工具，能够反编译及回编译apk，同时安装反编译系统apk所需要的framework-res框架，清理上次反编译文件夹等功能。需要java支持
## Android Killer
Android Killer 是一款可视化的安卓应用逆向工具，集Apk反编译、Apk打包、Apk签名，编码互转，ADB通信（应用安装-卸载-运行-设备文件管理）等特色功能于一 身，支持logcat日志输出，语法高亮，基于关键字（支持单行代码或多行代码段）项目内搜索，可自定义外部工具；吸收融汇多种工具功能与特点，打造一站 式逆向工具操作体验，大大简化了用户在安卓应用/游戏修改过程中的各类繁琐工作。
参考链接：http://doc.okbase.net/guiguzi1110/archive/119043.html
# JEB
# PKI管理对象
- 证书、密钥、证书撤销

# 往年攻击
## xcodeghost
## wormhole
参考链接：https://bbs.kafan.cn/thread-1862013-1-1.html
## 心脏滴血
## shellshock
参考链接：https://blog.csdn.net/Anprou/article/details/72819989
# Hook
# 常用的逆向分析工具
## IDA Pro
交互式反汇编器专业版（Interactive Disassembler Professional），人们常称其为IDA Pro，或简称为IDA。是目前最棒的一个静态反编译软件，为众多0day世界的成员和ShellCode安全分析人士不可缺少的利器！IDA Pro是一款交互式的，可编程的，可扩展的，多处理器的，交叉Windows或Linux WinCE MacOS平台主机来分析程序， 被公认为最好的花钱可以买到的逆向工程利器。IDA Pro已经成为事实上的分析敌意代码的标准并让其自身迅速成为攻击研究领域的重要工具。它支持数十种CPU指令集其中包括Intel x86，x64，MIPS，PowerPC，ARM，Z80，68000，c8051等等。
## WinDBG
调试应用程序的工具
## OLLYDBG
参考链接：https://baike.baidu.com/item/OLLYDBG/4039151?fr=aladdin
 
# 下面哪个是加壳工具
加壳：其实是利用特殊的算法，对可执行文件里的资源进行压缩，只不过这个压缩之后的文件，可以独立运行，解压过程完全隐蔽，都在内存中完成。它们附加在原程序上通过加载器载入内存后，先于原始程序执行，得到控制权，执行过程中对原始程序进行解密、还原，还原完成后再把控制权交还给原始程序，执行原来的代码部分。加上外壳后，原始程序代码在磁盘文件中一般是以加密后的形式存在的，只在执行时在内存中还原，这样就可以比较有效地防止破解者对程序文件的非法修改，同时也可以防止程序被静态反编译。
## upx
## ASPack脱壳工具
## VMProtect
# Android应用程序的结构包括哪些
# android NDK
# IIS状态码
# 关于PKI/CA证书
证书上具有证书授权中心的数字签名
拥有者的基本信息，公开密钥，
# 根本上反域CSRF漏洞
验证referer，cookie，增加tooken
# Android常见风险
## 组件安全
## 数据存储安全
## 数据传输安全
## 漏洞

# SDL安全开发流程
参考链接：https://blog.csdn.net/xinyi0622/article/details/73882559/
## 培训
## 安全
## 质量门/bug栏
## 安全和风险评估
## 安全和隐私风险评估
# 反序列化
参考链接：
https://www.jianshu.com/p/6219d8024d2c
# 魔术引号
魔术引号（Magic Quote）是一个自动将进入PHP脚本的数据进行转义的过程。最好在编码时不要转义而在运行时根据需要而转义
# 0day
# 1day
安全补丁用来修复安全漏洞保护最终用户不受安全威胁。但是公开补丁其实也会带来安全风险。这就是1day
# 堆叠注入
参考链接：https://www.cnblogs.com/0nth3way/articles/7128189.html
# 填充提示漏洞
# If-Modified-Since和If-None-Match
参考链接：https://blog.csdn.net/lhl1124281072/article/details/80067764
参考链接：https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/If-None-Match
# NSA武器库
## explorer.exe
参考链接：
https://baike.baidu.com/item/explorer.exe/1825316
# 反病毒沙盒
沙盒原理是一种类似于影子系统的，比带有宿主的虚拟机更深层的系统内核级技术。它可以接管病毒调用接口或函数的行为。并会在确认病毒行为后实行回滚机制，让系统复原。
沙盒原理也叫沙箱，英文sandbox。在计算机领域指一种虚拟技术，且多用于计算机安全技术。安全软件可以先让它在沙盒中运行，如果含有恶意行为，则禁止程序的进一步运行，而这不会对系统造成任何危害。
# _Hydra(爆破神器)

参考链接：https://www.cnblogs.com/zoushou/p/4126400.html
# 域渗透
参考链接：https://blog.csdn.net/Fly_hps/article/details/80636855
## kerberos
Kerberos是一种计算机网络授权协议，用来在非安全网络中，对个人通信以安全的手段进行身份认证。这个词又指麻省理工学院为这个协议开发的一套计算机软件。
## golden ticket
# powershell
参考链接：https://baijiahao.baidu.com/s?id=1594522197885174841&wfr=spider&for=pc
# badusb
参考链接：http://www.baike.com/wiki/BadUSB
# 重放攻击
重放攻击(Replay Attacks)又称重播攻击、回放攻击，是指攻击者发送一个目的主机已接收过的包，来达到欺骗系统的目的，主要用于身份认证过程，破坏认证的正确性。重放攻击可以由发起者，也可以由拦截并重发该数据的敌方进行。攻击者利用网络监听或者其他方式盗取认证凭据，之后再把它重新发给认证服务器。重放攻击在任何网络通过程中都可能发生，是计算机世界黑客常用的攻击方式之一。
# HMAC
HMAC是密钥相关的哈希运算消息认证码，HMAC运算利用哈希算法，以一个密钥和一个消息为输入，生成一个消息摘要作为输出。
# 哪些是CSRF漏洞的防御方案?
A 检测HTTPreferer 字段同域 
B 限制sessioncookie的生命周期 
C 使用验证码 
D cookie关键字段设置HttpOnly属性
# 以下避免sql注入方法
## mysqli_real_escape_string 
mysql_real_escape_string() 函数转义 SQL 语句中使用的字符串中的特殊字符。
## addslashes() 
在每个双引号（"）前添加反斜杠：
** 未完待续 **
