---
title: Ajax和JSON案例
date: 2018-12-18 17:59:18
updated: 2018-12-18 17:59:18 
mathjax: false
categories: 
tags:
typora-root-url: Ajax和JSON案例
typora-copy-images-to: Ajax和JSON案例
top: 1
---


# 十二、案例：省市县三级联动

## 1、数据表的关系

![1533199284315](1533199284315.png)

省表：``province``

市表：``city``

区县：``areacounty``

对应关系：

​	province表中的==Pcode==字段和city表中的==ProvinceCode==对应

​	city表中的==Ccode==和areacounty表中的==CityCode==对应

查询所有的省：`select * from province`

查询广东省下面的市：`select * from city where ProvinceCode=440000` //440000是广东省的Pcode

查询广州市下面的区县：`select * from areacounty where CityCode=440100` //440100是广州市的Ccode

## 2、制作html页面

```html
<body>

<select id="p">
    <option value="">--请选择省--</option>
    <option value="">北京市</option>
    <option value="">广东省</option>
    <option value="">广西省</option>
</select>

<select id="c">
    <option value="">--请选择市--</option>
</select>

<select id="a">
    <option value="">--请选择区县--</option>
</select>
</body>
```

效果：

![1533199930967](1533199930967.png)

## 3、页面加载，先获取所有的省

通过js，发送ajax请求到07city.php，然后获取所有的省。

约定用type区分，此次请求要取什么数据。



先写`07city.php`，获取所有的省：

```php
$pdo = new PDO('mysql:host=localhost; dbname=test; charset=utf8', 'root', '123');

// 约定请求会有一个区分取什么数据的参数type， type=p 表示获取省，type=c 表示获取市，type=a 表示获取区县
$type = $_GET['type'];
if($type == 'p'){
    $sql = "select * from province";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($data); //将获取的数据转换成json，返回给浏览器
}
```

## 4、html页面发送ajax请求，把所有的省获取

```html
<script>
    //先获取所有的省
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if(xhr.readyState==4 && xhr.status==200){
            //接收所有的省
            var str = xhr.responseText;
            //把str转换成js数组
            var arr = JSON.parse(str);
            //console.log(arr);
            var res = '<option value="0">--请选择省--</option>';
            for(var i=0; i<arr.length; i++){
                res += '<option value="'+ arr[i].Pcode +'">'+ arr[i].Pname +'</option>';
            }
            document.getElementById('p').innerHTML = res;
        }
    };
    xhr.open('get', '07city.php?type=p');
    xhr.send(null);
</script>
```

效果：

![1533200880147](1533200880147.png)

## 5、当省切换的时候获取对应的市

js代码：

```javascript
	/************************ 获取市的代码 *******************************/
    //当省的内容改变的时候，获取对应的市
    document.getElementById('p').onchange = function () {
        xhr.onreadystatechange = function () {
            if(xhr.readyState==4 && xhr.status==200){
				//这里要处理服务器返回的数据
            }
        };
        var Pcode = this.value; //切换的省的Pcode值
        xhr.open('get', '07city.php?type=c&Pcode='+Pcode);
        xhr.send(null);
    };
```

PHP代码：获取对应的市

```php
$pdo = new PDO('mysql:host=localhost; dbname=test; charset=utf8', 'root', '123');

// 约定请求会有一个区分取什么数据的参数type， type=p 表示获取省，type=c 表示获取市，type=a 表示获取区县
$type = $_GET['type'];
if($type == 'p'){
    $sql = "select * from province";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($data); //将获取的数据转换成json，返回给浏览器
}elseif ($type == 'c'){
    /**************************** 获取对应的市  *******************************/
    $sql = "select * from city where ProvinceCode = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->bindValue(1, $_GET['Pcode']);
    $stmt->execute();
    $data = $stmt->fetchAll(2);
    echo json_encode($data);
}

```

js处理服务器返回的市的数据：

```javascript
	//当省的内容改变的时候，获取对应的市
    document.getElementById('p').onchange = function () {
        xhr.onreadystatechange = function () {
            if(xhr.readyState==4 && xhr.status==200){
                //复制处理省的代码，修改一下即可
                var str = xhr.responseText;
                //把str转换成js数组
                var arr = JSON.parse(str);
                //console.log(arr);
                var res = '<option value="0">--请选择市--</option>';
                for(var i=0; i<arr.length; i++){
                    res += '<option value="'+ arr[i].Ccode +'">'+ arr[i].Cname +'</option>';
                }
                document.getElementById('c').innerHTML = res;
            }
        };
        var Pcode = this.value; //切换的省的Pcode值
        xhr.open('get', '07city.php?type=c&Pcode='+Pcode);
        xhr.send(null);
    };
```

## 6、当市切换的时候，获取对应的区县

复制获取市的代码，然后修改：

js代码：

```javascript
document.getElementById('c').onchange = function () {
        xhr.onreadystatechange = function () {
            if(xhr.readyState==4 && xhr.status==200){
                var str = xhr.responseText;
                //把str转换成js数组
                var arr = JSON.parse(str);
                //console.log(arr);
                var res = '<option value="0">--请选择区县--</option>';
                for(var i=0; i<arr.length; i++){
                    res += '<option value="'+ arr[i].Acode +'">'+ arr[i].Aname +'</option>';
                }
                document.getElementById('a').innerHTML = res;
            }
        };
        var Ccode = this.value; //切换的市的时候，获取Ccode值
        xhr.open('get', '07city.php?type=a&Ccode='+Ccode);
        xhr.send(null);
    };
```

PHP代码：

```php
....
}elseif ($type == 'a'){
    $sql = "select * from areacounty where CityCode = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->bindValue(1, $_GET['Ccode']);
    $stmt->execute();
    $data = $stmt->fetchAll(2);
    echo json_encode($data);
}
```

切换省的时候，把区县重置：

![1533202243022](1533202243022.png)



## 7、细节处理

1. 切换省份时，区县要重置
2. 省份重置时，市和区县都要重置

   ```javascript
       //省份对象事件：改变
       gById('p').onchange = function () {
   
           //--------------------细节处理-----------------------//
           //切换省份时，区县要重置
           gById('a').innerHTML='<option value="0">--请选择区县--</option>';
   
           //省份重置时，市和区县都要重置
           if (this.value==0){
               gById('c').innerHTML='<option value="0">--请选择市--</option>';
               gById('a').innerHTML='<option value="0">--请选择区县--</option>';
           }
           //--------------------细节处理-----------------------//
   ```


3. 市重置时，区县需要重置
   ```javascript
   	//市对象事件：改变
       gById('c').onchange = function () {
   
           //--------------------细节处理-----------------------//
           //市重置时，区县要重置
           if (this.value==0){
               gById('a').innerHTML='<option value="0">--请选择区县--</option>';
           }
           //--------------------细节处理-----------------------//
   ```

----



# 十三、案例：省市县三级联动另一种思路

## 1、对于不经常变换的数据，可以用文件存储

全国的省、市、区县可能很多年都不会发生变化，对于这种数据，就可以不用放到数据库中，直接使用文件存储，效果很好。不但可以加快查询速度，还能减轻数据库服务器的压力。

![1533260844528](1533260844528.png)

## 2、获取省

首先创建`01city.php`，里面读取`0.json`，直接返回读取的json数据。

```php
//返回所有的省
echo file_get_contents('./city/0.json');
```

创建`01city.html` ，里面先写html布局

```html
<select id="p">
    <option value="0">--请选择省--</option>
</select>

<select id="c">
    <option value="0">--请选择市--</option>
</select>

<select id="a">
    <option value="0">--请选择区县--</option>
</select>
```

然后js封装一个get方法：

```html
<script>
    //封装一个get请求
    /**
     * @param url 请求的地址
     * @param fn  回调函数，用fn来处理服务器返回的数据
     */
    function get(url, fn){
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if(xhr.readyState==4 && xhr.status==200){
                fn(xhr.responseText);
            }
        };
        xhr.open('get', url);
        xhr.send(null);
    }
</script>
```

最后调用get方法，获取所有的省，并处理

```javascript
/**************************** 首先加载所有的省 *****************************/
    get('01city.php', function(data){
        var arr = JSON.parse(data);
        var res = '<option value="0">--请选择省--</option>';
        for(var i=0; i<arr.length; i++){
            res += '<option value="'+ arr[i].id +'">'+ arr[i].cn_name +'</option>';
        }
        //把连接好的option放到id为p的select中
        document.getElementById('p').innerHTML = res;
    });
```

整体的图示：

![1533264032807](1533264032807.png)

## 3、获取市

```javascript
/********************* 获取市，省切换的时候 **************************/
    document.getElementById('p').onchange = function () {
        //省切换的时候，重置区县
        document.getElementById('a').innerHTML = '<option value="0">--请选择区县--</option>';
        //this.value指的是 option的value值
        var v = this.value;
        if(v == 0){ //表示用户点击了 --请选择省--
            //重置市，区县
            document.getElementById('c').innerHTML = '<option value="0">--请选择市--</option>';
            document.getElementById('a').innerHTML = '<option value="0">--请选择区县--</option>';
            return; //终止函数执行
        }
        get('01city.php?filename='+v, function(data){
            //形参data就是服务器返回的数据
            var arr = JSON.parse(data);
            var res = '<option value="0">--请选择市--</option>';
            for(var i=0; i<arr.length; i++){
                res += '<option value="'+ arr[i].id +'">'+ arr[i].cn_name +'</option>';
            }
            //把连接好的option放到id为c的select中
            document.getElementById('c').innerHTML = res;
        });
    };
```

`01city.php `获取地址栏的filename，根据filename来获取对应的json文件：

```php
//获取地址栏的参数 filename
$filename = $_GET['filename'] ?? 0;
//返回所有的省
echo file_get_contents('./city/'. $filename .'.json');
```



## 4、细节处理

上面的代码已包含。

1. 切换省份时，区县要重置

2. 省份重置时，市和区县都要重置

   ```javascript
       //省份对象事件：改变
       document.getElementById('p').onchange = function () {
   
           //--------------------细节处理-----------------------//
           //切换省份时，区县要重置
           gById('a').innerHTML = '<option value="0">--请选择区县--</option>';
   
           //省份重置时，市和区县都要重置
           if (this.value == 0) {
               gById('c').innerHTML = '<option value="0">--请选择市--</option>';
               gById('a').innerHTML = '<option value="0">--请选择区县--</option>';
               return; //终止函数往下执行
           }
           //--------------------细节处理-----------------------//
   ```

3. 市重置时，区县需要重置

   ```javascript
       //市对象事件：改变
       document.getElementById('c').onchange = function () {
   
           //--------------------细节处理-----------------------//
           //市重置时，区县要重置
           if (this.value == 0) {
               gById('a').innerHTML = '<option value="0">--请选择区县--</option>';
               return; //终止函数往下执行
           }
           //--------------------细节处理-----------------------//
   ```

------



# 案例—Ajax跨域获取天气信息

接口地址1：http://wthrcdn.etouch.cn/weather_mini?citykey=101010100

==Ajax可以直接请求==，推断出对方网站肯定设置 `header('Access-Control-Allow-Origin:*');`。

下面是``08weather.html`` 代码

```html
<body>

<input type="button" value="请求" id="btn" />

<script>
    //点击btn的时候，发送ajax请求
    document.getElementById('btn').onclick = function(){
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if(xhr.readyState==4 && xhr.status==200){
                //console.log(xhr.responseText);
                var obj = JSON.parse(xhr.responseText);
                //console.log(obj);
                console.log(obj.data.city + ' ' + obj.data.wendu + ' ' + obj.data.ganmao);
            }
        };
        xhr.open('get', 'http://wthrcdn.etouch.cn/weather_mini?citykey=101010100');
        xhr.send();
    };
</script>

</body>
```



接口地址2：http://www.weather.com.cn/data/sk/101010100.html

==Ajax不可以直接请求。==

下面是`09weather.html`

```html
<body>
<input type="button" value="请求" id="btn" />

<script>
    //点击btn的时候，发送ajax请求
    document.getElementById('btn').onclick = function(){
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if(xhr.readyState==4 && xhr.status==200){
                //console.log(xhr.responseText);
                var obj = JSON.parse(xhr.responseText);
                console.log(obj);
            }
        };
        xhr.open('get', '09weather.php');
        xhr.send();
    };
</script>
</body>
```

`09weather.php `代码：

```php
echo file_get_contents('http://www.weather.com.cn/data/sk/101010100.html');
```





# 七、案例 – Ajax无刷新分页

## 7.1、分页原理

比如，我的 areacounty 表有3125条数据。要求每页显示10条。那么共有多少页？

$count = 3125;

$pageSize = 10;
 $maxPage = ceil($count / $pageSize);

获取第1页数据的SQL：`select * from areacounty order by AID limit 0,10;`

获取第2页数据的SQL：`select * from areacounty order by AID limit 10,10;`

获取第3页数据的SQL：`select * from areacounty order by AID limit 20,10;`

获取第$p页的数据的SQL：`select * from areacounty order by AID limit ($p-1)*$pageSize, $pageSize;`

## 7.2、传统的分页

TODO

## 7.3、异步请求数据，完成无刷新分页

TODO

