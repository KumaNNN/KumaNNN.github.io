---
title: php
date: 2019-02-28 12:36:17
updated: 2019-02-28 12:36:17 
mathjax: false
categories: 
tags:
typora-root-url: imgs
typora-copy-images-to: imgs
top: 1
---


# PHP



## 计算机网络知识

### IP地址

IP地址是指互联网协议地址（英语：Internet Protocol Address，又译为网际协议地址），是IP Address的缩写。IP地址是IP协议提供的一种统一的地址格式，它为互联网上的每一个网络和每一台主机分配一个逻辑地址，以此来屏蔽物理地址的差异。   

IP是英文[Internet Protocol](http://baike.baidu.com/view/696501.htm)的缩写，意思是“[网络之间互连的协议](http://baike.baidu.com/view/565688.htm)”，也就是为[计算机网络](http://baike.baidu.com/view/25482.htm)相互连接进行通信而设计的协议。在[因特网](http://baike.baidu.com/view/1706.htm)中，它是能使连接到网上的所有计算机网络实现相互通信的一套规则，规定了计算机在因特网上进行通信时应当遵守的规则。任何厂家生产的[计算机系统](http://baike.baidu.com/view/1130583.htm)，只要遵守IP协议就可以与[因特网](http://baike.baidu.com/view/1706.htm)互连互通。正是因为有了IP协议，[因特网](http://baike.baidu.com/view/1706.htm)才得以迅速发展成为世界上最大的、开放的计算机[通信网络](http://baike.baidu.com/view/71985.htm)。因此，IP协议也可以叫做“[因特网](http://baike.baidu.com/view/1706.htm)协议”。   

IP地址是一个32位的二进制数，通常被分割为4个“8位[二进制](http://baike.baidu.com/view/18536.htm)数”（也就是4个字节）。IP地址通常用“[点分十进制](http://baike.baidu.com/view/828066.htm)” ，例：点分十进IP地址（100.4.5.6），实际上是32位二进制数（01100100.00000100.00000101.00000110）。

 

### 域名

为什么会出现域名：为了方便记忆！    

`` www.baidu.com  ``   
从右往左层级越来越高！             

**.com**  商业    
**.cn**   中国   
**.hk**   香港   
**.us**   美国   
**.gov**  政府   
**.edu**  教育   
**.net**  网络    

 

IP地址是Internet主机的作为路由寻址用的数字型标识，人不容易记忆。因而产生了域名（domain name）这一种字符型标识。

域名的构成：以一个常见的域名为例说明，baidu网址是由二部分组成，标号“baidu”是这个域名的主域名主体，而最后的标号“com”则是该域名的后缀，代表的这是一个com国际域名，是[顶级域名](http://baike.baidu.com/view/119298.htm)。而前面的www.是网络名。www有特殊的含义：world wide web也就是万维网的意思

 

### DNS

域名解析系统  用来将域名解析为对应的IP地址  DNS服务器它会安装在三大运营商的机房里面！     

DNS（Domain Name System，域名系统），因特网上作为域名和IP地址相互映射的一个分布式数据库，能够使用户更方便的访问互联网，而不用去记住能够被机器直接读取的IP数串。通过主机名，最终得到该主机名对应的IP地址的过程叫做域名解析（或主机名解析）。DNS使用端口号53。   



### 端口号

在网络技术中，端口（Port）包括逻辑端口和物理端口两种类型。物理端口指的是物理存在的端口，如ADSL Modem、集线器、交换机、路由器上用 于连接其他网络设备的接口，如RJ-45端口、SC端口等等。逻辑端口是指逻辑意义上用于区分服务的端口，如TCP/IP协议中的服务端口，端口号的范围从0到65535，比如用于浏览网页服务的80端口，用于FTP服务的21端口等。由于物理端口和逻辑端口数量较多，为了对端口进行区分，将每个端口进行了编号，这就是端口号。   

端口有什么用呢？我们知道，一台拥有IP地址的主机可以提供许多服务，比如Web服务、FTP服务、SMTP服务等，这些服务完全可以通过1个IP地址来实现。那么，主机是怎样区分不同的网络服务呢？显然不能只靠IP地址，因为IP 地址与网络服务的关系是一对多的关系。实际上是通过“IP地址+端口号”来区 分不同的服务的。   

邮件地址：中粮商务公园+门牌号   
网页：IP地址+端口号   

http协议它是走80端口！   
win+R  ---->  cmd--->netstat –an   查看端口号

----



## PHP简介

### PHP是什么

PHP原始：**personal home page**  个人主页     

PHP于1994年由Rasmus Lerdorf创建，刚刚开始是Rasmus Lerdorf为了要维护个人网页而制作的一个简单的用Perl语言编写的程序。这些工具程序用来显示 Rasmus Lerdorf 的个人履历，以及统计网页流量。后来又用C语言重新编写，包括可以访问数据库。他将这些程序和一些表单直译器整合起来，称为 PHP/FI。PHP/FI 可以和数据库连接，产生简单的动态网页程序   

Hypertext Preprocessor，中文名：“超文本预处理器”是一种通用开源脚本语言。语法吸收了C语言、Java和Perl的特点，利于学习，使用广泛，主要适用于Web开发领域。PHP 独特的语法混合了C、Java、Perl以及PHP自创的语法。它可以比CGI或者Perl更快速地执行动态网页。用PHP做出的动态页面与其他的编程语言相比，PHP是将程序嵌入到HTML（标准通用标记语言下的一个应用）文档中去执行，执行效率比完全生成HTML标记的CGI要高许多；PHP还可以执行编译后代码，编译可以达到加密和优化代码运行，使代码运行更快。   

**注意：**   

​       PHP代码它是可以嵌入在HTML网页里面！

 

----



### PHP的特点

PHP主要用来做web服务器端开发，用于实现用户的各种web请求；也能做软件开发（不常用）   

PHP是开源自由软件，能够在所有的操作系统平台上稳定的运行   

PHP入门比较简单，容易上手，语法类似于C语言，能够实现面向过程和面向对象并用   

PHP支持多种主流的数据库，比如：mssql、mysql、Oracle、sybase等，只不过和Mysql是“黄金搭档”----**LAMP**  ( Linux   Apache  Mysql   PHP)     

---



### B/S结构

**Browser/Server**  浏览器与服务器结构，这种结构是web界应用用的最多的！    
B/S它只需要用户安装浏览器就可以使用！  一对多的关系    

**C/S**   客户端/服务器   一对一关系     

**服务器：**   就是安装了相关服务软件的电脑。   


   

为什么在浏览器上输入对应的域名就可以访问对应的网站？    
电脑与电脑之间的相互访问必须是要使用IP地址来进行访问。    


第一步：用户在浏览器中输入对应的域名后，本机电脑会去系统盘中一个叫hosts文件(``C:\Windows\System32\drivers\etc\hosts``)中去查找这个域名与IP地址的对应关系，如果有就会将这个IP地址给到浏览器    


第二步：如果没有，系统就会去互联网上面去查找这个域名对应的IP地址，DNS服务器 如果找的到就将对应的IP地址给到浏览器，如果找不到就直接显示该网页无法显示。

![](php_01.jpg) 



**一个重要观念：**     
web软件的运行模式中，总是先在客户端（浏览器端），发起一个“请求”，然后，服务器端才产生反馈动作（就是“运行”程序），并因此而返回给该浏览器一定的信息——就是所谓的应答（响应）；

----



## 安装和配置PHP



### 安装PHP

**首先，要搞清楚PHP与Apache之间的关系！**     

Apache负责接收浏览器的请求，此时，如果浏览器请求的是静态资源（以html结尾），Apache就直接作出响应，但是如果浏览器请求的是PHP资源（以php结尾），那么apache就应该将请求交由PHP模块来处理！   


所以，二者的关系是Apache调用PHP！   
典型的，Apache与PHP之间的关系，是将PHP配置成Apache的一个功能模块！   

 

**什么叫Apache的功能模块？**   

Apache本身并不是很强大，但是它可以加载很多模块来扩展功能，也可以说，Apache就是一个由很多个模块组成的软件，Apache的某一个模块，就专门负责Apache的某一项功能！   


可以通过查看Apache的配置文件：``apache/conf/httpd.conf``   
众多的模块都是利用配置指令LoadModule加载到Apache的内部的，每个模块，其实是一个编译好了的库文件！   

我们也可以通过Apache的命令行``httpd.exe  –M``来查看当前apache已经加载了哪些模块。  

 

### 配置PHP

#### 第一步：将PHP配置成Apache的一个功能模块

Apache它是由很多很多的模块组成的！   
Apache需要使用``LoadModule``这个指令将PHP模块加载过来     




**加载指令：**    
``LoadModule   模块名（不能随意改）    模块的动态链接库所在的位置（路径）``      

 

其中：PHP的模块的名字是**php7_module**(php程序代码已经规定好了不能更改！)

![](php_02.jpg)



可以使用cmd窗口中的``httpd.exe  –M ``查找Apache中加载的模块      

但是，此时，还无法解析PHP文件！     
因为，此时Apache只是加载了PHP模块，还没有给PHP“分配任务”！     
因为Apache并不是将所有的请求都交给PHP来处理，而且根据请求资源的文件类型来决定！     

 

#### 第二步：在apache中将PHP文件交给php模块处理

将以**.php**为扩展名的文件交给PHP引擎进行处理     

``` ini
;指令：
AddType  application/x-httpd-php.php
;或者，告诉Apache去php安装目录找php的配置文件
<FilesMatch  '\.php$'>
   setHandler  application/x-httpd-php
</FilesMatch>
```



#### 第三步：确定并加载PHP的配置文件

PHP所使用的配置文件名php.ini是可以出现在任何的目录中的，而当前应该使用哪一个呢？此时应该先告知**apache**去哪里去找 **php.ini**     

为了便于管理，将PHP的配置文件放到PHP的安装目录下：     
在 Apache 配置中，配置如下：
```ini
PHPIniDir  'php.ini 配置文件所在的的目录'
```

 ![](php_03.jpg) 

![](php_04.png)



**注意：**       
不管是修改了Apache的配置文件还是PHP的配置文件，都需要重启Apache。     

 

