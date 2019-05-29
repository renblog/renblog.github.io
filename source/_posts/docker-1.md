---
title: docker-1 搭建漏洞环境并进行漏洞环境测试
date: 2019-05-29 23:30:39
categories: docker
---
# 目录
- docker简介
- docker的安装
- docker、centos7、windows10（博主宿主机系统）之间相互通信
- ~~-docker容器中下载weblogic12c（可以略过不看）~~
- docker容器中下载vulhub漏洞环境
- 验证Weblogic T3反序列化漏洞（CVE-2017-10271）
- 用wireshark抓渗透过程的包
<!---more--->

# docker简介
- Docker 是一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的镜像中，然后发布到任何流行的 Linux或Windows 机器上，也可以实现虚拟化。容器是完全使用沙箱机制，相互之间不会有任何接口。

## docker的优点

- 硬件成本低，虚拟化硬件损耗也较低，性能好；
- 可以做到运行环境快速部署，启动极快，伸缩有弹性；
- 支持打包管理，保证一致性；
- 动态调度迁移成本低。
**ps:博主用docker主要是为了，下载有漏洞的框架，来进行渗透测试，提高自己的渗透能力。（例如：weblogc 反序列化漏洞、strust2漏洞）**

# docker的安装
## 前期准备
- 在虚拟机上已经搭建好centos7系统
- Docker 要求 CentOS 系统的内核版本高于 3.10 ，查看本页面的前提条件来验证你的CentOS 版本是否支持 Docker 。
- 配好yum源

## docker正式安装
- 确保 yum 包更新到最新

```
yum update
```

- 卸载旧版本（如果安装过旧版本的话）

```
yum remove docker  docker-common docker-selinux docker-engine
```
- 安装需要的软件包， yum-util 提供yum-config-manager功能，另外两个是devicemapper驱动依赖的

```
yum install -y yum-utils device-mapper-persistent-data lvm2
```

- 设置yum源

```
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

- 可以查看所有仓库中所有docker版本，并选择特定版本安装

```
yum list docker-ce --showduplicates | sort -r
```

- 下载并安装container-selinux

```
下载
wget http://mirrors.atosworldline.com/public/centos/7/extras/x86_64/Packages/container-selinux-2.68-1.el7.noarch.rpm
安装
rpm -ivh container-selinux-2.68-1.el7.noarch.rpm --nodeps --force
```

- 安装docker

```
yum install docker-ce  #由于repo中默认只开启stable仓库，故这里安装的是最新稳定版17.12.0
执行上面的命令是默认安装，下面这条命令就不用执行了
yum install <FQPN>  # 例如：sudo yum install docker-ce-17.12.0.ce

```

- 启动并加入开机启动

```
systemctl start docker
systemctl enable docker
```
- 验证安装是否成功(有client和service两部分表示docker安装启动都成功了)


```
docker version
```

# docker、centos7、windows10（博主宿主机系统）之间相互通信
- VM中centos7的网络连接方式为nat，并将网卡配置成dhcp模式
- docker默认是docker 0网卡，保持默认配置

## 让windows10和虚拟机通讯
**NAT模式，centos7可以ping通windows10，windows10却不能ping通centos7**
- 问题在于主机的适配器设置中，NAT相关的适配器变成了自动获取IP地址。
- 右击电脑右下角网络的符号，点击“打开网络和共享中心” -> “更改适配器设置”，就可以看到虚拟机的几个适配器配置，NAT模式的配置一般是VMnet8。
- 右键 -> 属性 -> IPv4 -> 属性。
- 设置ip地址和centos7在同一网段，即可。

## 让windows10和docker通讯
- Windows10连接centos7中的Docker容器的
- 拓扑图


```
 宿主机(windows10)--------->虚拟机(192.168.2.131)---------->docker容器 (172.17.0.1)
```
- 如果此时在宿主机中ping Docker容器是ping不同的，因为在宿主机上没有通往172.18.0.2网络的路由，宿主机会将发往172.18.0.2网络的数据发往默认路由，这样就无法到达容器。

- 解决方法：
 （1）首先要保证centos7和Docker容器，用ping测试是否通畅
 （2）关闭虚拟中的防火墙： systemctl stop firewalld.service
 （3）打开windows10的cmd,在其中添加通往 172.17.0.21网络的路由。
 （4）通往 172.17.0.1网络的数据包由192.168.2.131来转发
- 具体操作
- cmd(管理员模式)下


```
route add -p 172.17.0.0 mask 255.255.0.0 192.168.2.131  //-p表示永久添加
```

- 查看添加的路由：


```
route print
172.17.0.0      255.255.0.0    192.168.2.131    192.168.2.200     36
```
# docker容器中下载weblogic12c（可略过不看）
- 获取镜像


```
docker pull ismaleiva90/weblogic12
//docker pull #获取镜像
//ismaleiva90/weblogic #weblogic的镜像，后面没有指定镜像版本就会获取默认的 latest版本
```
- 生成并启动容器

```
docker run -d -p 49163:7001 -p 49164:7002 -p 49165:5556 ismaleiva90/weblogic12:latest
//docker run    #启动
//-d    #使得容器后台运行
//-p   #指定端口号
//ismaleiva90/weblogic：latest  #镜像的详细信息

//2018/3/6 启动命令： docker run -d -p 7001:7001 -p 7002:7002 --restart=always //ismaleiva90/weblogic12:latest
//启动命令更改之后，访问端口变为 7001，  http://172.17.0.1:7001/console
docker run -d -p 7001:7001 -p 7002:7002 --restart=always ismaleiva90/weblogic12:latest
```

- 在浏览器中访问weblogic
http://172.17.0.1:49163/console


```
172.150.19.40  #当前主机的ip地址
49163 #访问端口号
访问结果，出现登录页面
```
- 登录账号和密码：


```
用户名：  weblogic
密码：    welcome1
```

# docker容器中下载vulhub漏洞环境
## docker-compose 的安装及使用

- Docker Compose 是一个用来定义和运行复杂应用的 Docker 工具。使用 Docker Compose 不再需要使用 shell 脚本来启动容器。(通过 docker-compose.yml 配置)


- 安装
- 可以通过修改 URL 中的版本，自定义您需要的版本。


```
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```
- 卸载


```
sudo rm /usr/local/bin/docker-compose
```
## 正式下载漏洞环境Vulhub
- 下载docker漏洞环境：Vulhub

**Vulhub是一个面向大众的开源漏洞靶场，无需docker知识，简单执行两条命令即可编译、运行一个完整的漏洞靶场镜像。旨在让漏洞复现变得更加简单，让安全研究者更加专注于漏洞原理本身。**
- 搭建漏洞环境


```
 git clone https://github.com/vulhub/vulhub.git
 https://github.com/vulhub/vulhub/archive/master.zip   //直接下载地址
```
- 进入vulhub-master/weblogic/CVE-2017-10271目录

- 运行命令


```
docker-compose up -d //安装此漏洞环境
docker ps //查看运行服务端口
```
- 访问ip:port即可看到web网页


![1.png](../docker-1/1.png)

```
docker-compose down //测试完毕之后，使用此命令即可结束服务，使环境变为初始状态。
```
# 验证Weblogic xml反序列化漏洞（CVE-2017-10271）
- 用工具查看是否存在weblogic xml反序列化漏洞，检测工具请自行百度下载

![2.png](../docker-1/2.png)

- 利用反序列化漏洞，执行系统命令

![3.png](../docker-1/3.png)

# 用wireshark抓渗透过程的包
- 执行whoami命令的抓包

![5.png](../docker-1/5.png)

- 抓到响应体的包

![root.png](../docker-1/root.png)



