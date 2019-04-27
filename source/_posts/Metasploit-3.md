---
title: Metasploit-3 网络漏洞扫描之Openvas环境搭建与使用
date: 2019-04-20 16:02:01
categories: Metasploit魔鬼训练营笔记
---
## 一、漏洞扫描前期知识点梳理
<p>
1.通过网络对目标进行搜集主要技术有主机探测与端口扫描、服务扫描与查点与网络漏洞扫描等，最强大的开源网络扫描软件为Nmap和OpenVAS，都可以集成到metasploit框架中。

2.metasploit提供了丰富网络扫描、服务扫描、查点功能

3.metasploit提供了对postgresql数据库的支持，能够存储渗透测试过程中搜集目标网络情报信息，为渗透测试的威胁建模、漏洞分析、渗透攻击与报告撰写等阶段提供数据支持，并支持数据库共享与MSF	 RPC服务两种方式在渗透测试团队之间共享信息。
</p>
4.黑盒扫描、白盒扫描

## 二、**openVAS漏洞扫描器介绍与环境搭建**

<h2>1.功能</h2>
类似于nuessus的综合型漏洞扫描器，可以用来识别主机、web应用存在的各种漏洞。
opoenvas环境搭建过程
<h2>2.主要功能模块</h2>

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190326145316649.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjE1MTcwOQ==,size_16,color_FFFFFF,t_70)
**3.openvas安装**
（1）apt install openvas
（2）重置密码openvasmd --user=admin --new-password=hahaha
（3）openva-start开启openvas
（4）openvas-check-setup检查openvas配置是否正确
**4.openvas简单漏扫步骤**

**0x01 建立一个扫描目标**
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190326151955579.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjE1MTcwOQ==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190326152031819.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjE1MTcwOQ==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190326152048630.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjE1MTcwOQ==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190326152058256.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjE1MTcwOQ==,size_16,color_FFFFFF,t_70)
**0x02 建立一个新的扫描任务**

建立完扫描目标之后，需要建立扫描任务关联扫描目标。

建立扫描任务有两种方式：

①  可以使用任务向导进行任务的创建，任务向导可以快速的建立并开启一个扫描任务；高级任务向导有更详细的选项，如登录凭证之类的信息；修改任务向导可以快速的选择之前创建的任务重新创建任务开启扫描。任务向导中没有填写的选项都按照设置（Extras→My Settings）的默认配置进行扫描任务配置。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190326152131209.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjE1MTcwOQ==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190326152141594.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjE1MTcwOQ==,size_16,color_FFFFFF,t_70)
② 可以通过星型图标新建任务创建扫描任务，内容较详细。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190326152300347.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjE1MTcwOQ==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190326152311672.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjE1MTcwOQ==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190326152319417.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjE1MTcwOQ==,size_16,color_FFFFFF,t_70)
**0x03 扫描测试**
扫描机：kali-2019.1
靶机：metasploit魔鬼训练营dvssc网络环境
扫描结果：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190326152921815.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjE1MTcwOQ==,size_16,color_FFFFFF,t_70)

