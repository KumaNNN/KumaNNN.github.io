---
title: GD图像处理技术案例
date: 2019-02-28 12:36:17
updated: 2019-02-28 12:36:17 
mathjax: false
categories: 
tags:
typora-root-url: GD图像处理技术案例
typora-copy-images-to: GD图像处理技术案例
top: 1
---


# GD图像处理技术



## 4. 案例：制作水印图

### 功能分析

1. 根据一张需要打上水印的图片(目标图)创建一个画布；
2. 将logo图也打开成一个画布；
3. 在目标图上选择一个坐标基点；
4. 在logo图上也选择一个坐标基点（左上角0，0点）；
5. 将logo图拖拽到目标图片画布中，将logo图的基点对齐目标图的基点；
6. 调整logo图的透明度（20%）;
7. 将成品图保存成图片文件；
8. 关闭目标图片画布；
9. 关闭logo图片画布；



### 代码实现

构建程序文件名为code14.php，代码如下：

```php
<?php

#1. 根据一张需要打上水印的图片(目标图)创建一个画布
$dst = imagecreatefromjpeg('./source/fenghuang.jpg');
$dst_w = imagesx($dst);//[可选]目标图的宽度，用于后续计算
$dst_h = imagesy($dst);//[可选]目标图的高度，用于后续计算

#2. 将logo图也打开成一个画布
$src = imagecreatefrompng('./source/logo.png');
$src_w = imagesx($src);//logo图的宽度，用于参数
$src_h = imagesy($src);//logo图的高度，用于参数

/*
#第3～6步
3. 在目标图上选择一个坐标基点；
4. 在logo图上也选择一个坐标基点（左上角0，0点）；
5. 将logo图拖拽到目标图片画布中，将logo图的基点对齐目标图的基点；
6. 调整logo图的透明度（20%）;
*/
//imagecopymerge 拷贝并合并图像的一部分
//(目标图像,logo图像,目标x位置,目标y位置,logo起始位置x,logo起始位置y,logo宽,logo高,透明度)
//imagecopymerge($dst, $src, $dst_w/4, $dst_h/6, 0, 0, $src_w, $src_h, 20);
imagecopymerge($dst, $src, 50, 50, 0, 0, $src_w, $src_h, 20);

#7. 将成品图保存成图片文件；或者输出到浏览器
header('Content-type:image/jpeg');
imagejpeg($dst);

#8.关闭目标图片画布
imagedestroy($dst);
#9关闭logo图片画布
imagedestroy($src);
```

访问code14.php，效果如下：

![1530173036884](28.png)



## 5. 案例：制作缩略图

### 固定宽高缩略图

#### 功能分析

1. 根据目标缩略图的尺寸创建一个空白画布（dst）（200×300）；
2. 将需要缩小的那张图片（src）打开成一个画布；
3. 在dst画布上选择左上角(0,0)点作为dst图的坐标基点；
4. 在src画布上选择左上角(0,0)点作为src图的坐标基点；
5. 将src图拖拽到dst画布中，然后将src的坐标基点对齐dst图的坐标基点；
6. 调整src图的宽度到与dst相同的宽度；并且调整src图的高度到与dst相同的高度；
7. 将成品图保存成文件；
8. 关闭dst画布资源；
9. 关闭src画布资源；

#### 代码实现

创建名为code15.php的程序文件，代码如下：

```php
<?php

#1. 根据目标缩略图的尺寸创建一个空白画布（dst）（200×300）；
//$dst = imagecreate(200, 300);  //色彩失真太大了
$dst = imagecreatetruecolor(200, 300);

#2. 将需要缩小的那张图片（src）打开成一个画布；
$src = imagecreatefromjpeg('./source/m3.jpg');
$src_w = imagesx($src);//源图宽，用于后续参数
$src_h = imagesy($src);//源图高，用于后续参数

/*
#第3～6步
3. 在dst画布上选择左上角(0,0)点作为dst图的坐标基点；
4. 在src画布上选择左上角(0,0)点作为src图的坐标基点；
5. 将src图拖拽到dst画布中，然后将src的坐标基点对齐dst图的坐标基点；
6. 调整src图的宽度到与dst相同的宽度；并且调整src图的高度到与dst相同的高度；
*/
//imagecopyresampled — 重采样拷贝部分图像并调整大小
//如果源和目标的宽度和高度不同，则会进行相应的图像收缩和拉伸。
//(目标图，源图，目标X坐标，目标Y坐标，源图X坐标，源图Y坐标，目标宽，目标高，源图宽，源图高)
imagecopyresampled($dst, $src, 0, 0, 0, 0, 200, 300, $src_w, $src_h);

#7. 将成品图保存成文件；或输出到浏览器
header('Content-type:image/jpeg');
imagejpeg($dst);

#8.关闭dst画布资源
imagedestroy($dst);

#9.关闭src画布资源
imagedestroy($src);
```

访问code15.php的效果：

![1530174118370](29.png)

固定宽高的缩略图，可能导致缩小后图片变形的效果，所以我们还需要改进。

### 等比缩略图

1. 根据源图的宽高比创建目标缩略图的空白画布（dst）；
2. 将需要缩小的那张图片（src）打开成一个画布；
3. 在dst画布上选择左上角(0,0)点作为dst图的坐标基点；
4. 在src画布上选择左上角(0,0)点作为src图的坐标基点；
5. 将src图拖拽到dst画布中，然后将src的坐标基点对齐dst图的坐标基点；
6. 调整src图的宽度到与dst相同的宽度；并且调整src图的高度到与dst相同的高度；
7. 将成品图保存成文件；
8. 关闭dst画布资源；
9. 关闭src画布资源；



创建名为code16.php的程序文件，代码如下：

```php
<?php

#2. 将需要缩小的那张图片（src）打开成一个画布；
$src = imagecreatefromjpeg('./source/m3.jpg');
$src_w = imagesx($src);//src图的宽度
$src_h = imagesy($src);//src图的高度


#计算最终缩略图的宽度和高度
$max_w = 200;//定义限定区域的最大宽度
$max_h = 300;//定义限定区域的最大高度

//先缩小原图的高度到和限定区域的高度一样，然后按照原图的宽高比例来缩小宽度
$dst_h = $max_h;//缩小原图的高度到和限定区域的高度
/*
$src_w/$src_h = $dst_w/$dst_h;
$dst_w = ($src_w/$src_h)*$dst_h;
*/
$dst_w = ($src_w/$src_h)*$dst_h;//按照原图的宽高比例来缩小宽度

if( $dst_w>$max_w ){//如果经过第一轮缩小后，缩略图的宽度比限定区域的宽度还要大，说明不满足要求，需要重新再缩小计算一次

    //先缩小原图的宽度到和限定区域的宽度一样，然后按照原图的宽高比例来缩小高度
    $dst_w = $max_w;//缩小原图的宽度到和限定区域的宽度一样
    /*
    $src_w/$src_h = $dst_w/$dst_h;
    $dst_h = $dst_w/($src_w/$src_h)
    */
    $dst_h = $dst_w/($src_w/$src_h);//按照原图的宽高比例来缩小高度
}


#1. 根据源图的宽高比创建目标缩略图的空白画布（dst）；
//$dst = imagecreate(200, 300);
$dst = imagecreatetruecolor($dst_w, $dst_h);



/*
#第3～6步
3. 在dst画布上选择左上角(0,0)点作为dst图的坐标基点；
4. 在src画布上选择左上角(0,0)点作为src图的坐标基点；
5. 将src图拖拽到dst画布中，然后将src的坐标基点对齐dst图的坐标基点；
6. 调整src图的宽度到与dst相同的宽度；并且调整src图的高度到与dst相同的高度；
*/
imagecopyresampled($dst, $src, 0, 0, 0, 0, $dst_w, $dst_h, $src_w, $src_h);

#7. 将成品图保存成文件；或输出到浏览器
header('Content-type:image/jpeg');
imagejpeg($dst);

#8.关闭dst画布资源
imagedestroy($dst);

#9.关闭src画布资源
imagedestroy($src);
```

访问code16.php，效果为：

![1530176230852](30.png)



## 6. 案例：制作验证码

###   功能分析

1. 创建画布，填充背景色；
2. 在画布上随机字；
3. 在画布上构建干扰元素（干扰点，干扰线，干扰弧线）；



###   代码实现

创建名为code17.php的程序文件，代码如下：

```php
<?php

#1. 创建画布，填充背景色
$w = 300;
$h = 140;
$img = imagecreate($w, $h);

//填充颜色
$color = imagecolorallocate($img, mt_rand(0, 255), mt_rand(0, 255), mt_rand(0, 255));//分配一个随机色
imagefill($img, 0, 0, $color);

#写字
//构建随机字
$arr = array_merge(range('a', 'z'), range('A', 'Z'), range(0, 9));
$str = '';//最终随机字存储的变量
for($i=0; $i<4; $i++ ){ 
    $key = mt_rand(0, count($arr)-1);
    $str .= $arr[$key];
}
//写字
$color = imagecolorallocate($img, mt_rand(0, 255), mt_rand(0, 255), mt_rand(0, 255));//分配一个随机色
imagettftext($img, 40, 0, $w/4, $h*3/5, $color, 'F:/home/class/day5/code/source/font1.ttf', $str);

#构建干扰元素
//干扰点
for($i=0; $i<100; $i++ ){ 
    $bx = mt_rand(0, $w);//起点x坐标
    $by = mt_rand(0, $h);//起点y坐标

    $ex = mt_rand($bx-2, $bx+2);//终点x坐标
    $ey = mt_rand($by-2, $by+2);//终点y坐标

    $color = imagecolorallocate($img, mt_rand(0, 255), mt_rand(0, 255), mt_rand(0, 255));//分配一个随机色
    imageline($img, $bx, $by, $ex, $ey, $color);
}

//画干扰线
for($i=0; $i<10; $i++ ){ 
    $bx = mt_rand(0, $w/2);//起点x坐标
    $by = mt_rand(0, $h);//起点y坐标

    $ex = mt_rand($w/2, $w);//终点x坐标
    $ey = mt_rand(0, $h);//终点y坐标

    $color = imagecolorallocate($img, mt_rand(0, 255), mt_rand(0, 255), mt_rand(0, 255));//分配一个随机色
    imageline($img, $bx, $by, $ex, $ey, $color);
}


#输出到浏览器
header('Content-type:image/jpeg');
imagejpeg($img);
```

访问code17.php，效果为：

![1530178153757](31.png)



