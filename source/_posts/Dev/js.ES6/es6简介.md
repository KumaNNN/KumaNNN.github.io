---
title: es6简介
date: 2018-12-19 16:19:38
updated: 2018-12-19 16:19:38 
mathjax: false
categories: 
tags:
typora-root-url: es6_img
typora-copy-images-to: es6_img
top: 
---



# es6简介

需求：由于小程序里面的js代码基本都是使用es6的语法规范进行编写，所以我们必须了解一点js的es6标准。



**我们现在使用的js其实是有三个部分组成：**

1.  **ECMA** ： 是一个组织，该组织是用于指定一系列的语法规范，定义了基本的语法、变量类型。实现的语言：
    *  javascript
    *  actionScript（flash动画）
2.  **BOM**：浏览器对象，js操作浏览器的API的定义 ，如，window.location 、window.history\....
3.  **DOM**：文档对象，js操作网页DOM元素的API的定义



注意：我们知道的后端的 **nodejs** 只实现了 ECMA，它是没有实现BOM和DOM的。

我们现在使用的最多的ECMA的标准是 es5 这个标准（浏览器对该标准基本都支持）。但是随着社会发展，规范也是不断的完善，引入新的特性，慢慢提出了很多的方案，形成比较新的es6标准（该标准是在2015年发布的，所以也叫作 ECMA2015）。

目前来说 ES6正式发布了，但是目前只有一些比较新的浏览器才支持es6里面的新的标准，并且支持度也不是100%。所以在网页开发里面的如果希望使用es6的语法进行开发，则我们还必须要做一点转换，使用es6开发是没有问题，但是在实际上线的时候，我们还需要借助代码转换转换工具把es6标准转换为 es5的标准，以达到在所有的浏览器上都可以运行。

则这样的转换工具一般使用 **babel**。或者是在前端里面专门做自动化构建的工具 **webpack**。

学习资料：

[[http://es6.ruanyifeng.com/]](http://es6.ruanyifeng.com/)

![](image1.png)

新的特性：

最显著

1.  变量的声明（var 但是现在可以使用 let声明； 同时还引入常量的声明）

2.  箭头函数（基本上改写javascript里面匿名函数的写法，同时明确this的指向问题）

3.  引入Class等关键字（基本上改写之前的javascript里面面向的对象的写法，以前javascript面向对象都是基于原型的面向对象）

    ```javascript
    class People{
    
    }
    
    class Man extends People{
    
    }
    
    function People(name, age){
    
    // 定义属性 
    // this 代表的是谁？ 需要区分 ： 函数在哪里被调用， 怎么调用。
    this.name = name;
    this.age = age;
    }
    ```

    

实际使用：

```javascript
var p1 = new People(); // this代表的 p1

People(); // 代表是windows全局对象 等价于 window.People();
```



**call 和 apply 是做什么的？** 

**答：**改变this的指向，如果没有显示传递参数或者null，则指向window

```javascript
var obj = {};
People.call(obj); // this代表的obj
People.apply(null); // 不严格的模式下， this代表的 window全局对象
```



**如果把一个javascript里面的构造函数当成一个普通函数执行，则会出现什么问题？**

**答：**污染window全局，在全局内引入全局变量。

```javascript
function People(name, age){
    this.name = name;
    this.age = age;
}

People(); //相当于如下
//window.People();
//window.name = name;
//window.age = age;

People.prototype.say = function(){

}
```


==**注意**==

在我们使用es6的时候，则需要在javascript的**严格模式**下进行执行。



# let声明

## let 预解析的问题 

在变量声明之前的区域被称为死区，变量是不可以使用的。

![](image2.png)

## let 解决变量重复声明的问题

重复声明会报错

![](image3.png)

## let 块级作用域

![](image4.png)

# const关键字

定义常量

![](image5.png)

换个问题：

![](image6.png)

因为此时常量保存的是对象的地址，而修改时修改的是堆区中对象的值，没有修改其地址。



# 箭头函数

## 基本语法

![](image7.png)

**在es6里面是很重要的一个特性，在日后的js开发中，基本到处都会使用。**



## 参数列表

![](image8.png)

多个参数

![](image9.png)



## 箭头函数的右边部分

![](image10.png)

![](image11.png)

注意：如果在箭头函数里面右侧，只存在一条语句或者一条表达式，则默认内部隐式做了返回(return)

注意：如果只有一条语句，可以写 {} 也可以不写 {} 则不建议写 {} 。

![](image12.png)

在 ｛｝ 中，如果函数没有return，则默认返回undefined

![](image13.png)

函数体存在多条语句，则必须加上 { }

![](image14.png)



## 箭头函数的 this的指向问题

**理解：**

在es5里面，js里面的this的指向不是在定义的时候确定的，是在代码执行的时候才能确定，动态的。或者这样说，js里面的 this 要看它执行环境。

es5里面的this的指向：

1.  普通函数里面的this指向的window全局

2.  构造函数里面的this在实例化的时候，指向的是实例化出来的对象；补充当对象调用方法的时候，方法内部的this代表的当前对象。

3.  通过 call 和 apply 调用，则指向的是传递过来的第一个参数

4.  定时器里面的this指向的是window全局对象

在 es6 的箭头函数里面，this指向是在定义的时候已经明确了，和在哪里执行无关。 或者这样说，es6箭头函数里面的 this 的指向是看定义时候的环境，不看执行时候的动态环境。对于这句话，不好理解，因为并不清楚什么时候就是定义下来。如何理解?

> 答：在给箭头函数判断 this指向的时候，先看箭头函数是否被包裹在一个函数里面，如果被包裹，则看包裹的函数里面的 this指向谁 ，箭头函数里面的this就指向谁；
> 如果箭头函数没有被包裹，外层没有函数，则this指向window对象。



案例一：

![](image15.png)

案例二：

![](image16.png)

案例三：

![](image17.png)

案例四：箭头函数里面的 this在定义的时候已经明确。

![](image18.png)



# es6注意事项

现在我们编写的es6在现代浏览器下执行是没有什么问题，基本可以执行。

但是如果在低版本的浏览器或者IE下则无法执行。则这个时候我们是需要做**兼容处理**。

1.  babel 转换器进行转换即可。https://www.babeljs.cn/repl

![](image19.png)

注意：一般来说我们没必要手工的自己去使用babel进行转换。一般在前端开发里面都是使用自动化构造工具完成的，如，webpack。

![](image20.png)
