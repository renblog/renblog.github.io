---
title: Hexo-1 Hexo环境搭建+github部署备份
date: 2019-04-27 17:18:24
categories: Hexo 搭建心得
---
# Hexo环境准备
## npm、hexo安装
- 阿里云轻量级服务器 or 虚拟机搭建的linux
- xshell远程链接阿里云服务器
- 服务器安装rz，sz
yum install lrzsz
- 安装node.js
设置全局
<!-- more -->
```
cd node/bin
ln -s /root/install/node/bin/node /usr/local/bin/node
ln -s /root/install/node/bin/npm /usr/local/bin/npm

```
- 安装hexo并设置全局

```
npm install hexo-cli -g
ln -s /root/install/node/lib/node_modules/hexo/bin/hexo /usr/local/bin/hexo
```
## github配置
- github用户注册为renblog
- 创建renblog.github.io库
- 创建hexo分支，设置成为默认分支
- 安装git

```
yum install git-core
```
- 克隆库

```
git clone https://github.com/renblog/renblog.github.io.git
```

 - 进入克隆的库执行
 
 
 ```
 npm install hexo
 ```
 
 <font size=3>- ** 注意
 克隆的库中有.git文件夹，在hexo init执行前，一定先备份.git文件夹，在hexo init之后，再把备份的.git文件夹覆盖到renblog.github.io中 **
 </font>
 创建一个空的文件
 然后执行如下命令

```
hexo init
```
- 生成的文件移到renblog.github.io目录下并覆盖
- renblog.github.io目录继续下执行

```
npm install
npm install hexo-deployer-git（此时检查分支实在hexo下）
```

# blog备份到github上
- 修改_config.yml如下：

```
deploy:
  type: git
  repo: https://github.com/renblog/renblog.github.io
  branch: master
```
- 还是在renblog.github.io目录下执行

```
git add .
git commit -m "命名"
git push origin hexo //推到github上，
```

# 部署博客到github


- 设置git的用户名和email（操作一次即可）

```
git config --global user.name "你的Github用户名"
git config --global user.email "你注册Github使用的邮箱"
```
- 部署到github上

```
hexo clean       //如果界面有延迟执行此命令
hexo g           //生成加载页面
npm install --save hexo-deployer-git  //部署git
hexo d           //部署hexo
```
- 访问git上的博客
- 链接为：
renblog.github.io

# 关于日常的一些改动
依此执行如下命令

```
git add .
git commit -m "注释"
git push origin hexo
(此时默认分支依然是hexo)
```
然后执行

```
hexo g -d //发布网站到master上
```

# 测试blog是否备份成功一
- 在我的阿里云服务器上测试
- 进入/var/www/html目录下

```
git clone https://github.com/renblog/renblog.github.io.git //拷贝仓库
```
会生成renblog.github.io文件夹
- 进入此文件夹执行如下命令

```
npm install hexo
npm install 
npm install hexo-deployer-git
```
- ** 注意不需要加hexo init命令**

创建一篇文章
```
hexo new Hexo-1
```
- 执行如下备份命令

```
git add.
git commit -m "注释"
git push origin hexo
git clean
git g -d //推到github上
```
- ** 先备份后发布 **

# 测试blog是否备份成功二

- 将刚刚创建的新仓库 clone 至本地，将之前的 hexo 文件夹中的 _config.yml、themes/、source/、scaffolds/、package.json 和 .gitignore 复制至 WincerChan.github.io 文件夹；

- 将 themes/next/（我用的是 NexT 主题）中的 .git/ 删除，否则无法将主题文件夹 push（也可以将主题文件夹使用子模块的方式添加到该仓库)；

- 在 WincerChan.github.io 文件夹执行 npm install 和 npm install hexo-deployer-git（这里可以看一看分支是不是显示为 hexo）；

- 执行 git add、git commit -m ""、git push origin hexo 来提交 hexo 网站源文件；

- 执行 hexo g -d 生成静态网页部署至 Github 上。


# git常用命令
```
git branch //查看当前分支 
git checkout hexo //切换分支
```
# Hexo _config.yml配置
