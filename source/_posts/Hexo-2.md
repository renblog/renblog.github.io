---
title: Hexo-2 Hexo主题设置
date: 2019-04-27 17:26:50
categories: Hexo 搭建心得
---
# 修改hexo部署端口
hexo server -p 80

## 站点_config.yml的修改

- 基本信息
- 语言
lanuage: zh-Hans
- next主题


 
 ## 主题_config.yml的修改
 ### next主题样式：
  scheme: Gemini
 ### menu菜单
  home: / || home
  about: /about/ || user
  tags: /tags/ || tags
  categories: /categories/ || th
  archives: /archives/ || archive  
 ### 头像设置
  avata:
  /images/cat.gif

### next动态背景
- 搜索canvas_nest: true

### 侧边栏社交小图片设置

```
#social: 注释去掉
socia_icons:
  enable: true

  Github: github
  
```

## 阅读全文

```
 <\!--more--> //没有斜杠
```

## 添加分类
 
- 新建一个分类页面

```
hexo new page categories
```
source文件夹下有了categorcies/index.md
index.md内容如下：

```
title: 分类
date: 2019-04-27 16:35:57
type: "categories"
```

- 把文章归入分类只需在文章的顶部标题下方添加categories字段，即可自动创建分类名并加入对应的分类中

- 举个栗子：
title: 分类测试文章标题
categories: 分类名


## 添加标签

- 新建一个标签页面

```
hexo new page tags
```

source文件夹下有了tags/index.md
打开index.md文件将title设置为title: 标签
index.md内容如下：

```
title: 标签
date: 2019-04-27 16:42:09
type: "tags"
```
- 把文章添加标签只需在文章的顶部标题下方添加tags字段，即可自动创建标签名并归入对应的标签中

- 举个栗子：
title: 标签测试文章标题
tags: 
   -（空格）标签1
   -（空格）标签2
  
## 添加关于标签
- 新建一个关于页面

```
hexo new page about
```
- source文件夹下有了about/index.md
index.md文件即可编辑关于你的信息
## 添加搜索功能
- 安装 hexo-generator-searchdb 插件

```
npm install hexo-generator-searchdb --save
```

- 打开 站点配置文件 找到Extensions在下面添加

```
#搜索
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```
- 打开 主题配置文件 找到Local search，将enable设置为true

## hexo文章加图片
- 首先把修改站点_config.yml

```
psot_asset_folder:true
```

- 在blog（hexo）目录下执行

```
npm install hexo-asset-image --save
```

- 运行hexo new "博客名"来生成md博客时，会在_post目录下看到一个与博客同名的文件夹。

- 将想要上传的图片先扔到文件夹下，然后在博客中使用markdown的格式引入图片：

```
![你想要输入的替代文字](xxxx/图片名.jpg) //路径使用相对路径
```
## 添加评论功能

```
livere_uid: MTAyMC80MzgyNy8yMDM2Mg==
```
## 添加宠物
- 在博客目录下安装依赖

```
npm install --save hexo-helper-live2d
```
- 在站点_config.yml配置如下信息

```
#宠物
live2d:
  enable: true
  scriptFrom: local
  pluginRootPath: live2dw/
  pluginJsPath: lib/
  pluginModelPath: assets/
  tagMode: false
  debug: false
  model:
    use: live2d-widget-model-hijiki
  display:
    position: right
    width: 150
    height: 300
  mobile:
    show: true
```
- 安装模型包
```
npm install 模型的包名

```
参考链接：
https://blog.csdn.net/qq_43020645/article/details/82794092
- 取消宠物

```
npm uninstall hexo-helper-live2d
```
