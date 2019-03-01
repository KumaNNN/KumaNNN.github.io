---
title: PHP函数
date: 2019-02-28 12:36:17
updated: 2019-02-28 12:36:17 
mathjax: false
categories: 
tags:
typora-root-url: imgs
typora-copy-images-to: imgs
top: 1
---


# 函数

## 什么是函数？

为了使用其个功能的代码段！

## 函数的主要目的

-   代码重用

-   模块化编程

## 函数的定义

```PHP
function 函数名([形参列表]){

函数体;

return;

}
```

结构说明：

**function** 是定义函数的关键字

函数名的命名规则、不区分大小写， 它的命名规则与变量一样。

## 函数的调用

`函数名();`

![](1536798148_image23.png)



## 函数的参数 

### 形式参数 Parameter

在定义函数的时候写的参数 我们称之为形式参数 简称"形参"。



### 实际参数 argument

在调用函数的时候传递的参数 我们称之为实际参数 简称"实参"。

![](1536798148_image24.png)





### 函数参数的传递方式

#### 按值传递

![](1536798148_image25.png)

#### 引用传递

记得在形参的前面加一个&求地址运算符

![](1536798148_image26.png)

![](1536798148_image27.png)

问：如果使用引用传递的时候 ，是否能够将实参使用具体的值而不是使用变量来传递

答：不行，只能变量才可以使用引用传递。

![](1536798148_image28.png)

![](1536798148_image29.png)



## 可变函数

一个函数的名恰好是一个变量的值

语法：

`变量名(); //就可以调用函数`

![](1536798148_image30.png)

进制转换的作业 就可以使用到可变函数来实现

![](1536798148_image31.png)



## 函数形参的类型限定

在PHP7.0以后,支持了标量类型数据限定。

-   标量有四种：字符串（string）、布尔值（bool）、整型（int）和浮点型（float）

语法：

```php
function function_name(类型限定 $val){

}
```

![](1536798148_image32.png)

上图所示的代码：需要的是整型数据， 但是传递不是整型数据 ，函数的内部进行了类型的自动转换功能。



## 函数形参数类型严格模式

开启类型严格模式语句：`declare(strict_types=1);`

![](1536798148_image33.png)



## 函数形参的默认值 

**参数为什么需要有默认值？**

假设一个函数它是用来实现的功能比较固定！

![](1536798148_image34.png)

![](1536798148_image35.png)



## 函数的参数的个数不定 

**指的形参与实参个数之间的关系！**

**实参：**在函数在运行中所传递的数据！

**形参：**函数在运行中所依赖的数据！

### 形参个数大于实参个数

会报错 "Fatal error"

### 形参个数等于实参个数

没有错

### 形参个数小于实参个数

没有错



func\_get\_args() ：获取函数实参的个数 返回是一个数组

![](1536798148_image36.png)

count(\$arr) 用于获取数组的长度



## 函数的返回值

**return 关键字 **

1、当函数体里面遇到return关键字会将当前的函数停止运行

![](1536798148_image37.png)

2、向函数的调用者返回数据！

![](1536798148_image38.png)

问题：如果调用一个没有返回值的函数 会得到?

![](1536798148_image39.png)



## 函数返回值的类型

类型严格模式对于返回值的类型限定同样起作用，使用类型严格模式的时候要注意，必须保证声明语句在最开始位置，否则报错！

格式：

```php
function 函数名():返回值的类型{

return 指定的类型

}
```

![](1536798148_image40.png)



----

# 二十五、匿名函数

一个函数没有名称 ，需要将这个函数赋值给一个变量！

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image1.png)



# 三十、字符串函数

## Strlen

```php
int strlen ( string $string )
```

返回的是指定字符串的字节的长度！

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image17.png)

## Substr

```php
string substr ( string $string , int $start [, int $length ] )
```

作用：截取字符串

string \$string：字符串变量

int \$start：开始下标

int \$length：可缺省的参数 表示截取的长度 如果不写表示截取到字符串的末尾 如果有些 表示截取到指定的长度

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image18.png)

## Strtolower

```php
string strtolower ( string $string )
```

将大写字母转换为小写

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image19.png)

## Strtoupper

```php
string strtoupper ( string $string )
```

将小写字母转换为大写

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image20.png)

## mb\_strlen

```php
mixed mb_strlen ( string $str [, string $encoding = mb_internal_encoding() ] )
```

作用：获取字符的个数！

如果要使用这个函数需要 在PHP.INI中开启下面的扩展 **php\_mbstring** 这个扩展

开启扩展

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image21.png)

告诉PHP去哪个目录下面找扩展文件

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image22.png)

重启Apache` httpd.exe -k restart`

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image23.png)

## Ucfirst

```php
string ucfirst ( string $str )
```

将字符串的首字母转换为大写

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image24.png)

## Strpos

```php
mixed strpos ( string $haystack , mixed $needle [, int $offset = 0 ] )
```

查找子字符在原字符串首次出来的位置， 如果找的到就返回其下标，如果找不到返回false

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image25.png)

## strrpos

```php
mixed strrpos ( string $haystack , string $needle [, int $offset = 0 ] )
```

查找子字符在原字符串最后次出来的位置， 如果找的到就返回其下标，如果找不到返回false

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image26.png)

## strrev

```php
string strrev ( string $string )
```

将字符串进行翻转

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image27.png)

## trim

```php
string trim ( string $str [, string $character_mask = " \t\n\r\0\x0B" ] )
```

用于去除字符串的首尾的空白字符

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image28.png)

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image29.png)

## explode

```php
array explode ( string $delimiter , string $string [, int $limit ] )
```

使用指定的分隔符将一个字符串分隔为数组

参数说明：

string \$delimiter：分隔符

string \$string：要分割字符串



**implode** 

```php
string implode ( string $glue , array $pieces )
```

参数说明：

string \$glue：拼接符号

array \$pieces：要拼接的数组

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image30.png)



# 三十一、时间日期函数

## date\_default\_timezone\_set

设置时区三种方法

* date\_default\_timezone\_set() 函数
* 修改 php.ini 配置文件
* 使用ini\_set() 这个函数

第一种方法： date\_default\_timezone\_set()

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image31.png)

第二种方法：修改php.ini配置文件

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image32.png)

第三种方法：使用ini\_set()函数， 修改php的配置文件配置

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image33.png)



## date\_default\_timezone\_get

获取到设置的时区

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image34.png)



## time

获取一个UNIX时间戳 是1970年1月1日0时0分0秒时间的秒数

`int time ( void )`

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image35.png)



## date

```php
string date ( string $format [, int $timestamp ] )
```

将一个时间戳格式化为一个本地的时间

第二个参数如果不写表示当前的时间戳

------

  **格式**   **说明**
  Y          4 位数字完整表示的年份
  m          数字表示的月份，有前导零 取值01\~12
  d          月份中的第几天，有前导零的 返回值：01\~31
  H          小时，24 小时格式，有前导零 返回值：01\~23
  i          有前导零的分钟数 00\~59
  s          秒数，有前导零 00\~59
  w          星期中的第几天，数字表示 *0*（表示星期天）到 *6*（表示星期六）
  N          星期中的第几天 数字表示 *1*（表示星期一）到 *7*（表示星期天）
  a          小写的上午和下午值 *am* 或 *pm*
  A          大写的上午和下午值 *AM* 或 *PM*

------

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image36.png)



## strtotime

将任何英文文本的日期时间描述解析为 Unix 时间戳

```php
int strtotime ( string $time [, int $now = time() ] )
```

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image37.png)



## microtime

返回当前 Unix 时间戳和微秒数

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image38.png)

这个函数有一个缺省的参数 ，这个参数是一个布尔型

如果将这个值设置为**true**返回是一个浮点数！时间戳和微秒数合起来的数

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image39.png)

如果没有指定参数 那么返回是两部分：时间戳和微秒。 这是一个字符串 ，将这个字符串以空格分割为数组

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image40.png)

# 三十二、数学函数

## abs

返回一个数的绝对值

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image41.png)

## sqrt

返回一个数的平方根

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image42.png)

## pow

pow(x,y) 返回一个x的y次幂

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image43.png)

## ceil

向上取整 得到一个比当前数要大的最小的整数

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image44.png)

## floor

向下取整 得到一个比当前数要大的最大的整数

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image45.png)

## round

对一个数进行四舍五入

第一个参数：表示一个数

第二个参数：可选的 如果没有写表示 不保留小数位 如果有写就表示保留几位小数

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image46.png)

## rand和mt\_rand

返回一个闭合区间的随机整数

rand和mt\_rand它们有两个参数

第一个参数：表示最小的整数

第二个参数：表示最大的整数

这两个函数之间的区别在于：mt\_rand的速度比rand的速度快4倍！

![](1536809939_image47.png)



----

# 二十七、变量的作用域

**变量的作用域：**表示变量在什么区域里面有效！

**变量的作用域分为两种：**==全局作用域==、==局部作用域==

凡是变量的作用域都是跟**函数**有关系！

在函数外面定义的变量称之**全局变量** 它的作用域是全局的

在函数里面定义的变量称之**局部变量** 它的作用域是局部的，也就是在当前的函数内起作用！

**注意：**

PHP中的变量的作用域是不叠加的！全局不能访问局部的，局部的也不能访问全局的！全局变量只能在全局访问内访问，局部量只能在函数内访问！，在函数内是不能访问函数外定义的变量的！

**在函数里面是无法访问函数外面定义的变量**

**在函数外面无法访问函数里面定义的变量**

**问：**在函数里面访问函数外面定义的变量！

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image5.png)

使用`$_GET`这个超全局变量 可以使用在函数内部访问函数外面定义的变量，但是`$_GET`它本身是用来获取get方式提交的数据！

在PHP中还有一种变量 称之**超全局变量** ，但是超全局变量不能人为的进行定义！只能使用PHP系统内置的！这里的超全局变量的作用域可以理解为与JS中的全局作用域一样！

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image6.png)

虽然说`$_GET`可以使用实现在函数里面也能够被访问， 但是它不是专业做这个的！

**注意：**

**只有超全局变量才可以在函数外面和函数里面能够访问！**

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image7.png)

 [\$GLOBALS](mk:@MSITStore:F:\手册\php_manual_zh.chm::/res/reserved.variables.globals.html)

`$GLOBALS`它就是专门实现将一个数据进行超全局化！超全局化以后在全局作用域与局部作用域都可以使用。

**注意：**

1)  \$GLOBALS这个超全局数组变量中的数组元素它是与全局变量一一对应！只要我们创建了一个全局变量 就是相当于往这个超全局数组变量中添加一个对应的数组元素！变量名就是数组元素的下标 ，变量的值就是这个数组元素的值！

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image8.png)

2)  反过来说， 只是我们往\$GLOBALS这个超全局数组中添加一个数组元素， 就相当于会创建一个同名的全局变量！

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image9.png)

![](../%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86/note/1536809939_image10.png)

**注意：**

全局变量与`$GLOBALS`这个超全局数组的对应的数组元素它们之间的关系是同生同死！

# 二十八、变量的生命周期

**变量生命周期：**指的当前这个变量什么时候诞生、什么时候消失！



变量什么时候诞生？

一个变量被定义的时候

变量什么时候消失：

1. 当变量被unset掉以后
2. 当当前的脚本程序运行结束！



我们这里讨论是**局部变量的生命周期！**



什么是局部变量？

是指在函数里面定义的变量



**问：**如何让局部变量的生命活的久一点！

使用静态变量可以让其活的久一点， 只要当前的PHP程序在运行 ，当前的静态局部变量那么就一直活着！

**如何定义一个静态变量：**

在PHP中有一个**static**关键字 ，可以用来定义一个静态的局部变量！

**用法：**

将**static**放置在局部变量的前面， 那么这个局部变量就会被定义为静态局部变量！

无限级分类 \-\-\--static关键字

![](1536809939_image11.png)