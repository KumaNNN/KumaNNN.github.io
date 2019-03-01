---
title: MYSQLI扩展
date: 2019-02-28 12:36:17
updated: 2019-02-28 12:36:17 
mathjax: false
categories: 
tags:
typora-root-url: MYSQLI扩展
typora-copy-images-to: MYSQLI扩展
top: 1
---



# MYSQLI扩展

## 1. MYSQLI的概念

### 为什么使用MYSQLI扩展

```sequence
note left of PHP: 通过MYSQLi进行操作
PHP-->MYSQL数据库（服务器）:建立连接和认证
MYSQL数据库（服务器）-->PHP:返回连接信息
note left of PHP: 通过MYSQLi进行操作
PHP-->MYSQL数据库（服务器）:执行各种MYSQL操作指令
MYSQL数据库（服务器）-->PHP:返回执行的结果
```

**==小结==**：PHP可以通过使用MYSQLI实现对MYSQL数据库进行操作。



### 什么是MYSQLI扩展

概念：MYSQLI扩展即PHP利用MYSQL提供的语言操作接口，==封装==出来的一系列操作MYSQL数据库的==函数==和操作类。 



## 2. ==MYSQLI扩展的使用==

MYSQLI是PHP中的一个==扩展==，扩展的意思即不是默认就自带支持的，而是需要通过额外引入才能使用的。



所以我们在使用之前，需要先将MYSQLI扩展引入进PHP。

### 引入MYSQLI扩展

> ==步骤==：
> 第一步，打开PHP的配置文件**php.ini**,去掉php_mysqli.dll前面的注释符号"；"
>
> ![1529720270909](9.png)
>
> 第二步，配置php.ini中的extension_dir配置项，
>
> ![1529720394115](10.png)
>
> 第三步，确认在extension_dir配置的目录中php_mysqli.dll文件是存在的，
>
> ![1529720462175](11.png)
>
> 第四步，重启apache，测试是否开启成功
>
> 重启apache成功
>
> ![1529720522702](12.png)
>
> 测试mysqli开启是否成功
>
> 在code1.php中构建phpinfo()函数，访问code1.php，查看到如下图所示的mysqli配置项，
>
> ![1529720610970](13.png)
>
> 如果看到上图，则说明mysqli开启配置成功。



### 回顾黑窗口对MYSQL数据表数据的基本操作

1. 执行连接数据库相关操作（连接数据库，选择数据库，设置字符集）；
2. 设置操作（包括：增删改操作）
3. 查询操作



### 使用MYSQLI实现连库基本操作

使用MYSQLI实现连库基本操作  相当于  打开黑窗口==连接数据库==，==选择默认的数据库==和==设置字符集==操作。



> 涉及的函数：
>
> **mysqli_connect**(数据库ip地址,  帐号,  密码,  默认选择的数据库)  
>
> **mysqli_set_charset**(mysqli连接,  字符集编码)
>
> **mysqli_select_db**(mysqli连接, 数据库名) 



**==操作需求1==**：使用MYSQLI实现连接数据库，选择默认的数据库为test，设置字符集为utf8操作。

**==解答==**：构建code2.php程序页面，代码如下

```php
<?php
#连接数据库和选择默认的数据库
$link = mysqli_connect('localhost', 'root', '123abc', 'test');
var_dump( $link ); echo '<hr/>';

#设置字符集操作
$re = mysqli_set_charset($link, 'utf8');
var_dump( $re ); 
```

输出操作的结果：

```mysql
####输出的操作结果为：
//下面这个object对象数据时$link的值，如果有这个输出，说明连接数据库和选择默认的数据库成功
object(mysqli)#1 (19) { ["affected_rows"]=> int(0) ["client_info"]=> string(79) "mysqlnd 5.0.12-dev - 20150407 - $Id: 38fea24f2847fa7519001be390c98ae0acafe387 $" ["client_version"]=> int(50012) ["connect_errno"]=> int(0) ["connect_error"]=> NULL ["errno"]=> int(0) ["error"]=> string(0) "" ["error_list"]=> array(0) { } ["field_count"]=> int(0) ["host_info"]=> string(20) "localhost via TCP/IP" ["info"]=> NULL ["insert_id"]=> int(0) ["server_info"]=> string(6) "5.5.24" ["server_version"]=> int(50524) ["stat"]=> string(131) "Uptime: 6444 Threads: 2 Questions: 14 Slow queries: 0 Opens: 33 Flush tables: 1 Open tables: 0 Queries per second avg: 0.002" ["sqlstate"]=> string(5) "00000" ["protocol_version"]=> int(10) ["thread_id"]=> int(15) ["warning_count"]=> int(0) }

//下面这个是设置字符集操作的结果
bool(true)//返回true说明设置字符集成功
```



**==操作需求2==**：在"操作需求1"的基础上，实现切换选择数据库为db1数据库操作。

**==解答==**：构建code3.php程序页面，代码如下

```php
<?php
#连接数据库和选择默认的数据库
$link = mysqli_connect('localhost', 'root', '123abc', 'test');
var_dump( $link ); echo '<hr/>';

#设置字符集操作
$re = mysqli_set_charset($link, 'utf8');
var_dump( $re ); echo '<hr/>';

#切换选择新的数据库db1
$re = mysqli_select_db($link, 'db1');
var_dump( $re ); 
```

输出操作的结果：

```mysql
####输出的操作结果为：
object(mysqli)#1 (19) { ["affected_rows"]=> int(0) ["client_info"]=> string(79) "mysqlnd 5.0.12-dev - 20150407 - $Id: 38fea24f2847fa7519001be390c98ae0acafe387 $" ["client_version"]=> int(50012) ["connect_errno"]=> int(0) ["connect_error"]=> NULL ["errno"]=> int(0) ["error"]=> string(0) "" ["error_list"]=> array(0) { } ["field_count"]=> int(0) ["host_info"]=> string(20) "localhost via TCP/IP" ["info"]=> NULL ["insert_id"]=> int(0) ["server_info"]=> string(6) "5.5.24" ["server_version"]=> int(50524) ["stat"]=> string(131) "Uptime: 6659 Threads: 2 Questions: 15 Slow queries: 0 Opens: 33 Flush tables: 1 Open tables: 0 Queries per second avg: 0.002" ["sqlstate"]=> string(5) "00000" ["protocol_version"]=> int(10) ["thread_id"]=> int(16) ["warning_count"]=> int(0) }
bool(true)
//下面这个为切换选择数据库的操作结果
bool(true)//返回true说明切换数据库操作成功
```

**==小结==**：

1. mysqli_connect函数可以实现连接数据库和选择默认的数据库操作；
2. mysqli_set_charset函数可以实现设置字符集操作；
3. mysqli_select_db函数可以实现切换选择新的数据库操作；



### 使用MYSQLI实现关闭数据库连接操作

使用MYSQLI实现关闭数据库操作  相当于  在黑窗口==退出数据库==操作。



> 涉及的函数：
>
> **mysqli_close**(mysqli连接) 



**==操作需求==**：使用MYSQLI实现关闭数据库操作。

**==解答==**：构建code4.php程序页面，代码如下

```php
<?php
#连接数据库和选择默认的数据库
$link = mysqli_connect('localhost', 'root', '123abc', 'test');
var_dump( $link ); echo '<hr/>';

#关闭数据库连接
$re = mysqli_close($link);
var_dump( $re ); echo '<hr/>';
var_dump( $link ); 
```

输出操作的结果：

```mysql
####输出的操作结果为：
//下面这个object对象数据时$link的值，如果有这个输出，说明连接数据库和选择默认的数据库成功
object(mysqli)#1 (19) { ["affected_rows"]=> int(0) ["client_info"]=> string(79) "mysqlnd 5.0.12-dev - 20150407 - $Id: 38fea24f2847fa7519001be390c98ae0acafe387 $" ["client_version"]=> int(50012) ["connect_errno"]=> int(0) ["connect_error"]=> NULL ["errno"]=> int(0) ["error"]=> string(0) "" ["error_list"]=> array(0) { } ["field_count"]=> int(0) ["host_info"]=> string(20) "localhost via TCP/IP" ["info"]=> NULL ["insert_id"]=> int(0) ["server_info"]=> string(6) "5.5.24" ["server_version"]=> int(50524) ["stat"]=> string(131) "Uptime: 6989 Threads: 2 Questions: 18 Slow queries: 0 Opens: 33 Flush tables: 1 Open tables: 0 Queries per second avg: 0.002" ["sqlstate"]=> string(5) "00000" ["protocol_version"]=> int(10) ["thread_id"]=> int(17) ["warning_count"]=> int(0) }

//下面这个是关闭数据库操作的返回值
bool(true)//返回true说明关闭数据库连接成功

//下面这个是关闭之后再次打印$link的结果，虽然object依然存在，但是里面的数据全部被清空为null值，说明确实被关闭了
Couldn't fetch mysqli in F:\home\class\day2\code\code4.php on line 10
object(mysqli)#1 (19) { ["affected_rows"]=> NULL ["client_info"]=> NULL ["client_version"]=> int(50012) ["connect_errno"]=> int(0) ["connect_error"]=> NULL ["errno"]=> NULL ["error"]=> NULL ["error_list"]=> NULL ["field_count"]=> NULL ["host_info"]=> NULL ["info"]=> NULL ["insert_id"]=> NULL ["server_info"]=> NULL ["server_version"]=> NULL ["stat"]=> NULL ["sqlstate"]=> NULL ["protocol_version"]=> NULL ["thread_id"]=> NULL ["warning_count"]=> NULL }
```

**==小结==**：

mysqli_close函数的作用就是用来关闭mysqli数据库连接的。



### 使用MYSQLI实现设置(增删改)操作

使用MYSQLI实现设置操作  相当于  在黑窗口实现对数据表数据==执行增、删、改SQL语句==操作。



> 涉及的函数：
>
> **mysqli_query**(mysqli连接,  sql语句)            对数据库执行一次查询



**==操作需求1==**：使用MYSQLI操作test数据库中的cz_user表，实现往数据表cz_user中新增一条数据的操作。

**==解答==**：构建code5.php程序页面，代码如下

```php
<?php
#连接数据库和选择默认的数据库
$link = mysqli_connect('localhost', 'root', '123abc', 'test');
var_dump( $link ); echo '<hr/>';

#设置字符集
mysqli_set_charset($link, 'utf8');

#新增操作
//构建新增数据的SQL语句
$sql = "insert into cz_user values (null, '李元霸', '112233')";//字符串里面不要加分号
//执行新增语句
$re = mysqli_query($link, $sql);
var_dump( $re ); 
```

输出的结果如下

```mysql
object(mysqli)#1 (19) { ["affected_rows"]=> int(0) ["client_info"]=> string(79) "mysqlnd 5.0.12-dev - 20150407 - $Id: 38fea24f2847fa7519001be390c98ae0acafe387 $" ["client_version"]=> int(50012) ["connect_errno"]=> int(0) ["connect_error"]=> NULL ["errno"]=> int(0) ["error"]=> string(0) "" ["error_list"]=> array(0) { } ["field_count"]=> int(0) ["host_info"]=> string(20) "localhost via TCP/IP" ["info"]=> NULL ["insert_id"]=> int(0) ["server_info"]=> string(6) "5.5.24" ["server_version"]=> int(50524) ["stat"]=> string(131) "Uptime: 8221 Threads: 2 Questions: 24 Slow queries: 0 Opens: 34 Flush tables: 1 Open tables: 1 Queries per second avg: 0.002" ["sqlstate"]=> string(5) "00000" ["protocol_version"]=> int(10) ["thread_id"]=> int(18) ["warning_count"]=> int(0) }
//下面这个是执行新增语句后的返回结果
bool(true)//返回true说明执行新增操作成功
```



**==操作需求2==**：使用MYSQLI操作test数据库中的cz_user表，实现修改id为4的数据pwd的值为"1234abcd"。

**==解答==**：构建code6.php程序页面，代码如下

```php
<?php
#连接数据库和选择默认的数据库
$link = mysqli_connect('localhost', 'root', '123abc', 'test');
var_dump( $link ); echo '<hr/>';

#设置字符集
mysqli_set_charset($link, 'utf8');

#新增操作
//构建修改数据的SQL语句
$sql = "update cz_user set pwd='1234abcd' where id=4";//字符串里面不要加分号
//执行修改语句
$re = mysqli_query($link, $sql);
var_dump( $re ); 
```

输出的结果如下

```mysql
object(mysqli)#1 (19) { ["affected_rows"]=> int(0) ["client_info"]=> string(79) "mysqlnd 5.0.12-dev - 20150407 - $Id: 38fea24f2847fa7519001be390c98ae0acafe387 $" ["client_version"]=> int(50012) ["connect_errno"]=> int(0) ["connect_error"]=> NULL ["errno"]=> int(0) ["error"]=> string(0) "" ["error_list"]=> array(0) { } ["field_count"]=> int(0) ["host_info"]=> string(20) "localhost via TCP/IP" ["info"]=> NULL ["insert_id"]=> int(0) ["server_info"]=> string(6) "5.5.24" ["server_version"]=> int(50524) ["stat"]=> string(131) "Uptime: 8358 Threads: 2 Questions: 28 Slow queries: 0 Opens: 34 Flush tables: 1 Open tables: 1 Queries per second avg: 0.003" ["sqlstate"]=> string(5) "00000" ["protocol_version"]=> int(10) ["thread_id"]=> int(19) ["warning_count"]=> int(0) }

//下面这个是执行修改语句后的返回结果
bool(true)//返回true说明执行修改操作成功

####数据表中的数据变化效果
更新前的数据：
mysql> select * from cz_user;
+----+----------+---------+
| id | name     | pwd     |
+----+----------+---------+
|  1 | zhangsan | 123abc  |
|  2 | lisi     | abcdefg |
|  3 | wangwu   | aaabbb  |
|  4 | zhaoliu  | aabb    |     <--------这条数据
|  5 | qinqi    | ccdd    |
|  6 | 李元霸        | 112233  |
+----+----------+---------+
6 rows in set (0.00 sec)
更新后的数据：
mysql> select * from cz_user;
+----+----------+----------+
| id | name     | pwd      |
+----+----------+----------+
|  1 | zhangsan | 123abc   |
|  2 | lisi     | abcdefg  |
|  3 | wangwu   | aaabbb   |
|  4 | zhaoliu  | 1234abcd |     <--------这条数据
|  5 | qinqi    | ccdd     |
|  6 | 李元霸        | 112233
+----+----------+----------+
6 rows in set (0.00 sec)
```



**==操作需求3==**：使用MYSQLI操作test数据库中的cz_user表，删除id为5的数据。

**==解答==**：构建code7.php程序页面，代码如下

```php
<?php
#连接数据库和选择默认的数据库
$link = mysqli_connect('localhost', 'root', '123abc', 'test');
var_dump( $link ); echo '<hr/>';

#设置字符集
mysqli_set_charset($link, 'utf8');

#新增操作
//构建删除数据的SQL语句
$sql = "delete from cz_user where id=5";//字符串里面不要加分号
//执行删除语句
$re = mysqli_query($link, $sql);
var_dump( $re ); 
```

输出的结果如下

```mysql
object(mysqli)#1 (19) { ["affected_rows"]=> int(0) ["client_info"]=> string(79) "mysqlnd 5.0.12-dev - 20150407 - $Id: 38fea24f2847fa7519001be390c98ae0acafe387 $" ["client_version"]=> int(50012) ["connect_errno"]=> int(0) ["connect_error"]=> NULL ["errno"]=> int(0) ["error"]=> string(0) "" ["error_list"]=> array(0) { } ["field_count"]=> int(0) ["host_info"]=> string(20) "localhost via TCP/IP" ["info"]=> NULL ["insert_id"]=> int(0) ["server_info"]=> string(6) "5.5.24" ["server_version"]=> int(50524) ["stat"]=> string(131) "Uptime: 8550 Threads: 2 Questions: 32 Slow queries: 0 Opens: 34 Flush tables: 1 Open tables: 1 Queries per second avg: 0.003" ["sqlstate"]=> string(5) "00000" ["protocol_version"]=> int(10) ["thread_id"]=> int(20) ["warning_count"]=> int(0) }

//下面这个是执行删除语句后的返回结果
bool(true)//返回true说明执行删除操作成功

####数据表中的数据变化效果
删除前的数据：
mysql> select * from cz_user;
+----+----------+----------+
| id | name     | pwd      |
+----+----------+----------+
|  1 | zhangsan | 123abc   |
|  2 | lisi     | abcdefg  |
|  3 | wangwu   | aaabbb   |
|  4 | zhaoliu  | 1234abcd |
|  5 | qinqi    | ccdd     |        <-------这条将会被删了
|  6 | 李元霸        | 112233   |
+----+----------+----------+
6 rows in set (0.00 sec)
删除后的数据：
mysql> select * from cz_user;
+----+----------+----------+
| id | name     | pwd      |
+----+----------+----------+
|  1 | zhangsan | 123abc   |
|  2 | lisi     | abcdefg  |
|  3 | wangwu   | aaabbb   |
|  4 | zhaoliu  | 1234abcd |
|  6 | 李元霸        | 112233   |
+----+----------+----------+
5 rows in set (0.00 sec)

```



**==小结==**：

mysqli_query函数可以实现增删改操作；



### 使用MYSQLI实现查询操作

使用MYSQLI实现查询操作  相当于  在黑窗口==执行查询SQL语句==操作。



> 涉及的函数：
>
> **mysqli_query**(mysqli连接,  sql语句)            对数据库执行一次查询
>
> **mysqli_fetch_assoc**(结果集)                         获取作为关联数组的结果行
>
> **mysqli_fetch_row**(结果集)				   获取作为索引数组的结果行	
>
> **mysqli_fetch_all**(结果集[, 数组形态])          获取作为关联（索引）数组的**所有**结果行
>
> ​					                           数组形态可指定**MYSQLI_ASSOC**、**MYSQLI_NUM**或**MYSQLI_BOTH**



**==操作需求1==**：使用MYSQLI操作test数据库中的cz_user表，查询id小于4的所有数据，要求得到的每条数据结果是一个关联数组。

**==解答==**：构建code8.php程序页面，代码如下

```php
<?php
#连接数据库和选择默认的数据库
$link = mysqli_connect('localhost', 'root', '123abc', 'test');

#设置字符集
mysqli_set_charset($link, 'utf8');

#查询操作
//构建并执行查询SQL语句
$sql = "select * from cz_user where id<4";
$result = mysqli_query($link, $sql);
var_dump( $result ); echo '<hr/>';

//解析返回的$result结果集中的数据
$row = mysqli_fetch_assoc($result);//第一次解析
var_dump( $row ); echo '<br/>';
$row = mysqli_fetch_assoc($result);//第二次解析
var_dump( $row ); echo '<br/>';
$row = mysqli_fetch_assoc($result);//第三次解析
var_dump( $row ); echo '<br/>';
$row = mysqli_fetch_assoc($result);
var_dump( $row ); echo '<br/>';
$row = mysqli_fetch_assoc($result);
var_dump( $row ); echo '<br/>';
```

执行程序后输出的结果

```mysql
####下面为输出的结果
//下面这个object是输出的$result的结果
object(mysqli_result)#2 (5) { ["current_field"]=> int(0) ["field_count"]=> int(3) ["lengths"]=> NULL ["num_rows"]=> int(3) ["type"]=> int(0) }

//下面这个是第一次使用mysqli_fetch_assoc函数解析后的结果，得到的是查询的所有数据中第一条数据的结果，是一个关联数组
array(3) { ["id"]=> string(1) "1" ["name"]=> string(8) "zhangsan" ["pwd"]=> string(6) "123abc" } 
//下面这个是第二次使用mysqli_fetch_assoc函数解析后的结果，得到的是查询的所有数据中第二条数据的结果，是一个关联数组
array(3) { ["id"]=> string(1) "2" ["name"]=> string(4) "lisi" ["pwd"]=> string(7) "abcdefg" } 
//下面这个是第三次使用mysqli_fetch_assoc函数解析后的结果，得到的是查询的所有数据中第三条数据的结果，是一个关联数组
array(3) { ["id"]=> string(1) "3" ["name"]=> string(6) "wangwu" ["pwd"]=> string(6) "aaabbb" } 
//下面这两个NULL值是逐条解析完成数据之后，再继续使用mysqli_fetch_assoc解析后的结果，说明已经无法继续获得数据了，因为前三次已经取完了数据
NULL 
NULL 


####下面为查询语句在黑窗口中执行后获得的数据
mysql> select * from cz_user where id<4;
+----+----------+---------+
| id | name     | pwd     |
+----+----------+---------+
|  1 | zhangsan | 123abc  |
|  2 | lisi     | abcdefg |
|  3 | wangwu   | aaabbb  |
+----+----------+---------+
3 rows in set (0.00 sec)
```



**==操作需求1小结==**：

1. mysqli_query也能执行查询语句，但是返回的是一个对象类型的查询结果集；

2. mysqli_fetch_assoc的特点：

   ​	a)每次执行只能解析得到一行数据；

   ​	b)每次得到的数据是一个关联类型的数组，数组元素的下标对应着数据的字段名，值对应着数据值；

   ​	c)当解析完成后，再次去执行将会只返回NULL值，说明数据已经再之前全部取完了；





**==操作需求2==**：使用MYSQLI操作test数据库中的cz_user表，查询id小于4的所有数据，要求得到的每条数据结果是一个索引数组。

**==解答==**：构建code9.php程序页面，代码如下

```php
<?php
#连接数据库和选择默认的数据库
$link = mysqli_connect('localhost', 'root', '123abc', 'test');

#设置字符集
mysqli_set_charset($link, 'utf8');

#查询操作
//构建并执行查询SQL语句
$sql = "select * from cz_user where id<4";
$result = mysqli_query($link, $sql);
var_dump( $result ); echo '<hr/>';

//解析返回的$result结果集中的数据
$row = mysqli_fetch_row($result);//第一次解析
var_dump( $row ); echo '<br/>';
$row = mysqli_fetch_row($result);//第二次解析
var_dump( $row ); echo '<br/>';
$row = mysqli_fetch_row($result);//第三次解析
var_dump( $row ); echo '<br/>';
$row = mysqli_fetch_row($result);
var_dump( $row ); echo '<br/>';
$row = mysqli_fetch_row($result);
var_dump( $row ); echo '<br/>';
```

执行程序后输出的结果

```mysql
####下面为输出的结果
//下面这个object是输出的$result的结果
object(mysqli_result)#2 (5) { ["current_field"]=> int(0) ["field_count"]=> int(3) ["lengths"]=> NULL ["num_rows"]=> int(3) ["type"]=> int(0) }

//下面这个是第一次使用mysqli_fetch_row函数解析后的结果，得到的是查询的所有数据中第一条数据的结果，是一个索引数组
array(3) { [0]=> string(1) "1" [1]=> string(8) "zhangsan" [2]=> string(6) "123abc" } 
//下面这个是第二次使用mysqli_fetch_row函数解析后的结果，得到的是查询的所有数据中第二条数据的结果，是一个索引数组
array(3) { [0]=> string(1) "2" [1]=> string(4) "lisi" [2]=> string(7) "abcdefg" } 
//下面这个是第三次使用mysqli_fetch_row函数解析后的结果，得到的是查询的所有数据中第三条数据的结果，是一个索引数组
array(3) { [0]=> string(1) "3" [1]=> string(6) "wangwu" [2]=> string(6) "aaabbb" } 

//下面这两个NULL值是逐条解析完成数据之后，再继续使用mysqli_fetch_row解析后的结果，说明已经无法继续获得数据了，因为前三次已经取完了数据
NULL 
NULL 


####下面为查询语句在黑窗口中执行后获得的数据
mysql> select * from cz_user where id<4;
+----+----------+---------+
| id | name     | pwd     |
+----+----------+---------+
|  1 | zhangsan | 123abc  |
|  2 | lisi     | abcdefg |
|  3 | wangwu   | aaabbb  |
+----+----------+---------+
3 rows in set (0.00 sec)
```



**==操作需求2小结==**：

mysqli_fetch_row函数在特性上和mysqli_fetch_assoc函数一模一样，只有一个区别，mysqli_fetch_row解析后返回的数据结果是一个**索引数组**类型的数据。



**==操作需求3==**：

1. 使用MYSQLI操作test数据库中的cz_user表，查询id小于3的所有数据
2. 要求一次性得到所有数据的结果；
3. 数据结果分别要求输出关联数组数据一份，索引数组数据一份，同时包含关联和索引数组元素的数组一份；

**==解答==**：构建code10.php程序页面，代码如下

```php
<?php
#连接数据库和选择默认的数据库
$link = mysqli_connect('localhost', 'root', '123abc', 'test');

#设置字符集
mysqli_set_charset($link, 'utf8');

echo '<pre>';
#查询操作
//构建并执行查询SQL语句
$sql = "select * from cz_user where id<3";
$result = mysqli_query($link, $sql);
var_dump( $result ); echo '<hr/>';

//解析返回的$result结果集中的数据
$row = mysqli_fetch_all($result, MYSQLI_NUM);
echo '索引类型的数据：<br/>'; 
var_dump( $row ); echo '<hr/>';
//$row = mysqli_fetch_all($result, MYSQLI_ASSOC);
//echo '关联类型的数据：<br/>'; 
//var_dump( $row ); echo '<hr/>';
//$row = mysqli_fetch_all($result, MYSQLI_BOTH);
//echo '即包含关联类型又包含索引类型的数据：<br/>'; 
//var_dump( $row ); echo '<hr/>';
```

访问程序code10.php后输出的结果：

```mysql
##下面这个为$reuslt的输出的数据
object(mysqli_result)#2 (5) {
  ["current_field"]=>
  int(0)
  ["field_count"]=>
  int(3)
  ["lengths"]=>
  NULL
  ["num_rows"]=>
  int(2)
  ["type"]=>
  int(0)
}

索引类型的数据：
##下面这个为mysqli_fetch_all指定第二个参数为MYSQLI_NUM之后的结果
array(2) {
  [0]=>
  array(3) {
    [0]=>
    string(1) "1"
    [1]=>
    string(8) "zhangsan"
    [2]=>
    string(6) "123abc"
  }
  [1]=>
  array(3) {
    [0]=>
    string(1) "2"
    [1]=>
    string(4) "lisi"
    [2]=>
    string(7) "abcdefg"
  }
}


//关联类型的数据：
##下面这个为mysqli_fetch_all指定第二个参数为MYSQLI_ASSOC之后的结果
//array(2) {
//  [0]=>
//  array(3) {
//    ["id"]=>
//    string(1) "1"
//    ["name"]=>
//    string(8) "zhangsan"
//    ["pwd"]=>
//    string(6) "123abc"
//  }
//  [1]=>
//  array(3) {
//    ["id"]=>
//    string(1) "2"
//    ["name"]=>
//    string(4) "lisi"
//    ["pwd"]=>
//    string(7) "abcdefg"
//  }
//}


//即包含关联类型又包含索引类型的数据：
##下面这个为mysqli_fetch_all指定第二个参数为MYSQLI_BOTH之后的结果,即包含索引类型的数据又包含关联类型的数据
//array(2) {
//  [0]=>
//  array(6) {
//    [0]=>
//    string(1) "1"
//    ["id"]=>
//    string(1) "1"
//    [1]=>
//    string(8) "zhangsan"
//    ["name"]=>
//    string(8) "zhangsan"
//    [2]=>
//    string(6) "123abc"
//    ["pwd"]=>
//    string(6) "123abc"
//  }
//  [1]=>
//  array(6) {
//    [0]=>
//    string(1) "2"
//    ["id"]=>
//    string(1) "2"
//    [1]=>
//    string(4) "lisi"
//    ["name"]=>
//    string(4) "lisi"
//    [2]=>
//    string(7) "abcdefg"
//    ["pwd"]=>
//    string(7) "abcdefg"
//  }
//}
```

**==操作需求3小结==**：

1. mysqli_fetch_all函数能够一次性解析出**所有**查询的结果；

2. mysqli_fetch_all函数还可以指定第二个参数，第二个参数可以是

   **MYSQLI_ASSOC**     返回关联类型的数组数据

   **MYSQLI_NUM**       返回索引类型的数组数据

   **MYSQLI_BOTH**      返回即包含关联类型的又包含索引类型的数组数据

   如果不指定第二个参数，==默认就是MYSQLI_NUM==这个值



### MYSQLI扩展中辅助操作函数



> 涉及的函数：
>
> **mysqli_field_count**(mysqli连接)	返回最近一次查询语句查询数据中的总列数
>
> **mysqli_num_fields**(结果集)	获得查询的结果集中字段的个数
>
> **mysqli_num_rows**(结果集)	获得查询结果集中记录的总行数
>
> **mysqli_errno**(mysqli连接)		获得错误的错误码值
>
> **mysqli_error**(mysqli连接)		获得错误的错误码值对应的错误信息
>
> **mysqli_insert_id**(mysqli连接) 		获得最近一次新增数据的主键id值



**==操作需求1==**：

1. 使用MYSQLI操作test数据库中的cz_user表，执行两次查询操作；
2. 第一次查询所有数据，但是限制最终只获得2条数据；
3. 第二次查询所有数据，但是限制最终只获得3条数据；
4. 打印出最近一次查询语句查询数据中的总列数；
5. 打印第一次查询结果中的总列数；
6. 打印第一次查询结果集中数据的总行数；

**==解答==**：构建code11.php程序页面，代码如下

```php
<?php
#连接数据库和选择默认的数据库
$link = mysqli_connect('localhost', 'root', '123abc', 'test');

#设置字符集
mysqli_set_charset($link, 'utf8');

#查询操作
//执行第一次查询操作
$sql = "select * from cz_user where 1 limit 2";
$result = mysqli_query($link, $sql);

//执行第二次查询操作
$sql = "select * from cz_user where 1 limit 3";
$result1 = mysqli_query($link,$sql);

//返回最近一次查询语句查询数据中的总列数
$cols = mysqli_field_count($link);
echo '最近一次查得数据的总列数: ';
var_dump( $cols ); echo '<hr/>';

//返回指定的第一次查询语句查询数据中的总列数
$cols1 = mysqli_num_fields($result);
echo '指定的第一次查得数据的总列数: ';
var_dump( $cols1 ); echo '<hr/>';

//返回指定的第一次查询语句查询数据中的总行数
$rows = mysqli_num_rows($result);
echo '指定的第一次查得数据的总行数: ';
var_dump( $rows ); 
```

访问code11.php后输出的结果：

```mysql
##输出的结果为
最近一次查得数据的总列数: int(3)
指定的第一次查得数据的总列数: int(3)
指定的第一次查得数据的总行数: int(2)

##cz_user表中的所有数据
mysql> select * from cz_user;
+----+----------+----------+
| id | name     | pwd      |
+----+----------+----------+
|  1 | zhangsan | 123abc   |
|  2 | lisi     | abcdefg  |
|  3 | wangwu   | aaabbb   |
|  4 | zhaoliu  | 1234abcd |
|  6 | 李元霸        | 112233   |
+----+----------+----------+
5 rows in set (0.00 sec)
```



**==操作需求1小结==**：

mysqli_field_count函数可以获得最近一次查询结果中的总列数（没得选）；

mysqli_num_fields函数可以获得指定的某次查询结果中的总列数（有得选）；

mysqli_num_rows函数可以获得指定的某次查询结果中的总行数；



**==操作需求2==**：

1. 使用MYSQLI执行连库操作，要求要连库成功；同时执行设置字符集操作，要求设置的字符集为"utf8888"，使得设置字符集操作失败；
2. 打印出MYSQLI操作失败的错误信息；
3. 打印出MYSQLI操作失败错误信息对应的错误码值；

**==解答==**：构建code12.php程序页面，代码如下

```php
<?php
#连接数据库和选择默认的数据库
$link = mysqli_connect('localhost', 'root', '123abc', 'test');

#设置字符集
$re = mysqli_set_charset($link, 'utf8888');
echo '设置字符集的返回值结果: '; 
var_dump( $re ); echo '<hr/>';

//返回出错的错误信息原因
$errMsg = mysqli_error($link);
echo '错误的原因：'; 
var_dump( $errMsg ); echo '<hr/>';

//返回出错的信息对应的错误码值
$errCode = mysqli_errno($link);
echo '错误码值：'; 
var_dump( $errCode ); 
```

访问code12.php输出的信息为：

```mysql
设置字符集的返回值结果: bool(false)
错误的原因：string(51) "Invalid characterset or character set not supported"
错误码值：int(2019)
```



**==操作需求2小结==**：

1. mysqli_errno函数可以实现在出现操作错误时返回错误信息对应的错误码值；
2. mysqli_error函数可以实现在出现操作错误时返回错误信息；



**==操作需求3==**：

1. 使用MYSQLI操作test数据库中的cz_user表，向数据表中新增一条数据；
2. 打印出最近一次新增数据时的主键id；

**==解答==**：构建code13.php程序页面，代码如下

```php
<?php
#连接数据库和选择默认的数据库
$link = mysqli_connect('localhost', 'root', '123abc', 'test');

#设置字符集
mysqli_set_charset($link, 'utf8');

#新增数据操作
$sql = "insert into cz_user values (null, '赵子龙', '1122')";
mysqli_query($link, $sql);

//返回最近一次新增数据的主键id值
$priId = mysqli_insert_id($link);
echo '最近一次新增数据的主键id值:'; 
var_dump( $priId ); 


```

访问code13.php输出的结果

```mysql
最近一次新增数据的主键id值:int(7)

##执行之前数据表的数据
mysql> select * from cz_user;
+----+----------+----------+
| id | name     | pwd      |
+----+----------+----------+
|  1 | zhangsan | 123abc   |
|  2 | lisi     | abcdefg  |
|  3 | wangwu   | aaabbb   |
|  4 | zhaoliu  | 1234abcd |
|  6 | 李元霸        | 112233   |
+----+----------+----------+
5 rows in set (0.00 sec)

##执行之后数据表的数据
mysql> select * from cz_user;
+----+----------+----------+
| id | name     | pwd      |
+----+----------+----------+
|  1 | zhangsan | 123abc   |
|  2 | lisi     | abcdefg  |
|  3 | wangwu   | aaabbb   |
|  4 | zhaoliu  | 1234abcd |
|  6 | 李元霸        | 112233   |
|  7 | 赵子龙         | 1122     |    <---------这条数据是新增成功的
+----+----------+----------+
6 rows in set (0.00 sec)
```



**==操作需求3小结==**：

mysqli_insert_id函数可以实现返回最近一次新增操作后数据的主键id值。



## 3. 全天总结

1. 连库基本操作函数

   mysqli_connect函数     连库和选择默认数据库的

   mysqli_set_charset函数    设置字符集的

   mysqli_select_db函数    切换选择新的数据库的

2. 执行增删改操作的函数

   mysqli_query函数    执行增删改SQL语句的，成功返回true,失败返回false

3. 执行查询操作的函数

   mysqli_query函数   执行查询SQL语句的，返回的是一个对象的结果集

   mysqli_fetch_assoc函数   解析结果集得到一条数据记录的，获得的数据是一个关联类型的数组

   mysqli_fetch_row函数   解析结果集得到一条数据记录的，获得的数据是一个索引类型的数组

   mysqli_fetch_all函数   解析结果集得到所有数据记录的，可以指定第二个参数，第二个参数可以是

   MYSQLI_NUM  返回索引数据数组  （默认的）

   MYSQLI_ASSOC  返回关联数据数组

   MYSQLI_BOTH  返回的数据即包含关联类型的数据，也包含索引类型的数据




