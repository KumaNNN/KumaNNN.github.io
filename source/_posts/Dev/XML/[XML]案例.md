---
title: [XML]案例
date: 2018-12-18 12:35:40
updated: 2018-12-18 12:35:40 
mathjax: false
categories: 
tags:
typora-root-url: assets
typora-copy-images-to: assets
top: 
---


## 八、小案例--获取天气信息

下面是一个天气信息的接口：
请求地址： http://v.juhe.cn/weather/index
请求参数： cityname=%E5%8C%97%E4%BA%AC&dtype=xml&format=&key=810c3b2c488bc37d5f521196d8799a72
请求方式： GET

广州的天气接口：

http://v.juhe.cn/weather/index?cityname=%E5%B9%BF%E5%B7%9E&dtype=xml&format=&key=810c3b2c488bc37d5f521196d8799a72

我们已经知道，通过该接口，可以获取到XML格式的天气信息，所以解析该XML后就能够拿到我们想要的天气信息了，并可以把天气信息应用到你的网站中。

代码--输出今天的天气状况：

```php
//判断：如果本地的天气文件不存在或者weather.xml30秒没有更新，则从新从远程获取一次
if(!file_exists('./weather.xml') || filemtime('./weather.xml') + 30 < time()) {
    $url = 'http://v.juhe.cn/weather/index?cityname=%E5%B9%BF%E5%B7%9E&dtype=xml&format=&key=810c3b2c488bc37d5f521196d8799a72';
    $str = file_get_contents($url);
    //把得到的字符串放到本地文件中
    file_put_contents('./weather.xml', $str);
    //echo 1111;  //测试
}

//直接读取本地文件
$xml = simplexml_load_file('./weather.xml');

//echo '<Pre>';
//print_r($xml);

//
echo '今天的温度是：' . $xml->result->today->temperature;
echo '<br>';
echo '今天' . $xml->result->today->weather;
```





## 十、案例--电子词典

### 10.1、界面设计

查询的时候，使用get方式提交到当前页面，所以表单的action和method都不需要写。

```html
<h1>查询</h1>
    <form>
        <input type="text" name="search">
        <select name="type">
            <option value="en">英文</option>
            <option value="cn">中文</option>
        </select>
        <input type="submit" value="查询">
    </form>
    <br>
    <p>查询结果：<span>xxx</span></p>
```



### 10.2、词库设计

创建16dict.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<dict>
    <word>
        <en>bag</en>
        <cn>包</cn>
    </word>
    <word>
        <en>desk</en>
        <cn>桌</cn>
    </word>
    <word>
        <en>position</en>
        <cn>位置</cn>
    </word>
</dict>
```

### 10.3、基本的查询实现

```php
<?php
//获取搜索的单词
//获取词的类型（中文、英文）
$search = $_GET['search'];
$type = $_GET['type'];

//加载xml词库
$xml = simplexml_load_file('16dict.xml');
//根据查询的内容，找到包含查询内容的词
$word = $xml->xpath('//word[en = "bag"]'); 
//根据查询的词，找到中文
$result = $word[0]->cn;
//echo "<pre>";
//print_r($word);
?>
```

```php+HTML
<p>查询结果：<span><?php echo $result;?></span></p>
```

### 10.4、解决bug

```php+HTML
<?php
$result = ''; //给result一个默认值
$default_value = ''; //搜索框的默认值
$default_selected = 'en'; //下拉框默认值

if(isset($_GET['search']) && $_GET['search'] != '') {
    
    $search = $default_value = $_GET['search']; //获取搜索的单词
    $type = $default_selected =  $_GET['type']; //获取词的类型（中文、英文）

    $xml = simplexml_load_file('16dict.xml');  //加载xml词库
    $word = $xml->xpath("//word[$type = '$search']"); //根据查询的内容，找到包含查询内容的词

    //echo "<pre>";
    //print_r($word); //数组
    
    //根据数组是否为空进行判断
    if($word){ //不为空时
        //根据查询的词，找到中文
        $result = $type=='en' ? $word[0]->cn : $word[0]->en;
    } else { //为空时
        $result = '查无结果';
    }
}
?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>电子词典</title>
</head>
<body>
    <h1>查询</h1>
    <form>
        <input type="text" name="search" value="<?php echo $default_value;?>">
        <select name="type">
            <option value="en" <?php if($default_selected=='en') echo "selected";?>>英文</option>
            <option value="cn" <?php if($default_selected=='cn') echo "selected";?>>中文</option>
        </select>
        <input type="submit" value="查询">
    </form>
    <br>
    <p>查询结果：<span><?php echo $result;?></span></p>
</body>
</html>
```



