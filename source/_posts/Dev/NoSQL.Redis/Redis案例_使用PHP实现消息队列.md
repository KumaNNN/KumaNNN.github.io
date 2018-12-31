---
title: Redis案例_使用PHP实现消息队列
mathjax: false
categories:
  - Dev
  - NoSQL.Redis
typora-root-url: Redis案例_使用PHP实现消息队列
typora-copy-images-to: Redis案例_使用PHP实现消息队列
abbrlink: 3783825305
date: 2018-12-18 12:35:38
updated: 2018-12-18 12:35:38
tags:
top: 1
---


# 案例-使用PHP实现消息队列

## 简介

思路：实际就是操作链表数据类型的队列

 

使用php代码实现医院的模拟医生就诊叫号流程：

1、挂号（把病人的信息加入消息队列）

2、医生叫号（把病人的信息在消息队列中弹出，病人看完后医生停止就诊）



## 实操

1、编写挂号的代码如下

![img](wps973A.tmp.jpg) 

​	测试结果如下所示:

![img](wps973B.tmp.jpg) 

 

2、医生叫号，病人排队进入诊室，就把队列中依次弹出

![img](wps973C.tmp.jpg) 

 

​	测试结果如下:

![img](wps974D.tmp.jpg) 

​	继续刷新页面，医生实际中是点击了一个按钮

![img](wps974E.tmp.jpg) 

​	如果医生看完了所有的病人，那么就应该显示当前当前停止就诊了

![img](wps975E.tmp.jpg) 