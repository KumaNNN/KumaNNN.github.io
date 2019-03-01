---
title: PHP数组基础
date: 2019-02-28 12:36:17
updated: 2019-02-28 12:36:17 
mathjax: false
categories: 
tags:
typora-root-url: imgs
typora-copy-images-to: imgs
top: 1
---


# 一、数组基础

数组是一种复合类型的数据。它主要是用来存储多个数据！在PHP中的数组元素的数据类型可以是任意数据类型！

### 数组的组成

数组它是由一个一个的元素（element）来组成！

每一个数组元素它又分为两个部分来组成！元素是由下标和值组成

元素的下标称之**key**(键) 键名

元素的值称之为**value**(值)

所以我们一般将其称这为"key/value 键值对"



### 数组的分类

在PHP中数组分为"索引数组和关联数组"

如何去区分索引数组和关联数组是通过数组的下标来进行区分。

**索引数组的下标是数值**

![](1536847127_image1.png)

**关联数组的下标是字符串 **

因为下标与值之间是有关系的，这一种就称之为关联数组！

![](1536847127_image2.png)

![](1536847127_image3.png)



### 创建数组

**显式的创建**

使用array()这个函数来创建

![](1536847127_image4.png)

**隐式的创建**

使用`[ ]`来创建

1.  在创建的时候指定对应的下标值

![](1536847127_image5.png)

2.  在创建的时候不指定对应的下标

![](1536847127_image6.png)

**使用数组的方式来实现斐波那契数列**

![](1536847127_image7.png)



### 多维数组

PHP本身是没有多维数组的概念 ，因为数组元素的数据类型是任意的 ，如果一个数组元素的类型它还是一个数组 那么这种数组我们就称之为多维数组。

![](1536847127_image8.png)



### 访问数组元素

**使用下标来进行访问！**

格式：

```php
数组变量名[下标]
```

举例：

-   索引数组：数组变量名\[索引下标\]

-   关联数组：数组变量名\['字符下标'\]

![](1536847127_image9.png)

**使用二维数组来打印杨辉三角**

**//每一层的个数与当前层数相同 **

**//每一层的第一个数与最后一个数都为1 **

**//当前层数的第n列的数它等于当前层数-1的n-1列与当前层数-1的n列**

![](1536847127_image10.png)



# 二、数组的遍历

## 使用foreach遍历数组

遍历：依次访问数组的每一个元素！

第一种格式：

![](1536847127_image11.png)

**键名与值是两个变量 这个变量可以随意定义 它就表示当前数组的key与value**

![](1536847127_image12.png)

有些时候key对于我们来没有太大的用处 我们就将其省略不写！

第二种方式：

![](1536847127_image13.png)

![](1536847127_image14.png)

## 使用for循环来遍历索引数组

![](1536847127_image15.png)



# 三、数组的指针

每一个数组元素上面都对应一个指针。如果我们第一次使用指针的方式来访问数组。那么数组的指针会指向当前元素。

## key

获取到当前数组指针指向的元素的键名(下标)

![](1536847127_image16.png)

## current

获取到当前数组指针指向的元素的值

![](1536847127_image17.png)

## next

将数组的指针向下移一位

返回数组内部指针指向的下一个单元的值，或返回 false。 当数组的指针已经移出去了就会返回false!

## reset

将数组中的指针进行重置

## prev

将数组的指针向上移一位

## end

将数组的指针移动到最后一位

![](1536847127_image18.png)

**思考一下：**我们能不能使用数组的指针加上for循环对关联数组进行遍历！

![](1536847127_image19.png)

# 四、使用while\--list\-\-each来遍历数组 

## each

each函数它集合了key，current，next这三个函数的功能！这个each它返回的是一个数组！

这个数组里面的元素共4个。有两个元素分别是索引下标，有两个元素分别是字符下标！

**其中索引下标：**下标为0的表示原数组的中的key值，下标为1的表示原数组中value值

**其中字符下标：**下标为key的表示原数组的中的key值，下标为value的表示原数组中value值

![](1536847127_image20.png)

如果我们要访问each这个函数的访问数组中的数组元素：

访问到原数组的key值：\$each\[0\]或者\$each\['key'\]

访问到原数组的value值：\$each\[1\]或者\$each\['value'\]

![](1536847127_image21.png)

**接下来我们要使用while+each来遍历数组 **

![](1536847127_image22.png)

## list

**作用**：将一个索引数组下标为0的元素赋值给list这个函数中第一个参数，下标为1的赋值给list函数中的第二个参数.......依次类推！

使用while+list+each来遍历数组！

![](1536847127_image23.png)



# 五、数组相关函数

## count

获取数组的长度 数组中元素的总个数

```php
int count (mixed $var [, int $mode = COUNT_NORMAL ] )
```

mixed \$var：数组变量名

第二个参数：如果这个参数的值为true ，表示支持递归统计。

![](1536847127_image24.png)

## range

建立一个包含指定范围单元的数组

```php
array range ( mixed $start , mixed $limit [, number $step = 1 ] )
```

第一个参数：开始的位置

第二个参数：结束的位置

第三个参数：表示步长值

![](1536847127_image25.png)

## array\_merge

```php
array array_merge ( array $array1 [, array $... ] )
```

将一个或多个数组的单元合并起来，一个数组中的值附加在前一个数组的后面。返回作为结果的数组。

**合并数组时：**

-   如果是索引下标的数组：如果下标重复 重新给其进行定义下标

![](1536847127_image26.png)

-   如果是字符下标的数组：如果下标重复 后面的数组会将前面的数组覆盖

![](1536847127_image27.png)

## array\_rand

从数组中取出一个或多个随机的数组元素的key 返回一个新的索引数组

```php
mixed array_rand ( array $input [, int $num_req = 1 ] )
```

第一个参数：数组名

第二个参数：缺省值为1 表示从原数组中取出多少个元素

![](1536847127_image28.png)

## shuffle

将原数组打乱

```php
bool shuffle ( array &$array )
```

![](1536847127_image29.png)

## array\_flip

将数组中的键与值交换

![](1536847127_image30.png)

**验证码**：

![](1536847127_image31.png)

## in\_array

```php
bool in_array ( mixed $needle , array $haystack [, bool $strict = FALSE ] )
```

第一个参数 mixed \$needle ：要查找的元素

第二个参数：在那一个数组中查找

返回bool

判断数组中是否存在指定的元素！如果有返回true，如果没有返回false

![](1536847127_image32.png)

## array\_keys

将这个数组中的键名获取到 返回一个新的索引数组

```php
array array_keys ( array $array [, mixed $search_value [, bool $strict = false ]] )
```

![](1536847127_image33.png)

## array\_values

```php
array array_values ( array $input )
```

返回原数组中所有的值并给其建立索引数组。

![](1536847127_image34.png)

## array\_key\_exists

判断数组中是否存在指定的键名 如果有就返回true 如果没有就返回false

```php
bool array_key_exists ( mixed $key , array $search )
```

mixed \$key：查找的键名

array \$search：要在哪个数组中进行查找

![](1536847127_image35.png)

## implode

它有一个别名函数：join()

将一个数组的中元素连接为一个字符串

```php
string implode ( string $glue , array $pieces )
```

string \$glue：这个参数表示是指定的连接符号

array \$pieces：将指定的数组进行连接

## explode

将一个字符串分割为一个数组

```php
array explode ( string $delimiter , string $string [, int $limit ] )
```

参数说明：

string \$delimiter：指定的分隔符

string \$string：指定的字符串

![](1536847127_image36.png)

## max

```php
mixed max ( array $values )
```

返回当前数组中的最大值

## min

```php
mixed min ( array $values )
```

返回当前数组中的最小值

![](1536847127_image37.png)





# 七、数组的排序函数

## sort

对数组元素进行升序 重新生成了一个新的数组！这个数组的键名与值是重新进行排列！

![](1536847127_image39.png)

## asort

也是对数组元素进行升序排序 但是保留了原数组的下标与值之间的关系！

![](1536847127_image40.png)

## rsort

对数组进行降序排序

重新生成了一个新的数组！这个数组的键名与值是重新进行排列！

![](1536847127_image41.png)

## arsort

也是对数组元素进行降序排序 但是保留了原数组的下标与值之间的关系！

![](1536847127_image42.png)



