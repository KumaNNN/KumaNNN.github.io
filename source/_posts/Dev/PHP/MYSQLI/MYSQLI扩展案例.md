---
title: MYSQLI扩展案例
date: 2019-02-28 12:36:17
updated: 2019-02-28 12:36:17 
mathjax: false
categories: 
tags:
typora-root-url: MYSQLI扩展案例
typora-copy-images-to: MYSQLI扩展案例
top: 1
---



# MYSQLI扩展



## 案例：MYSQLI实现后台新闻管理系统

### 预览效果

> ==列表页==：
>
> ![1529708158948](6.png)
>
> ==添加新闻页==：
>
> ![1529708158948](7.png)
>
> ==编辑新闻页==：
>
> ![1529708158948](8.png)



### 功能分析

1. 新闻列表页；
2. 新闻添加页和添加功能；
3. 新闻编辑页和编辑功能；
4. 删除功能；
5. 分页功能；



### 建表

创建一个新闻表，表字段的要求如下：

```mysql
##建表字段要求：
##要求数据库为test数据库
新闻表
news
id,标题,简介,内容,添加时间
id,title,intro,content,post_date

##建表语句：
create table news(
id int unsigned primary key auto_increment,
title varchar(50) not null default '' comment '新闻标题',
intro varchar(255) not null default '' comment '新闻简介',
content text comment '新闻内容',
post_date int unsigned not null default 0 comment '添加时间'
)engine=MyISAM charset=utf8;

insert into news values
(null, '新闻1', '简介1', '内容1', 12345678),
(null, '新闻2', '简介22', '内容2', 12345678),
(null, '新闻3', '简介3', '内容3', 12345678);
```



### 实现列表页

**==步骤==**：

第一步，构建一个名为common.php的文件，

```php
<?php 

#连库基本操作
$link = mysqli_connect('localhost', 'root', '123abc', 'test');
mysqli_set_charset($link, 'utf8');
```

第二步，构建一个名为list.php文件，代码如下

```php+HTML
<?php 

//引入公共操作文件
include './common.php';

#执行查询语句查询数据表的数据
$sql = "select id, title, intro, post_date from news where 1 order by post_date desc";
$result = mysqli_query($link, $sql);

//解析出所有的数据
$rows = mysqli_fetch_all($result, MYSQLI_ASSOC);

?>
<!DOCTYPE html>
<HTML>
<head>
    <meta charset="UTF-8">
    <title>后台新闻列表页</title>
</head>
<body>

    <p>
        <a href="http://www.home.com/class/day2/code/ad.php">添加新闻</a>
    </p>

    <table border="1px">
        <thead>
            <tr>
                <td>序号</td>
                <td>ID</td>
                <td>新闻标题</td>
                <td>新闻简介</td>
                <td>添加时间</td>
                <td>操作</td>
            </tr>
        </thead>
        <tbody>
            <?php foreach( $rows as $rows_key=>$row ){ ?>
            <tr>
                <td><?php echo $rows_key+1; ?></td>
                <td><?php echo $row['id']; ?></td>
                <td><?php echo $row['title']; ?></td>
                <td><?php echo $row['intro']; ?></td>
                <td><?php echo date('Y-m-d H:i:s', $row['post_date']); ?></td>
                <td>
                    <a href="http://www.home.com/class/day2/code/upd.php?id=<?php echo $row['id']; ?>">编辑新闻</a> 
                    <a href="http://www.home.com/class/day2/code/del.php?id=<?php echo $row['id']; ?>">删除新闻</a>
                </td>
            </tr>
            <?php } ?>
        </tbody>
    </table>

    <p>
        <a href="">上一页</a>
        ...
        <a href="">1</a>
        <a href="">2</a>
        <a href="" style="color:red;">3</a>
        <a href="">4</a>
        <a href="">5</a>
        ...
        <a href="">下一页</a>
    </p>

</body>
</HTML>
```

第三步，访问list.php页面，效果如下

![1529740801125](14.png)

### 实现添加页面和功能

**==步骤==**：

第一步，构建名为ad.php的文件，代码如下，

```html
<!DOCTYPE html>
<HTML>
<head>
    <meta charset="UTF-8">
    <title>新闻添加页</title>
</head>
<body>
    <form method="post" action="http://www.home.com/class/day2/code/adh.php">
        <p>
            <span>新闻标题：</span>
            <input type="text" name="title" />
        </p>
        <p>
            <span>新闻简介：</span>
            <input type="text" name="intro" />
        </p>
        <p>
            <span>新闻内容：</span>
            <textarea name="content" cols=40 rows=7></textarea>
        </p>
        <p>
            <input type="submit" value="添加新闻" />
        </p>
    </form>

    <p>
        <a href="http://www.home.com/class/day2/code/list.php">返回新闻列表页</a>
    </p>
</body>
</HTML>
```

第二步，构建名为adh.php的程序页面，代码如下

```php
<?php

#接收数据
$title = $_POST['title'];//接收新闻标题
$intro = $_POST['intro'];//接收新闻简介
$content = $_POST['content'];//接收新闻内容
$post_date = time();//直接获取当前时间的时间戳

#引入公共操作文件
include './common.php';

#构建新增语句，新增数据
$sql = "insert into news values (null, '{$title}', '{$intro}', '{$content}', {$post_date})";
$re = mysqli_query($link, $sql);

if( $re ){//表示执行成功
    echo '恭喜添加新闻成功！'; 
}else{//表示执行失败
    echo '添加新闻失败，请联系管理员！'; 
}

//    2表示在本页面停留2秒       url是表示2秒后需要跳转到的页面链接地址
header('Refresh:2; url=http://www.home.com/class/day2/code/list.php');
```



### 实现修改页面和功能

**==步骤==**：

第一步，构建名为upd.php的程序页面，代码如下：

```php+HTML
<?php 
#接收GET传递的新闻id值
$id = $_GET['id'];

#引入公共文件
include './common.php';

#查询需要回显的本条数据
$sql = "select title, intro, content from news where id={$id}";
$result = mysqli_query($link, $sql);

//解析数据结果
$row = mysqli_fetch_assoc($result);

?>
<!DOCTYPE html>
<HTML>
<head>
    <meta charset="UTF-8">
    <title>新闻添加页</title>
</head>
<body>
    <form method="post" action="http://www.home.com/class/day2/code/updh.php?id=<?php echo $id; ?>">
        <p>
            <span>新闻标题：</span>
            <input type="text" name="title" value="<?php echo $row['title']; ?>" />
        </p>
        <p>
            <span>新闻简介：</span>
            <input type="text" name="intro" value="<?php echo $row['intro']; ?>" />
        </p>
        <p>
            <span>新闻内容：</span>
            <textarea name="content" cols=40 rows=7><?php echo $row['content']; ?></textarea>
        </p>
        <p>
            <input type="submit" value="立即修改" />
        </p>
    </form>

    <p>
        <a href="http://www.home.com/class/day2/code/list.php">返回新闻列表页</a>
    </p>
</body>
</HTML>
```

第二步，构建名为updh.php的程序页面，

```php
<?php

#接收数据
$id = $_GET['id'];//接收GET方式传递过来的新闻id值
$title = $_POST['title'];//接收新闻标题
$intro = $_POST['intro'];//接收新闻简介
$content = $_POST['content'];//接收新闻内容

#引入公共操作文件
include './common.php';

#构建更新语句，更新数据
$sql = "update news set title='{$title}', intro='{$intro}', content='{$content}' where id={$id}";
$re = mysqli_query($link, $sql);

if( $re ){//执行更新成功
    echo '修改数据成功！'; 
}else{//执行更新失败
    echo '修改数据失败！'; 
}
//2秒后跳转回本条数据的编辑页面
header('Refresh:2; url=http://www.home.com/class/day2/code/upd.php?id='.$id);
```



### 实现删除功能

**==步骤==**：

第一步，构建名为del.php的程序页面，代码如下：

```php
<?php

#接收数据
$id = $_GET['id'];//接收GET方式传递过来的新闻id值

#引入公共操作文件
include './common.php';

#构建删除SQL语句，并且执行
$sql = "delete from news where id={$id}";
$re = mysqli_query($link, $sql);

if( $re ){//删除成功
    echo '执行删除操作成功！'; 
}else{//删除失败
    echo '执行删除失败，请联系管理员！';     
}
//2秒后跳回列表页
header('Refresh:2; url=http://www.home.com/class/day2/code/list.php');
```



### 实现分页功能

思路分析

左半边

1. 当前页就是左边界

   ![1529744476766](15.png)

2. 当前页的上一页为左边界

   ![1529744538579](16.png)

3. 当前页的上两页为左边界

   ![1529744587362](17.png)

4. 其他情况

   ![1529744631145](18.png)

   

   

右半边

1. 当前页就是右边界

   ![1529744697444](19.png)

2. 当前页的下一页为右边界

   ![1529744738405](20.png)

3. 当前页的下两页为右边界

   ![1529744767589](21.png)

4. 其他情况

   ![1529744791282](22.png)



**==步骤==**：

第一步，构建一个名为pageHtml.php的文件，代码如下：

```php
/**
 * 功能：获得分页html代码部分
 * @param  $nowPage   int   表示当前页的页码
 * @param  $totalPage   int   表示分页的总页数
 * @param  $url   string   表示分页跳转的链接地址
 */
function pageHtml($nowPage, $totalPage, $url){ 
    
    #左半边
    $preOnePage = $nowPage-1;//当前页的上一页
    $preTwoPage = $nowPage-2;//当前页的上二页

    $leftHtml = '';

    if( $nowPage==1 ){//当前页就是左边界
        
        $leftHtml .= " ";

    }elseif( $preOnePage==1 ){//当前页的上一页为左边界
        // http://www.home.com/class/day2/code/pageHtml.php?page=12
        $leftHtml .= "<a href='{$url}={$preOnePage}'>上一页</a> ";
        $leftHtml .= "<a href='{$url}={$preOnePage}'>{$preOnePage}</a> ";
    
    }elseif( $preTwoPage==1 ){//当前页的上两页为左边界
    
        $leftHtml .= "<a href='{$url}={$preOnePage}'>上一页</a> ";
        $leftHtml .= "<a href='{$url}={$preTwoPage}'>{$preTwoPage}</a> ";
        $leftHtml .= "<a href='{$url}={$preOnePage}'>{$preOnePage}</a> ";

    }else{//其他情况
        
         $leftHtml .= "<a href='{$url}={$preOnePage}'>上一页</a> ";
         $leftHtml .= "... ";
        $leftHtml .= "<a href='{$url}={$preTwoPage}'>{$preTwoPage}</a> ";
        $leftHtml .= "<a href='{$url}={$preOnePage}'>{$preOnePage}</a> ";
    }

    #构建当前页
    $middleHtml = "<a style='color:red;'>{$nowPage}</a> ";

    #右半边
    $nextOnePage = $nowPage+1;//当前页的下一页
    $nextTwoPage = $nowPage+2;//当前页的下二页

    $rightHtml = '';

    if( $nowPage==$totalPage ){//当前页就是右边界
    
        $rightHtml .= " ";

    }elseif( $nextOnePage==$totalPage ){//当前页的下一页为右边界

        $rightHtml .= "<a href='{$url}={$nextOnePage}'>{$nextOnePage}</a> ";
        $rightHtml .= "<a href='{$url}={$nextOnePage}'>下一页</a> ";
    
    }elseif( $nextTwoPage==$totalPage ){//当前页的下两页为右边界
    
        $rightHtml .= "<a href='{$url}={$nextOnePage}'>{$nextOnePage}</a> ";
        $rightHtml .= "<a href='{$url}={$nextTwoPage}'>{$nextTwoPage}</a> ";
        $rightHtml .= "<a href='{$url}={$nextOnePage}'>下一页</a> ";

    }else{//其他情况
        $rightHtml .= "<a href='{$url}={$nextOnePage}'>{$nextOnePage}</a> ";
        $rightHtml .= "<a href='{$url}={$nextTwoPage}'>{$nextTwoPage}</a> ";
        $rightHtml .= "... ";
        $rightHtml .= "<a href='{$url}={$nextOnePage}'>下一页</a> ";
    }

    return $leftHtml . $middleHtml . $rightHtml;
}
```

第二步，在list.php中构建分页参数，

```php
<?php 

//引入公共操作文件
include './common.php';



#==============================================================调整的代码
//引入分页函数文件
include './pageHtml.php';

#计算分页所需参数
$numPerPage = 10;//每页显示10条数据
$nowPage = isset($_GET['page']) ? $_GET['page'] : 1;//如果有当前页的页面，则使用传递的页码，如果没有则默认显示第一页数据
//计算总页数
$sql = "select count(*) as num from news where 1";
$result = mysqli_query($link, $sql);
$pageRow = mysqli_fetch_assoc($result);//查询得到数据表中总的记录条数
$totalPage = intval(ceil($pageRow['num']/$numPerPage));//求得总页数
/*
总的记录条数256
每页显示10条

总页数 = 总记录条数/每页显示记录数

总页数 = 256/10 = ceil(25.6)=26 
*/
$url = "http://www.home.com/class/day2/code/list.php?page";


#执行查询语句查询数据表的数据
/*
第一页     limit 0, 10
第二页     limit 10, 10
第三页     limit 20, 10
第$nowPage页      limit ($nowPage-1)*$numPerPage, 10 
*/
$x = ($nowPage-1)*$numPerPage;//计算limit的偏移量
$sql = "select id, title, intro, post_date from news where 1 order by id desc limit {$x}, {$numPerPage}";
#==============================================================调整的代码



$result = mysqli_query($link, $sql);

//解析出所有的数据
$rows = mysqli_fetch_all($result, MYSQLI_ASSOC);

?>
<!DOCTYPE html>
<HTML>
<head>
    <meta charset="UTF-8">
    <title>后台新闻列表页</title>
</head>
<body>

    <p>
        <a href="http://www.home.com/class/day2/code/ad.php">添加新闻</a>
    </p>

    <table border="1px">
        <thead>
            <tr>
                <td>序号</td>
                <td>ID</td>
                <td>新闻标题</td>
                <td>新闻简介</td>
                <td>添加时间</td>
                <td>操作</td>
            </tr>
        </thead>
        <tbody>
            <?php foreach( $rows as $rows_key=>$row ){ ?>
            <tr>
                <td><?php echo $rows_key+1; ?></td>
                <td><?php echo $row['id']; ?></td>
                <td><?php echo $row['title']; ?></td>
                <td><?php echo $row['intro']; ?></td>
                <td><?php echo date('Y-m-d H:i:s', $row['post_date']); ?></td>
                <td>
                    <a href="http://www.home.com/class/day2/code/upd.php?id=<?php echo $row['id']; ?>">编辑新闻</a> 
                    <a href="http://www.home.com/class/day2/code/del.php?id=<?php echo $row['id']; ?>">删除新闻</a>
                </td>
            </tr>
            <?php } ?>
        </tbody>
    </table>

    <p>
<!-- =======================================================调整的代码 -->     
        <!-- <a href="">上一页</a> -->
        <!-- ... -->
        <!-- <a href="">1</a> -->
        <!-- <a href="">2</a> -->
        <!-- <a href="" style="color:red;">3</a> -->
        <!-- <a href="">4</a> -->
        <!-- <a href="">5</a> -->
        <!-- ... -->
        <!-- <a href="">下一页</a> -->
        <?php echo pageHtml($nowPage, $totalPage, $url); ?>
<!-- =======================================================调整的代码 -->   
    </p>

</body>
</HTML>


```



## 4. 全天总结

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







