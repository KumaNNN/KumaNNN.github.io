---
title: Laravel框架-01
date: 2019-02-28 12:36:17
updated: 2019-02-28 12:36:17 
mathjax: false
categories: 
tags:
typora-root-url: imgs
typora-copy-images-to: imgs
top: 1
---


# Laravel框架



## 一、Laravel-概述

​	Laravel是Taylor Otwell开发的一款基于PHP语言的Web开源框架，采用了MVC的架构模式，在2011年6月正式发布了首个版本。

​	Laravel是一套简洁、优雅的PHP Web开发框架(PHP Web Framework)。它可以让你从面条一样杂乱无章的代码中解脱出来；通过简单、高雅、表达式语法开发出优秀、完美的Web应用。Laravel更拥有高质量的文档、丰富的扩展包，被称为"巨匠级PHP开发框架"。

​	Laravel是当前所有的"全栈式"框架中最流行的，也是世界上使用范围最广，人数最多的一个框架。

官网：https://laravel.com

中文：

https://laravel-china.org

http://laravelacademy.org

## 二、Laravel-部分核心功能

- 工匠指令		artisan
- (模型)Eloquent ORM
- 应用逻辑(Application Logic)
- 反向路由(Reverse Routing)
- Restful控制器(Restful Controllers)
- 自动加载类(Class Auto-loading)
- 视图组装器(View Composers)
- 反向控制器(loC container)
- 迁移(Migrations)
- 单元测试(Unit-Testing)
- 自动分页(Automatic Pagination)

## 三、Laravel-版本

​	LTS版本---长期支持版本，英文Long Term Support的缩写，此类版本是Laravel能提供的最长时间维护版本。2年的Bug修复，3年的安全更新支持。

​	一般发行版---只提供6个月的Bug修复支持，1年的安全修复支持。

版本发行时间(这里讲Laravel5)

- **5.1	LTS	2015年06月份**


​	LTS 版，Bug修复直到2017年06月份，安全修复直到2018年06月份

- **5.2	2015年12月份**


​	一般发行版，提供6个月的Bug修复支持，1年的安全修复支持

- **5.3	2016年08月份**


​	一般发行版本，提供6个月的Bug修复支持，1年的安全修复支持

- **5.4	2017年01月份**


​	一般发行版本，提供6个月的Bug修复支持，1年的安全修复支持

- **5.5	LTS	2017年08月份**


​	LTS版，会从这里开始停止Laravel5.1的Bug修复，安全修复直到2018年08月份

- **5.6	2018年02月份**


​	一般发行版本，提供6个月的Bug修复支持，1年的安全修复支持

----



## 四、==安装==

### 1、开发环境

```
操作系统：	windows10 64位
WAMP环境：	  Apache+PHP7.2+Mysql(phpStudy集成环境)
开发工具：	Sublime/phpstorm
```

### 2、Laravel框架环境要求

```
满足以上需求之后，就可以开始安装 Laravel了
1.PHP >= 5.6.4
2.PHP OpenSSL 扩展
3.PHP PDO 扩展
4.PHP Mbstring 扩展
5.PHP Tokenizer 扩展
6.PHP XML 扩展
7.PHP Ctype 扩展(Laravel5.6)
8.PHP JSON 扩展(Laravel5.6)
```

> 注意：
> 	Laravel5.1~Laravel5.2对PHP版本要求： PHP >=  5.5.9(建议使用 5.6.4)
> 	Laravel5.3~Laravel5.4对PHP版本要求： PHP >=  5.6.4
> ​	Laravel5.5对PHP版本要求： PHP >=  7.0.0
> ​	Laravel5.6对PHP版本要求： PHP >=  7.1.3

### 3、设置环境变量

#### (1) 为什么需要把PHP设置到系统环境变量中

答：为了全局使用php指令，为了后期在Laravel框架项目中方便使用`php artisan`工匠指令生成控制器文件等。



1.设置之前

![1538961939120](1538961939120.png)

2.设置之后

![1538961912134](1538961912134.png)

![1538961979480](1538961979480.png)

> 注意：
> 	上图中的C:\phpStudy\PHPTutorial\php\php-7.2.1-nts路径是根据自己安装的PHP目录来设置；设置环境变量后，必须得**重新启动cmd(黑)窗口**。

#### (2) 测试是否设置成功

- 通过`php -v` 可以查看php版本号

![1538961993287](1538961993287.png)

- 通过`php --ini `查看当前php的php.ini存放在哪个目录下

![1538962058562](1538962058562.png)

- 通过`php -m` 查看当前php环境已经开启的扩展

![1538962145884](1538962145884.png)

- 通过`php -m | findstr mysql `查看当前php环境中是否开启了mysql扩展，如果要查询其他的扩展替换名称即可。他操作系统操作语法也一致。

![1538962193523](1538962193523.png)

### 4、安装Laravel框架

Laravel框架为我们提供了三种安装方式分别为：==源码安装==、==composer安装==、==Laravel安装器==

#### 4.1 源码安装

##### 4.1.1 下载源码

官方下载： https://github.com/laravel/laravel/releases

国内下载地址：http://laravelacademy.org/resources-download
![1538962412741](1538962412741.png)



##### 4.1.2 创建虚拟主机

​	下载回来的一键安装包以后，直接使用phpstudy/wampserver/xamp/upupw或web开发环境中，创建虚拟主机，绑定本地域名，指向到项目中的public目录下即可。

> 注意：
> 	1.如果自己的电脑事先安装过自己的web环境，特别是安装了自己的mysql时，第一次运行phpstudy会主动卸载mysql服务，不会删除我们的mysql软件。
> 	2.以管理员身份运行cmd窗口，切换到mysql的bin目录下，运行以下命令即可：mysql install -n "服务名"。
> 	3.phpstudy无非就是帮我们自动运行了php+mysql+apache/nginx，所以对于统一服务端口，对于phpstudy的窗口中运行状态表示的意思以下：
> 		绿色圆点表示当前电脑有apache/mysql已经在运行[不一定是phpstudy内置的那个]
> 		红色方块表示当前电脑中没有apache/mysql在运行
> 	4.养成一个习惯，运行phpstudy的时候，都是先点击“停止”，然后在点击“运行”，接下来成功运行的就肯定是phpstudy。



> 注意：
> 	本示例以C:\web\php\laravel路径为项目目录路径，存放项目目录路径得根据自己实际情况来。

将刚才下载回来Laravel框架代码解压到D:\www\laravel目录中

![1538962654910](1538962654910.png)



接下来本地域名映射，把上面写的域名 添加到C:\Windows\System32\drivers\etc\hosts文件中

保存hosts文件以后，直接通过浏览器访问。如果出现以下界面，表示安装成功：



访问效果如下：

![1538962954354](1538962954354.png)

访问时可能会报以下错误：

![1538964599045](1538964599045.png)

开启openssl扩展

![1538964688030](1538964688030.png)



#### 4.2 composer安装(推荐)

composer是一个PHP的依赖 管理器，专门用于给我们安装和卸载项目、框架和插件(安装包)，类似于Linux操作系统的yum包管理器。借助composer我们可以找到适合的安装包和框架进行安装。

官网：http://www.getcomposer.org

中文：http://www.phpcomposer.com

中国镜像源：https://pkg.phpcomposer.com/

安装的时候要注意，因为composer的安装需要联网，同时连接的服务器在国外，所以存在很大的失败的可能性，**有二种解决方案：**

1. 多尝试几次

   ![1538964915403](1538964915403.png)

2. 使用离线安装(推荐使用)

   ![1538965232008](1538965232008.png)

   ![1538965342868](1538965342868.png)

   ![1538965477586](1538965477586.png)

使用离线安装记得，务必把composer.bat和php路径设置到环境变量中。

检测是否成功

![1538965527429](1538965527429.png)



##### 4.2.1 使用composer安装Laravel项目

设置镜像为中国镜像

![1538965628169](1538965628169.png)

```
composer config -g repo.packagist composer https://packagist.phpcomposer.com
```

其它源

```
composer config -g repo.packagist composer https://packagist.laravel-china.org 
```



![1538965676479](1538965676479.png)

> 注意：
>
> ​	切换到中国镜像源时，下载第三方插件/Laravel框架都需要用户验证。建议使用下面那种方法，只不过时间相对久一些。

或使用官方源

```cmd
composer config -g repo.packagist composer https://packagist.org
```

![1538966177618](1538966177618.png)



**安装Laravel框架**

```
composer create-project --prefer-dist  laravel/laravel  test 版本(*)
```

![1538965965329](1538965965329.png)

![1538967742300](1538967742300.png)

会提示需要输入用户名与密码

![1538966087881](1538966087881.png)

```
参数说明：
1. create-project	表示使用composer安装Laravel框架
2. --prefer-dist	表示下载安装使用压缩包方式下载，如果没有设置这个选项，默认情况下composer会源码复制的形式下载，这样会很慢。
3. laravel/laravel	软件名称，格式：开发者名称/项目名称
4. test  	        项目本地目录名称，表示把Laravel框架存储到当前目录下的test目录中
5. 版本号			 * 表示最后一个版本，指定安装那个版本时使用
```

使用artisan工匠指令快速运行Laravel项目

```
php artisan serve [--host][--port]
或
php artisan serve --host=local.gzphp31.com --port=80

默认端口：8000
```

![1538967858715](1538967858715.png)

> 注意：
> ​	Laravel运行过程中，cmd命令行不能关闭，否则无法访问
> 	还有artisan是一个php代码的文件，所以以上命令必须在Laravel项目的根目录中运行
> 	--host 指定绑定的域名，默认为127.0.0.1
> 	--port 表示监听端口，默认为8000
> ​	例如：需要指定端口为8080
> ​	php artisan serve --port=8080

直接通过浏览器访问。如果出现以下界面，表示安装成功：

![1538962954354](1538962954354.png)



#### 4.3 Laravel安装器安装

##### 4.3.1 安装Laravel安装器

```
composer global require "laravel/installer"
```

> 注意：
> 	确保 ~/.composer/bin在系统路径[环境变量]中，否则不能在任意路径调用Laravel命令。执行命令以后的话，就是我们的Laravel的家目录。
> 	~ 表示家目录，window下的家目录：C:\Users\你的帐号\AppData\Roaming\Composer\vendor\bin，把这个地址设置到系统环境变量中

安装完成后，通过简单的`Laravel new`命令即可在当前目录下创建一个新的Laravel应用，例如：`laravel new blog`将会创建一个名为blog的新应用，且包含所有Laravel依赖。该安装方法比通过composer安装要快很多。

```
laravel new blog
```

> 为什么不用 laravel/installer ？
>
> laravel/installer 工具在创建项目的时候需要从 laravel 官网（国外）下载 laravel.zip
> 压缩包，速度慢、随时可能被墙，而且下载地址是写死到 installer 工具中的，不能配置，使用的时候出问题无法解决。



### 5、配置智能提示插件

https://packagist.org/packages/barryvdh/laravel-ide-helper

#### 5.1、下载插件

![1538968248464](1538968248464.png)

![1538968297952](1538968297952.png)

```cmd
composer require barryvdh/laravel-ide-helper ^2.4.3
composer require barryvdh/laravel-ide-helper：2.4.3 有一些包名后使用四号指定版本下载会出错
```

![1538968683627](1538968683627.png)

可能报如下错误：

![1538968449634](1538968449634.png)

#### 5.2、配置config/app.php

config/app.php

```php
'providers' => [
    // ...
    Barryvdh\LaravelIdeHelper\IdeHelperServiceProvider::class,
],
```

![1538968815915](1538968815915.png)

#### 5.3、生成 ide_helper.php文件

```cmd
php artisan ide-helper:generate
```

![1538968866701](1538968866701.png)

----



## 五、==Laravel-目录结构==

Laravel是一个比较大的框架，里面的目录文件非常多。

```HTML
|- .env	本地开发环境的配置文件【配置文件】
|- app/	应用目录，项目应用程序主要存放目录[相当于ThinkPHP框架的appcation目录]
	|- Http/	应用的Http请求处理都在这里进行
		|-Controllers/	控制器存储目录【控制器】
	|- Models/	模型存储目录[Laravel5.0版本以后去掉models目录，我们加上即可]
|- config/	配置文件存储目录[项目上线时修改这里的配置，开发阶段时修改.env中的配置]
	|- app.php	系统核心配置文件
	|- database.php	数据库配置文件
|- public/	系统的唯一访问入口，存放所有对外开放的资源目录，如css、js以及img等
	|- index.php	访问入口文件
|- resources/		资源文件存储目录
	|- views/	blade模板文件存储目录【视图】
|- routes/	路由文件存储目录
	|- web.php	主路由文件【路由文件】
|- storage/	临时文件存储目录，存放session、缓存之类的临时文件，包含渲染后的模板文件
	|- framework/	框架生成的文件及缓存文件存储目录
		|- sessions/	session数据存储目录
		|- views/	模板缓存目录【视图】
|- vendor/	Laravel源代码和第三方依赖包存储目录
|- artisan	工匠指令，是命令行工具，在app/Console/Commands下编写自定义命令
|-server.php	入口文件[使用artisan serve命令时的入口目录]
```

> 注意：关于更多的工匠指令请查看附件中的 1-工匠指令.txt 文件

![1538969147530](1538969147530.png)

----



## 六、Laravel-工匠指令

​	工匠指令【artisan】可以让我们通过命令行来自动完成简单而重复的工作，让我们减少时间成本，提高开发效率。

**可以快速的帮我们生成控制器、模型等，文件的生成、缓存、模板的清除工作。**



**常用命令：**

1. 启动项目

   `php artisan serve`

   ​	--port 设置测试服务器的监听端口

2. 创建控制器

   `php artisan make:controller Admin\AdminController`

   ​	--resource 创建资源控制器

   ![1538969270598](1538969270598.png)

   代码：

   ![1538969488436](1538969488436.png)

   创建一个普通控制器

   ![1538969551447](1538969551447.png)

   代码如下：

   ![1538969595965](1538969595965.png)

3. 创建模型

   `php artisan make:model Admin`

   ![1538969688180](1538969688180.png)

   代码如下：

   ![1538969733552](1538969733552.png)

4. 查看路由列表

   `php artisan route:list`

   ![1538970101336](1538970101336.png)

5. 清除项目缓存文件

   `php artisan cache:clear`

6. 清除视图编译文件

   `php artisan view:clear`

> 注意：关于更多的工匠指令请查看附件中的 1-工匠指令.txt 文件

### 1、生成控制器

在Laravel中，我们可以通过artisan快速生成控制器，Laravel中的控制器有**两**种：

1. 一般控制器，适合使用在项目的前台，默认不提供任何的操作方法
2. 资源控制器，适合使用在项目的后台，默认提供了7个操作方法，用于进行对数据表增删改查。因为符合接口编程的restFul规范，所以也被称为"restFul控制器"。

#### 1.1 生成一般控制器

```
语法： php artisan make:controller  目录\控制器类名
```

> 注意：
> 	控制器类名，建议采用驼峰法，每个单词首字母大写；以"Controller"结尾
> 	例如： AdminController
>
> 注意：使用artisan工具生成控制器时控制器名是不需要带后缀( .php )

```
例如：php artisan make:controller Admin\UserController
```



#### 1.2 生成资源控制器

```
语法：php artisan make:controller  目录\控制器类名  --resource
```

> 注意：使用artisan工具生成控制器时控制器名是不需要带后缀( .php )

```
例如：php artisan make:controller Admin\UserController --resource
```



### 2、生成模型

​	我们使用的Laravel5.4版本，所以默认不会有Models目录，所以我们可以约定把所有的模型都保存在app\Models目录。

```
语法：php artisan make:model 目录\模型类名
```

> 注意：
> 	模型的类名建议使用表名作为模型名称，采用驼峰法，每个单词首字母大写，如果出现表名中存在下划线，则去掉下划线。
> 	例如：表名为 member_proession 则模型名称：MemberProfession

----





## 七、==Laravel-路由==

### 1、什么是路由

```
就是把uri地址和对应的应用程序进行一一绑定，形成一种映射关系，这个过程就是路由。
url：http://域名/目录/文件?参数
uri：目录/文件?参数
uri 地址指的就是去掉域名后，剩下的末尾部分
```

### 2、路由的本质

```
接收用户发送过来的uri请求，然后根据事先定义好的路由规则，转发给对应的应用程序。
路由规则：事先把uri地址和应用程序进行绑定的映射关系表，就是路由规则。
```

在使用Laravel开发项目的时候，路由是非常重要的。

```
Laravel提供了一个Route(路由操作类)供我们声明路由规则，我们只有声明了路由规则，用户才能够访问到我们创建的控制器或视图。

我们的路由规则，必须写在Routes/web.php或者api.php文件中，不过要注意，在Laravel5.2以前，路由规则统一写在app/Http/routes.php文件中。
如果写在api.php中的规则，则需要在域名后面跟着/api/才能访问。
```

Laravel提供的这个Route类提供了多不同的http请求，而设置的路由方法，这些方法都是用来接收不同的http请求方法的uri地址

```
常用的路由方法：
Route::get();		专门用来接收http的get请求，用于获取数据
Route::post();		专门用来接收http的post请求，用于添加数据
Route::put();		专门用来接收http的put请求，用于更新数据
Route::delete();	专门用来接收http的delete请求，用于删除数据
```

使用 csrf token 发送post表单数据，除了get方法之外，都需要token，代码如下：

![1538970888714](1538970888714.png)

效果如下：

![1538970902430](1538970902430.png)

可能会报以下错误：

![1538970800788](1538970800788.png)

```
csrf_field()与csrf_token()的区别：

csrf_field()帮我我们生成：
<input type="hidden" name="_token" value="193gaqa614a0mbFKbKsJt2zlsakhqz5XeFs2wI7G">

csrf_token()只是生成后来面的token值：193gaqa614a0mbFKbKsJt2zlsakhqz5XeFs2wI7G
```

使用表单方法伪造发送一些HTML表单不支持的http请求。例如：put或delete代码如下：

![1538980926650](1538980926650.png)

效果如下：

![1538980952746](1538980952746.png)

### 3、路由分两种

1. **匿名函数路由**，因为后面的参数是匿名函数而得名。

```
语法：Route::match($methosd, $uri, $callback)

参数说明：
	$methosd	请求类型，例如：post、get ['get', 'post']
	$uri		uri地址，例如：/admin/user
	$callback	匿名函数
```

代码如下：

![1538981328985](1538981328985.png)

效果如下：

![1538981338794](1538981338794.png)



2. **控制器路由**， 主要是因为后面的参数是一个字符串，表示对应控制器或控制器与方法。

```
语法：Route::get($uri, $string)

参数说明：
	$uri		uri地址，例如：/admin/user
	$string		[命名空间/]控制器/方法，例如："Admin\UserController@index"
```

控制器代码：

app/Http/Controllers/Admin/UserController.php

![1538981462330](1538981462330.png)

定义路由

![1538981515814](1538981515814.png)



### 4、match路由

match被称为"**匹配路由**"，用于限制当前路由只允许被指定的请求方式所访问。

```
语法：Route::match($methosd, $uri, $callback)

参数说明：
	$methosd	请求类型，例如：['post', 'get']
	$uri		uri地址，例如：/admin/user
	$callback	匿名函数
```

代码如下：

![1538981328985](1538981328985.png)

效果如下：

![1538981338794](1538981338794.png)

### 5、any路由

any被称为“**任意路由**”，运行当前uri地址可以通过任意一种http请求进行访问。

```
语法：Route::any($uri, $callback)

参数说明：
	$uri		uri地址，例如：/admin/user
	$callback	匿名函数
```

代码如下：

![1538981738964](1538981738964.png)

效果如下：

![1538981752700](1538981752700.png)



### 6、路由参数

有时候会在uri地址里面设置一些参数，用于传递给控制器方法。我们怎么接收这些参数呢？

接下来我们学习一下Laravel的路由参数。

Laravel路由参数有2种，分别为可选参数和必填参数。



#### 6.1 必填参数

路由的参数通常都会被放在 `{}` 内，并且参数名只能为字母，当运行路由时，参数会通过路由闭包来传递。 

```php
<?php
    //路由的必填参数
    //格式：{参数名称}
    Route::get('/user/{id}-{phone}', function($id, $phone){
        dump('参数是：'.$id);
        dump('参数是：'.$phone);
    })->where('id', '\d{2}')->where('phone', '\d{11}');
	//使用where方法可以对指定参数的值进行正则过滤
	//phone 和 $phone  要对应，即uri中的占位符和形参名称部分要对应。

//也可以根据需要在路由中这样定义多个参数
Route::get('posts/{post}/comments/{comment}', function ($postId, $commentId) {
    //
});
```

> **注意：** 路由参数不能包含 `-` 字符。请用下划线 (`_`) 替换。 

PHP代码如下：

![1538981984863](1538981984863.png)

效果：

![1538981998779](1538981998779.png)

我们可以通过where对参数的值进行正则过滤，如果正则过滤的时候匹配不上，则Route类会自动拿后面的路由和用户请求的uri地址进行匹配，如果都不成功，则报NOTFOUND，404找不到错误。

在Laravel中，路由的匹配都先写的先匹配，后写的后匹配。



#### 6.2 可选参数

路由的参数通常都会被放在 `{}` 内，并且参数名只能为字母，当运行路由时，参数会通过路由闭包来传递。 

声明路由参数时，如需指定该参数为可选，可以在参数后面加上 `?` 来实现，但是相应的变量必须有默认值： 

```php
<?php
    //路由的可选参数
    //格式：{参数名称?}
    //注意：写可选参数的时候，匿名函数或控制器方法中的对应的参数需要设置默认值为null
    Route::get('goods/{cata}/{gid?}', function($cata, $gid = null){
        dump($cata);
        dump($gid);
    })->where('cate', '\d+')->where('gid','\d+');
```

PHP代码

![1538982593572](1538982593572.png)

效果图：

![1538982607603](1538982607603.png)

> 注意：
> ​	在设置可选参数的时候，必须保证我们对应的控制器方法或匿名函数中对应的参数设置默认值为空，否则有可能报错。

### 7、路由群组

​	专门用来划分路由，让具有共同特征的路由划分在一起，以达到简写的效果，同时也可以对项目进行模块划分。

```
语法：Route::group($array, $callback)

路由群组提供了四种属性定义：
1. middleware(中间件、用于验证权限、登录状态等)
2. prefix(地址前缀)
3. namespace(命名空间)
4. domain(域名)
```

PHP代码：

![1538982983979](1538982983979.png)

代码如下：

```PHP
<?php
    //在Laravel中可以使用路由群组进行模块的划分
    //后台
    Route::group(['namespace'=>'Admin', 'prefix'=>'admin'], function(){
        Route::get('admin', 'IndexController@index');
        Route::get('left', 'IndexController@left');
    });

	//前台
    Route::group(['namespace'=>'Home'], function(){
        Route::get('user/login', 'UserController@index');
    });
```

----



##  九、==Laravel-视图==

在Laravel中视图文件都是保存在resources/views/目录下，而我们的页面静态资源都是保存在public目录下。

Laravel中的视图都是以"视图名称.blade.php"为文件名。



**Laravel框架中的模板有两种：**

**普通模板**：直接以"视图名称.php"为模板文件名，这种模板不支持使用Laravel内置的blade模板引擎的语法，只支持PHP原生语法，当然效率高点。

**blade模板**：直接以"视图名称.blade.php"为模板文件名，这种模板支持使用Laravel内置的blade模板引擎的语法。

> 注意：当视图目录中出现2套同名的模板时，优先加载的是blade模板。

### 1、控制器中载入模板

```PHP
语法： return view('视图目录/视图名称', ['name' => 'Values']);
```

### 2、普通模板

控制器代码如下所示：

```php
public function index(){
    return view('index')->with('title', '我是页面标题');
}
//with : 附带
```

控制器代码：

![1538984678628](1538984678628.png)

视图文件代码如下：

![1538984759142](1538984759142.png)

定义路由

![1538984842442](1538984842442.png)

效果：

![1538984906171](1538984906171.png)

### 3、balde模板

控制器代码如下所示：

![1538984278542](1538984278542.png)

视图代码如下所示：

![1538984383442](1538984383442.png)

路由地址如下所示：

![1538984508393](1538984508393.png)

效果如下所示：

> 注意：
>
> ​	Laravel框架的模板文件后缀必须是：*.blade.php；否则模板中的变量无法解析。



### 4、对模板进行赋值

在控制器中对模板进行赋值，有2种方式分别为：==with==、==view==函数第二个参数赋值



#### 4.1 使用with方法赋值

```
语法：view('视图名称')->with('变量名', '变量值')->with('变量名', '变量值')......
```

控制器代码如下所示：

![1538985072352](1538985072352.png)

```php
return view('index')->with('title', '我是页面标题');
```

视图代码如下所示：

![1538985164384](1538985164384.png)

```html
<h2>{{ $title }}</h2>
```

效果如下所示：

![1538985141779](1538985141779.png)



#### 4.2 使用view第二个参数赋值

```
语法：view('视图名称', $array);

参数说明：
	$array 数组，要赋值到视图中的数据，每个成员的下标在视图中就是变量名。
```

控制器代码如下所示：

![1538985625964](1538985625964.png)

视图代码如下所示：

![1538985669892](1538985669892.png)

效果如下：

![1538985679393](1538985679393.png)



### 5、视图分离

很多时候，项目的视图的头部、脚部、购物车弹窗、QQ客服、广告窗口一般都是多个页面共用，所以我们以往都是直接使用require或include来实现，后面学习ThinkPHP以后使用了layout布局，Laravel也有**视图分离技术**。




blade模板引擎里面提供了@include标签，专门给我们用于分离视图。
```
语法：	@include('目录.视图名称');
```
参数说明：
	视图地址，基于resources/views目录开始


#### 5.1、举例说明

PHP代码如下图所示：

![1539047790603](1539047790603.png)

视图代码如下图所示：

![1539047828864](1539047828864.png)

定义路由：

![1539047866533](1539047866533.png)

效果如下图所示：

![1539047879888](1539047879888.png)

#### 5.2、模板继承


在Laravel中，blade模板引擎提供了一种**模板继承**的视图分离技术，这种技术的原理其实本质上来说，就是把公共代码集中到一个公共的父级视图中，然后在页面的子视图中使用`@extends`标签，把公共父级视图的代码继承过来使用。
子视图可以通过`@yield`和`@section`-`@endsection`对父级视图中的指定区域进行修改。
我们继承了公共父级视图后，还可以在子视图中对父级视图的某部分进行修改或替换。


> 使用模板继承有以下标签使用：
>
> @yield('区块名称')
>
> ​	在父级视图中，声明允许子视图可以新增的区域
>
> @extends('目录.模板名称')
>
> ​	在子视图中声明要继承父级视图
>
> @section('区块名称')
>
> @endsection
>
> ​	在子视图中，对父级视图中的，同名的@yield区块进行新增

控制器代码

![1539048478637](1539048478637.png)

创建一个公共视图文件

![1539048520979](1539048520979.png)

视图

![1539048612324](1539048612324.png)



----



## 十、==blade(模板)语法==

### 1、直接输出变量数据

```PHP
语法： {{ 变量名 }}
```

### 2、输出HTML代码

在默认情况下，Blade 模板中的 `{{ }}` 表达式将会自动调用 PHP `htmlspecialchars` 函数来转义数据以避免 XSS 的攻击。如果你不想你的数据被转义，你可以使用下面的语法： 

```html
Hello, {!! $name !!}.
```

> 要非常小心处理用户输入的数据时，你应该总是使用 `{{ }}` 语法来转义内容中的任何的 HTML 元素，以避免 XSS 攻击。 



PHP代码如下图所示：

![1538986046069](1538986046069.png)

视图代码如下图所示：

![1538986007573](1538986007573.png)

结果如下图所示：

![1538985973558](1538985973558.png)

> 注意：
>
> ​	在Laravel的blade模板中，我们可以使用原生的PHP函数，也可以直接写PHP原生代码。



### 3、注释

```PHP
语法：{{-- 需要注释的内容 --}}
```

> 注意：
>
> ​	在Laravel的blade模板中对{{变量名}}内容不能直接使用HTML代码注释语法，否则还会自动解析

视图代码如下图所示：

![1538986495829](1538986495829.png)

效果如下图所示：

![1538986513020](1538986513020.png)

右键查看源码

![1538986540035](1538986540035.png)

### 4、循环语句

```PHP
语法：
    @foreach($data as $key => $value)
    	//循环体的内容
    @endforeach
```

举例说明：

PHP代码如下图所示：

![1538987011911](1538987011911.png)

视图代码如下图所示：

![1538987067448](1538987067448.png)

> 注意：
>
> ​	视图文件是需要自己手动创建

效果如下图所示：

![1538987076953](1538987076953.png)

### 5、判断语句

#### 5.1 单分支判断

```PHP
语法：
    @if(条件表达式)
    	//输出的内容
    @endif
```

举例说明：

视图代码如下图所示：

![1538988258948](1538988258948.png)

效果如下图所示：

![1538988273095](1538988273095.png)

#### 5.2 多分支判断

```PHP
语法：
    @if(条件表达式1)
    	//内容1
    @elseif(条件表达式2)
    	//内容2
    @elseif(条件表达式n)
    	//内容n
    @endif
```

举例说明：

PHP代码如下图所示：

![1538988326554](1538988326554.png)

视图代码如下图所示：

![1538988517615](1538988517615.png)

效果如下图所示：

![1538988528616](1538988528616.png)

### 6、原样输出

```PHP
语法：@{{ 变量名 }}
```

> 注意： 
>
> ​	在双大括号前面加上@符号，是告诉blade模板不做任何解析，直接输出该内容即可

视图代码如下图所示：

![1538988698887](1538988698887.png)

效果如下图所示：

![1538988717619](1538988717619.png)

### 7、默认值

```PHP
语法：{{ 变量名 or 默认内容 }}
```

> 注意：
>
> ​	默认值只对未定义的变量生效。

视图代码如下图所示：

![1538989148198](1538989148198.png)

效果如下图所示：

![1538989035490](1538989035490.png)