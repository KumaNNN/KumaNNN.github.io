---
title: Ajax高级
date: 2018-12-18 17:59:18
updated: 2018-12-18 17:59:18 
mathjax: false
categories: 
tags:
typora-root-url: Ajax高级
typora-copy-images-to: Ajax高级
top: 1
---

# 五、FormData

## 5.1、使用FormData收集表单数据

本节课我们将学习以下内容：

​       ①、使用FormData完成表单数据的收集

​       ②、将收集到的数据通过ajax对象发送给服务器

**FormData**：字母意思就是表单数据，==这是h5中新增的一个内置对象（构造器）==，它可以获取任何类型的表单项的值，比如text/radio/checkbox/file/textarea，适用于获取大量的表单项的值。常用于发送Ajax请求。



创建`03FormData.html`

```html
<form name="myform">
    用户名：<input type="text" name="username"> <br>
    密　码：<input type="password" name="pwd"> <br>
    性　别：<input type="radio" name="sex" value="男" checked>男
          <input type="radio" name="sex" value="女">女 <br>
    头　像：<input type="file" name="picture" /><br>
    简　介：<textarea name="introduce" cols="30" rows="3"></textarea><br>
    <!--提交按钮一定要是button-->
    <input type="button" value="提交" id="btn" />
</form>
```

下面写js，收集表单数据，使用ajax发送到03FormData.php

```html
<script>
    //获取button，绑定单击事件
    document.getElementById('btn').onclick = function () {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {

        };
        //数据比较多，使用post方式发送
        xhr.open('post', '03FormData.php');
        
        //使用FormData来收集表单数据，
        //先获取表单，然后实例化FormData，并给FormData传参为表单
        var form = document.myform; //获取表单
        var fd = new FormData(form); //fd 就是所有的表单项的内容
        xhr.send(fd);
    };

</script>
```

创建`03FormData.php`，将获取的表单的内容，存放到文件中：

```php
//接收表单数据，并放到文件中，以便查看
file_put_contents('post.txt', print_r($_POST, true)); //print_r()如果第二个参数为true，表示不输出，而是返回数组

file_put_contents('file.txt', print_r($_FILES, true));
```

**==总结（注意点）==**：

1. 使用post请求，并使用FormData的时候，**不能**设置请求头 `xhr.setRequestHeader();`
2. 有文件域，但是不用设置enctype。
3. 获取表单的内容使用`$_POST`，获取文件域的内容使用`$_FILES`
4. 收集表单项的值是根据表单项的**name**值获取的。



## 5.2、使用FormData完成文件上传

本节课我们将学习以下内容：

​       ①、配合FormData，完成文件异步上传工作

使用的文件还是03FormData.html和03FormData.php。

在PHP页面，完成文件的上传即可。

```php
//接收表单数据，并放到文件中，以便查看
file_put_contents('post.txt', print_r($_POST, true)); //print_r()如果第二个参数为true，表示不输出，而是返回数组

file_put_contents('file.txt', print_r($_FILES, true));

//完成文件上传
//创建存放目录
$dir = './Uploads/';
if(!file_exists($dir)){
    mkdir($dir, 0777, true); //加入true，表示可以深层目录创建
}
//生成一个不重复的文件名
$name = uniqid(); //time()
//获取文件的后缀
$ext = strrchr($_FILES['picture']['name'], '.'); // .jpg
//echo $name;
//echo '<br>';
//echo $ext;
//move_uploaded_file(临时文件, 目标文件);
move_uploaded_file($_FILES['picture']['tmp_name'], $dir.$name.$ext);
```



## 5.3、使用FormData上传大文件（上传进度条）

本节课我们将学习以下内容：

​       ①、完成异步上传中，用进度条展示上传进度。



上传大文件，应该先配置``php.ini``。

**post_max_size**：表示允许post提交的内容的最大值

![1533279318595](1533279318595.png)

**upload_max_filesize**：表示允许提交的附件的最大值。

![1533279363257](1533279363257.png)

**max_execution_time** = 30：最大响应时间

==**重启Apache**==。



在`03FormData.html`页面中制作上传进度条：

1. 在上传的时候，打印xhr对象

   ![1533279768247](1533279768247.png)

   查看到的结果：

   ![1533279805601](1533279805601.png)

   2. 打印`xhr.upload` 

      ![1533279943817](1533279943817.png)

      输出结果：

      ![1533279927449](1533279927449.png)

      3. 给`onprogress` 事件添加处理函数

         ![1533280062394](1533280062394.png)

         查看输出的任意一个事件对象：

         ![1533280180825](1533280180825.png)

         4. 制作进度条

            用 `loaded / total` 表示上传进度。

            先在html中，设置一个进度条，默认隐藏状态。

            ```html
            <progress id="p" style="display: none;" value="0" max="0"></progress>
            ```

            当上传的时候，设置进度条的value和max，并让进度条显示：

            ![1533280931981](1533280931981.png)

# 六、==Ajax跨域问题==（重点）

Ajax是不允许跨域请求的。

## 6.1、什么是跨域请求

本节课我们将学习以下内容：

​       ①、什么是同源政策。

​       ②、同源政策有哪些限制

​       ③、什么是Ajax跨域请求。

### 6.1.1、什么是同源政策

1995年，同源政策由 Netscape（网景） 公司引入浏览器。目前，所有浏览器都实行这个政策。

最初，它的含义是指，A 网页设置的 Cookie，B 网页不能打开，除非这两个网页“同源”。==所谓“同源”指的是”三个相同“。==

- **协议相同（http  https）**
- **域名相同**
- **端口相同（默认80端口）**

### 6.1.2、同源政策有哪些限制

随着互联网的发展，“同源政策”越来越严格。目前，如果非同源，共有三种行为受到限制。

- Cookie无法读取。
- DOM 无法获得。
- AJAX 请求无效（可以发送，但浏览器会拒绝接受响应）。

### 6.1.3、什么是Ajax跨域请求

在Ajax请求中，==只要违反了同源政策的请求，都属于跨域请求==。

![img](clip_image040.jpg)

 只要请求的地址的==协议==或==域名==或==端口==和本网站不同，就属于跨域请求。

下面请求了另一个域名下面的一个PHP文件，就叫做跨域请求。

![1533282424397](1533282424397.png)

## 6.2、解决跨域问题

本节课我们将学习以下内容：

​       ①、如何使用**代理**方式解决跨域问题

​       ②、如何使用**jsonp**技术实现跨域请求

​       ③、如何使用**CORS**技术实现跨域

### 6.2.1、使用代理的方式

直接发送Ajax请求到其他域不允许，但是可以先发送Ajax请求到本网站中的一个php文件，然后让这个php文件去访问其他域的内容，那么这个php文件就可以认为是一个代理文件。

![1533282693359](1533282693359.png)

创建04kuayu.html，让其请求本域中的04kuayu.php文件：

```html
<!--// www.ajax.com-->
<script>
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if(xhr.readyState==4 && xhr.status==200){
            console.log(xhr.responseText);
        }
    };
    xhr.open('get', '04kuayu.php');
    xhr.send();
</script>
```

创建04kuayu.php，去访问www.js.com下面的04kuayu.php文件：

```php
// www.ajax.com
echo file_get_contents('http://www.js.com/04kuayu.php');
```

让www.js.com下面的04kuayu.php配合测试，加入下面的代码：

```php
// www.js.com
echo '我是js域名';
```



### 6.2.2、使用CORS方式

跨域访问技术CORS（Cross-Origin Resource Sharing ,跨源资源共享 ） 

**IE9+才能使用此方式**。

==需要在请求的网站中设置==：Access-Control-Allow-Origin

```php
header('Access-Control-Allow-Origin:允许的网站完整域名');
header('Access-Control-Allow-Origin:*'); //允许所有网站来请求
```



本域中，创建05kuayu.html，直接请求www.js.com/05kuayu.php

```html
<script>
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if(xhr.readyState==4 && xhr.status==200){
            console.log(xhr.responseText);
        }
    };
    xhr.open('get', 'http://www.js.com/05kuayu.php');
    xhr.send();
</script>
```

另一个网站：www.js.com/05kuayu.php，设置Access-Control-Allow-Origin

```php
//www.js.com
//设置header，允许www.ajax.com这个网站跨域请求
//header('Access-Control-Allow-Origin:http://www.ajax.com');
//header('Access-Control-Allow-Origin:*'); //允许所有网站来访问

/************ 下面设置允许多个网站来跨域请求 *************/
$allow = ['http://www.a.com', 'http://www.ajax.com', 'http://www.b.com'];

//当别人访问这个文件的时候，可以获取到访问者的域名
$domain = $_SERVER['HTTP_ORIGIN']; //获取的是纯的域名，如http://www.ajax.com
//$domain = $_SERVER['HTTP_REFERER']; //获取的域名，包括路径和参数http://www.ajax.com/2018-08-03/05kuayu.html
//echo $domain;
if(in_array($domain, $allow)){
	header('Access-Control-Allow-Origin:'.$domain);
}
echo '我还是js'; //返回给浏览器
```



### 6.2.3、使用jsonp完成跨域请求

**Jsonp(JSON with Padding)** 是 json 的一种"使用模式"，通俗的讲，jsonp可以通过html标签中的src属性可以访问另外域的内容，可以让网页从别的域名（网站）那获取资料，即跨域读取数据。 

使用script标签的src属性引入的文件会自动执行，只能执行js代码：

![1533284715276](1533284715276.png)

复杂一些：既然可以执行js代码，那么我可以调用一个js函数。

![1533284908730](1533284908730.png)

在复杂一点：给函数传入参数

![1533285162418](1533285162418.png)

刷新页面，能够看到获取的数据。

最后，动态的生成script标签，比如当点击按钮的时候，才创建script标签：

www.ajax.com/06kuayu.html代码

```html
<body>

<img src="http://www.js.com/1.jpg" />

<script>
    function abc(data){
        console.log(data);
    }
</script>

<!--<script src="http://www.js.com/06kuayu.php"></script>-->

<input type="button" value="获取数据" id="btn" />
<script>
    //点击按钮，创建script标签，并将其放到body中
    document.getElementById('btn').onclick = function () {
        var script = document.createElement('script');
        script.src = "http://www.js.com/06kuayu.php";
        document.body.appendChild(script);
    };
</script>
</body>
```

www.js.com/06kuayu.php 代码：

```php
//www.js.com
//echo "alert(123456);";
//echo "abc();"; //表示在js端，调用abc函数

$arr = ['apple', 'banana'];
$json = json_encode($arr);
echo "abc(". $json .");"; //表示在js端，调用abc函数
```

关于JSONP技术，补充：

www.ajax.com/07jsonp.html  和 www.js.com/07jsonp.php 

![1533287223815](1533287223815.png)



