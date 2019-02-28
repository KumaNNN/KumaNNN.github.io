---
title: PhalApi框架
date: 2019-02-28 12:36:17
updated: 2019-02-28 12:36:17 
mathjax: false
categories: 
tags:
typora-root-url: PhalApi框架
typora-copy-images-to: PhalApi框架
top: 1
---


# π框架简介

在我们做小程序应用或者是一些前后端完全分离的项目里面（或者做一个单页应用、SPA ：signal page application），一般我们后端PHP程序员都需要编写好相关的接口，同时还要写好相应的接口文档，以供前端的开发人员或者其他的项目团队进行使用。

 前端程序员在做前后端分离的项目的时候，如果后端没有提供好相关 的即可，则前端可以使用一个 mock.js 脚本生成很多的测试数据。http://mockjs.com



**一般的开发流程：**

1. 写接口，一个url地址就是一个接口（框架实现），一把来说我们接口都是返回json格式数据。

  现在很多企业的一些项目不再使用api接口（基于REST规范，落地产品为 RESTful，应用到实际项目为 RESTFul api），而是使用RPC，如谷歌的gRPC，远程过程调用的方式去获取相关数据 http://doc.oschina.net/grpc?t=60136

  * 单一从后端获取数据，一般这类接口都不需要做啥认证，请求方式一般都是get。
  * 需要将客户端的数据提交到后端进行入库保存，或者有部分的数据是需要做一定的认证操作后才可以查看，这一类的接口一般都要事先做好接口的认证工作，证明有权限去访问该接口，请求的方式一般都是POST。

  	​	

2. 接口一般都需要做一些认证，对于一些特殊的接口，例如对后端数据库会造成更改，都必须要做出一定的验证，事先写好一个认证接口，同时在服务器端需要保存一定的认证信息，然后将认证的信息返回给客户端，客户端在每次请求其他类型的接口的时候，必须先携带该凭证。



3. 写接口的调用文档，一把来说我们写好了接口，都需要出示一份文档（接口说明书），给予前端人员使用。

   * url地址

   * 请求方式
   * 参数传递
   * 是否需要认证
   * 返回数据类型
   * 成功请求后的效果，示例代码，解释好每个字段的含义
   * 如果失败或者出错的时候，返回的信息，示例代码，一般都要有错误状态码，消息提示

   

一般我们可以使用一些网站提供的在线工具进行接口的编写；（https://www.showdoc.cc）

或者自己使用markdown的编辑器自己使用markdown语法进行编写。熟悉一下markdown语法。



本次打算使用**π框架**来编写小程序的接口，接口的验证。

**官网**：<https://www.phalapi.net/>

![img](wps328D.tmp.jpg) 

 



## 版本介绍

![img](wps329E.tmp.jpg) 

 

## 在线体验

![img](wps329F.tmp.jpg) 

 

## 亮点

![img](wps32B0.tmp.jpg) 

 

## 第三方集成

![img](wps32B1.tmp.jpg) 

 

## SDK

![img](wps32C1.tmp.jpg) 

 

 

## 查看

![img](wps32C2.tmp.jpg) 

 

## 下载

<https://www.phalapi.net/download.html>

 

## π框架安装

文档 ： [下载与安装](http://docs.phalapi.net/#/v2.0/download-and-setup)

1. 使用composer进行下载

```
> composer create-project phalapi/phalapi local.papi.com
```

 

2. 安装后的目录结构，`public` 为站点根目录

![img](wps32D4.tmp.jpg) 

 

3. 配置一个虚拟主机

![img](wps32E4.tmp.jpg) 

 

4. 配置hosts文件

![img](wps32F5.tmp.jpg) 

 

5. 浏览器访问效果

![img](wps32F6.tmp.jpg) 

 

# 文件目录结构

文档： [项目目录结构的差异](http://docs.phalapi.net/#/v2.0/how-to-upgrade-2x?id=%e9%a1%b9%e7%9b%ae%e7%9b%ae%e5%bd%95%e7%bb%93%e6%9e%84%e7%9a%84%e5%b7%ae%e5%bc%82)

## public目录

![img](wps3307.tmp.jpg) 

## config目录

![img](wps3308.tmp.jpg) 

 

## APP目录

![img](wps3318.tmp.jpg) 

## 源码

![img](wps3319.tmp.jpg) 

 

# 访问接口

文档： [运行Hello World >> 访问一个接口](http://docs.phalapi.net/#/v2.0/hello-world?id=%e8%ae%bf%e9%97%ae%e4%b8%80%e4%b8%aa%e6%8e%a5%e5%8f%a3)

![img](wps331A.tmp.jpg) 

 

1. 在地址栏进行url访问

![img](wps332B.tmp.jpg) 

​	访问规则：`域名?s=App.控制器名称.方法名称&key=value&key2=value2....`

 

2. 对应的控制器和方法

   ![1538487671539](1538487671539.png)



3. 效果

![img](wps333D.tmp.jpg) 

# 访问参数验证

文档位置 ：  [Api接口服务层 >> 接口参数规则配置](http://docs.phalapi.net/#/v2.0/api?id=%e6%8e%a5%e5%8f%a3%e5%8f%82%e6%95%b0%e8%a7%84%e5%88%99%e9%85%8d%e7%bd%ae)

注意：在每个控制器里面都会存在一个getRules方法，该方法里面的用于对应的接口传递的参数行为约束。

```php
/**
 * 这个方法是做参数验证的
 * @return [type] [description]
 */
/* 使用示例
public function getRules() {
    return array(
        '接口类方法名' => array(
            '接口类属性' => array('name' => '接口参数名称', ... ... ),
        ),
    );
}
*/
public function getRules() {
	
    return array(
    	// 一维下标是接口类的方法名，对应接口服务的Action；
    	# '方法名' => array
        'index' => array(
        	// 	二维下标是类属性名称，对应在服务端获取通过验证和转换化的最终客户端参数；
        	// 	array()中是对该属性的一个修饰 ，属性的值从get传参过来
        	// 	'name' : 指定接口参数名称，对应外部客户端请求时需要提供的参数名称。$_GET['username'] 
        	// 	'desc'： 描述，生成接口文档的时候使用
        	//
        	// 	$this->username = isset( $_GET['username'] ) ? $_GET['username'] : 'PhalApi'

        	# '属性名称' => array()
            'username' 	=> array('name' => 'username', 'default' => 'PhalApi', 'desc' => '用户名'),
        ),
    );
}
```

![1538487002273](1538487002273.png)



 TODO

# 文档生成

## 注释参考



[注释与在线文档](http://docs.phalapi.net/#/v2.0/api?id=%e6%b3%a8%e9%87%8a%e4%b8%8e%e5%9c%a8%e7%ba%bf%e6%96%87%e6%a1%a3)

* [接口服务名称](http://docs.phalapi.net/#/v2.0/api?id=%e6%8e%a5%e5%8f%a3%e6%9c%8d%e5%8a%a1%e5%90%8d%e7%a7%b0)

* [接口说明](http://docs.phalapi.net/#/v2.0/api?id=%e6%8e%a5%e5%8f%a3%e8%af%b4%e6%98%8e)

* [接口参数说明](http://docs.phalapi.net/#/v2.0/api?id=%e6%8e%a5%e5%8f%a3%e5%8f%82%e6%95%b0-1)

* [返回结果](http://docs.phalapi.net/#/v2.0/api?id=%e8%bf%94%e5%9b%9e%e7%bb%93%e6%9e%9c)

* [异常情况](http://docs.phalapi.net/#/v2.0/api?id=%e5%bc%82%e5%b8%b8%e6%83%85%e5%86%b5)

* [公共注释](http://docs.phalapi.net/#/v2.0/api?id=%e5%85%ac%e5%85%b1%e6%b3%a8%e9%87%8a)



## 在线文档

文档： [在线接口文档](http://docs.phalapi.net/#/v2.0/how-to-request?id=%e5%9c%a8%e7%ba%bf%e6%8e%a5%e5%8f%a3%e6%96%87%e6%a1%a3)

π框架给我们提供了强大的文档生成方式，我们只需要在方法前面按照指定的格式编写注释，即可生成文档。

1. 在方法前面编写注释

   ![1538490748083](1538490748083.png)

    

2. 通过 域名/docs.php 方式访问在线文档

![img](wps334F.tmp.jpg) 

 

3. 点击展开

![img](wps3360.tmp.jpg) 

 

4. 详情查看

![img](wps3370.tmp.jpg) 

 

 

## 离线文档

文档： [生成离线文档](http://docs.phalapi.net/#/v2.0/how-to-request?id=%e5%a6%82%e4%bd%95%e7%94%9f%e6%88%90%e7%a6%bb%e7%ba%bf%e6%96%87%e6%a1%a3%ef%bc%9f)

π框架提供了离线文档，供开发者使用。

**使用方式：** 

```bash
phalapi$  php ./public/docs.php 

Usage:
生成展开版：  php ./public/docs.php expand
生成折叠版：  php ./public/docs.php fold

脚本执行完毕！离线文档保存路径为：/path/to/phalapi/public/docs
```

注意： 根据实际补全路径信息，如  `./public/docs.php  `



1. 执行如下的命令

![img](wps3371.tmp.jpg) 

2. 目录查看

![img](wps3382.tmp.jpg) 

 

3. 访问 `域名/docs/`

![img](wps3383.tmp.jpg) 

 

 

# π框架的模型

文档： [Model数据模型层与数据库操作](http://docs.phalapi.net/#/v2.0/model?id=model%e6%95%b0%e6%8d%ae%e6%a8%a1%e5%9e%8b%e5%b1%82%e4%b8%8e%e6%95%b0%e6%8d%ae%e5%ba%93%e6%93%8d%e4%bd%9c)

==注意==：π框架是没有视图、学习完成控制器之后，我们就可以学习模型，并且π框架里面的模型也不是自己写的，是使用别人开发的一个ORM框架（NotORM）。



## 数据库配置

![1538491512850](1538491512850.png)

 

## 模型的定义

文档参考： 

* [NotORM简介](http://docs.phalapi.net/#/v2.0/model?id=notorm%e7%ae%80%e4%bb%8b)    

* [如何获取NotORM实例？](http://docs.phalapi.net/#/v2.0/model?id=%e5%a6%82%e4%bd%95%e8%8e%b7%e5%8f%96notorm%e5%ae%9e%e4%be%8b%ef%bc%9f)

* [Model子类与表名](http://docs.phalapi.net/#/v2.0/model?id=model%e5%ad%90%e7%b1%bb%e4%b8%8e%e8%a1%a8%e5%90%8d)

* **[在Model内的CURD基本操作](http://docs.phalapi.net/#/v2.0/model?id=%e5%9c%a8model%e5%86%85%e7%9a%84curd%e5%9f%ba%e6%9c%ac%e6%93%8d%e4%bd%9c)**



**NotORM**是一个优秀的开源PHP类库，可用于操作数据库。PhalApi的数据库操作，主要是依赖此NotORM来完成。 

>  NotORM官网：[www.notorm.com](http://www.notorm.com/) 



在src\app\Model目录下创建一个Movie.php文件

![1538031807649](1538031807649.png)



在src\app\Api\Site.php控制器文件实例化模型，获取数据

![1538033770581](1538033770581.png)



# 案例： 小程序轮播图



## 需求

**需求：**

需要为小程序提供一个轮播图的接口

![img](wps3396.tmp.jpg) 



## 分析 

在传统网站开发里面，很多网站的首页里面也是会存在一个轮播图信息，那么如果我们要在传统网页里面实现一个轮播图，则我们可以使用一些插件快速的完成。

https://www.swiper.com.cn/

快速入门的案例：

https://www.swiper.com.cn/usage/index.html



我们的需求是在小程序里面实现一个轮播图功能，小程序内部存在一个组件可以实现轮播图效果，只需要给轮播提供素材即可。



效果：

![1538033370889](1538033370889.png)

 

**分析：**

1. 请求方式：GET

2. 是否认证：不需要（接口的认证）

3. 返回数据类型 json

4. 参数：
  *  `number `代表需要几张轮播图
  *  设置一个默认值
  *  `position` 轮播位（轮播图分类）
     *  首页有轮播图，详情页也有轮播图，所以需要对齐进行分类，才方便读取。
     *  上传轮播图的时候，需要给这些轮播图一个分类

5. 轮播图点击之后跳转对应的业务

   * 后台我们上传轮播图的时候，需要为轮播图做一些相关业务的关联，一般的关联都是某件商品的展示。

     




## 建表

**设计表**

轮播图表

| id   | url      | gid        | is_on                                       | create_time | update_time | xxxx |
| ---- | -------- | ---------- | ------------------------------------------- | ----------- | ----------- | ---- |
|      | 图片地址 | 关联商品id | 表示轮播图是否上线 1代表上线，0代表没有上线 |             |             |      |

  ![1538033551042](1538033551042.png)


商品表

| id   | name | price | number | .... | ...  | ..   |
| ---- | ---- | ----- | ------ | ---- | ---- | ---- |
|      |      |       |        |      |      |      |

 ![1538034695579](1538034695579.png)

 





## 接口编写示例

1. 定义控制器，创建一个getRules方法

![img](wps33C9.tmp.jpg) 

 

2. 创建一个lst方法

![img](wps33CA.tmp.jpg) 

 

3. 创建一个transfer方法，用于数据的格式化

![img](wps33CB.tmp.jpg) 

 

4. 效果

![img](wps33DB.tmp.jpg) 

 

## 轮播图接口

1. 在src/Api/Banner.php控制器文件，创建一个getRules方法

![1538037911505](1538037911505.png)


2. 在src/Model/Banner.php模型文件，获取轮播图信息

![1538038013908](1538038013908.png)


3. 在src/Api/Banner.php控制器文件，创建一个lst方法

![1538037932482](1538037932482.png)


4. 在src/Api/Banner.php控制器文件，创建一个transfer方法，用于数据的格式化

![1538037945803](1538037945803.png)


5. 效果

![1538038037612](1538038037612.png)



## 商品详情接口

在src\app\Api\Goods.php文件编写商品详情接口

![1538038776351](1538038776351.png)

### 详情查看

   当我们点击轮播图之后，则需要打开一个页面显示商品的详情信息



1. 在pages/swiper/swiper.wxml文件为每个轮播项绑定点击事件

   ![1538038628665](1538038628665.png)

2. 在pages/swiper/swiper.js文件定义回调函数打开一个详情页

   ![1538038647842](1538038647842.png)

3. 在pages/detail/detail.js文件获取商品主键id，向商品详情接口发送网络请求获取数据

   ![1538038674478](1538038674478.png)

4. 在pages/detail/detail.wxml页面完成商品展示

   ![1538038716978](1538038716978.png)

5. 效果

   ![1538038688372](1538038688372.png)

## 集成微信小程序

1. 在config/config.js文件定义好url地址常量

   ![1538038334591](1538038334591.png)

2. 在pages/swiper/swiper.js文件，调用接口获取轮播图信息

   ![1538038397690](1538038397690.png)

3. 在pages/swiper/swiper.wxml文件完成布局

   ![1538038458458](1538038458458.png)

4. 效果

   ![1538038482324](1538038482324.png)





# 其它

## **语言包**

1. 查看系统使用的默认语言包

![img](wps33EC.tmp.jpg) 

 

2. 配置自己的语言项

![img](wps33ED.tmp.jpg) 

 

3. 查看语言包函数

![img](wps33FD.tmp.jpg) 

 

 

## **自定义异常类**

1. 自定义异常类

![img](wps33FE.tmp.jpg) 

 

2. 在轮播图信息为空的时候抛出异常

![img](wps340F.tmp.jpg) 

 

3. 效果

![img](wps3410.tmp.jpg) 



## 小程序如何和PHP交互的？

![1538039794609](1538039794609.png)