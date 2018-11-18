---
title: 【转载】最全Hexo博客搭建+主题优化+插件配置+常用操作+错误分析
mathjax: true
tags:
  - hexo
typora-root-url: hexo-tutorial
typora-copy-images-to: hexo-tutorial
categories:
  - hexo
abbrlink: 1353166163
date: 2018-11-13 18:59:23
updated: 2018-11-13 18:59:29
---



### 前言

> **原作者：** TDsimon
>
> **转载来源：** <https://www.simon96.online/2018/10/12/hexo-tutorial/>
>
> **版权声明：** 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) 许可协议。转载请注明出处！



### 博客搭建

#### 准备环境

1. [Node.js](http://nodejs.org/) 下载，并安装。详细步骤：<https://www.simon96.online/2018/11/10/hexo-env/>

2. [Git](http://git-scm.com/) 下载，并安装。详细步骤：<https://www.simon96.online/2018/11/10/hexo-env/>

3. 安装Hexo，在命令行（即Git Bash）运行以下命令：

   > npm install -g hexo-cli

4. 初始化Hexo，在命令行（即Git Bash）依次运行以下命令即可：

   以下，即存放Hexo初始化文件的路径， 即站点目录。

   ```
   $ hexo init <folder>
   $ cd <folder>
   $ npm install
   ```

   新建完成后，在路径下，会产生这些文件和文件夹：

   ```
   .
   ├── _config.yml
   ├── package.json
   ├── scaffolds
   ├── source
   |   ├── _drafts
   |   └── _posts
   └── themes
   ```

   **注**：

   * hexo相关命令均在**站点目录**下，用**Git Bash**运行。

   * 站点配置文件：站点目录下的`_config.yml`。

      路径为`<folder>\_config.yml`

   * 主题配置文件：站点目录下的`themes`文件夹下的，主题文件夹下的`_config.yml`。

      路径为`<folder>\themes\<主题文件夹>\_config.yml`

5. 启动服务器。在路径下，命令行（即Git Bash）输入以下命令，运行即可：

   > hexo server

6. 浏览器访问网址： `http://localhost:4000/`

至此，您的Hexo博客已经搭建在本地。



#### 实施方案

##### 方案一：GithubPages

1. 创建[Github](https://github.com/)账号

2. 创建仓库， 仓库名为：<Github账号名称>.github.io

3. 将本地Hexo博客推送到GithubPages

   3.1. 安装`hexo-deployer-git`插件。在命令行（即Git Bash）运行以下命令即可：

   ```
   $ npm install hexo-deployer-git --save
   ```

   3.2. 添加SSH key。

   * 创建一个 SSH key 。在命令行（即Git Bash）输入以下命令， 回车三下即可：

     ```
     $ ssh-keygen -t rsa -C "邮箱地址"
     ```

   * 添加到 github。 复制密钥文件内容（路径形如`C:\Users\Administrator\.ssh\id_rsa.pub`），粘贴到[New SSH Key](https://github.com/settings/keys)即可。

   * 测试是否添加成功。在命令行（即Git Bash）依次输入以下命令，返回“You’ve successfully authenticated”即成功：

     ```
     $ ssh -T git@github.com
     $ yes
     ```

   3.3. 修改`_config.yml`（在站点目录下）。文件末尾修改为：

   ```
   # Deployment
   ## Docs: https://hexo.io/docs/deployment.html
   deploy:
     type: git
     repo: git@github.com:<Github账号名称>/<Github账号名称>.github.io.git
     branch: master
   ```

   注意：上面仓库地址写ssh地址，不写http地址。

   3.4. 推送到GithubPages。在命令行（即Git Bash）依次输入以下命令， 返回`INFO Deploy done: git`即成功推送：

   ```
   $ hexo g
   $ hexo d
   ```

4. 等待1分钟左右，浏览器访问网址： `https://<Github账号名称>.github.io`

至此，您的Hexo博客已经搭建在GithubPages, 域名为`https://<Github账号名称>.github.io`。

##### 方案二：GithubPages + 域名

在方案一的基础上，添加自定义域名（您购买的域名）。

1. 域名解析。

   类型选择为 CNAME；

   主机记录即域名前缀，填写为www；

   记录值填写为自定义域名；

   解析线路，TTL 默认即可。

2. 仓库设置。

   2.1. 打开博客仓库设置：`https://github.com/<Github账号名称>/<Github账号名称>.github.io/settings`

   2.2. 在Custom domain下，填写自定义域名，点击`save`。

   2.3. 在站点目录的`source`文件夹下，创建并打开`CNAME.txt`，写入你的域名（如`www.simon96.online`），保存，并重命名为`CNAME`。

3. 等待10分钟左右。

   浏览器访问自定义域名。

   至此，您的Hexo博客已经解析到自定义域名，`https://<Github账号名称>.github.io`依然可用。

##### 方案三：GithubPages + CodingPages + 域名

GithubPages 在国内较慢，百度不收录，而CodingPages 在国外较快。所以在方案二的基础上，添加CodingPages 。

1. 创建[Coding](https://coding.net/)账号

2. 创建仓库， 仓库名为：<Coding账号名称>

3. 进入项目里『代码』页面，点击『一键开启静态 Pages』，稍等片刻CodingPages即可部署成功。

4. 将本地Hexo博客推送到CodingPages

   4.1. 鉴于创建GithubPages 时，已经生成过公钥。可直接复制密钥文件内容（路径形如`C:\Users\Administrator\.ssh\id_rsa.pub`）， 粘贴到[新增公钥](https://dev.tencent.com/user/account/setting/keys)。

   4.2. 测试是否添加成功。在命令行（即Git Bash）依次输入以下命令，返回“You’ve successfully authenticated”即成功：

   ```
   $ ssh -T git@git.coding.net
   $ yes
   ```

   4.3. 修改`_config.yml`（在存放Hexo初始化文件的路径下）。文件末尾修改为：

   ```
   # Deployment
   ## Docs: https://hexo.io/docs/deployment.html
   deploy:
   - type: git
     repo: git@github.com:<Github账号名称>/<Github账号名称>.github.io.git
     branch: master
   - type: git
     repo: git@git.dev.tencent.com:<Coding账号名称>/<Coding账号名称>.git
     branch: master
   ```

   4.4. 推送到GithubPages。在命令行（即Git Bash）依次输入以下命令， 返回`INFO Deploy done: git`即成功推送：

   ```
   $ hexo g
   $ hexo d
   ```

5. 域名解析

   1. 添加 CNAME 记录指向 <Coding账号名称>.coding.me

      类型选择为 CNAME；

      主机记录即域名前缀，填写为www；

      记录值填写为自定义域名；

      解析线路，TTL 默认即可。

   2. 添加 两条A 记录指向 192.30.252.153和192.30.252.154

      类型选择为 A；

      主机记录即域名前缀，填写为@；

      记录值填写为192.30.252.153和192.30.252.154；

      解析线路，境外或谷歌。

   3. 在『Pages 服务』设置页（`https://dev.tencent.com/u/<Coding账号名称>/p/<Coding账号名称>/git/pages/settings`）中绑定自定义域名。

至此，您的Hexo博客已经解析到自定义域名，`https://<Github账号名称>.github.io`和`https://<Coding账号名称>.coding.me`依然可用。

##### 方案四：云服务器 + 域名

该方案需要先购买云服务器和域名。

1. 在云服务器安装Git 和 Nginx。(Git 用于版本管理和部署，Nginx 用于静态博客托管。)

   登陆root用户，运行：

   ```
   $ yum -y update
   $ yum install -y git nginx
   ```

2. Nginx配置

   2.1. 创建文件目录(用于博客站点文件存放)

   ```
   cd /usr/local/
   mkdir hexo
   chmod 775 -R /usr/local/hexo/
   ```

   2.2. 添加 index.html(用于检测配置 Nginx 是否成功)

   ```
   vim /usr/local/hexo/index.html
   ```

   添加以下代码，并保存。

   ```
   <!DOCTYPE html>
   <html>
     <head>
       <title></title>
       <meta charset="UTF-8">
     </head>
     <body>
       <p>Nginx running</p>
     </body>
   </html>
   ```

   2.3. 配置 Nginx 服务器

   ```
   vim /etc/nginx/nginx.conf
   ```

   修改server_name和root：

   ```
   server {
         listen       80 default_server;
         listen       [::]:80 default_server;
         server_name  www.baidu.com; # 填个人域名      
         root         /usr/local/hexo/;
     }
   ```

   2.4. 启动nginx服务；

   ```
   service nginx start
   ```

   2.5. 云服务器浏览器访问个人域名或IP，若跳转index.html，则配置完成，否则检查以上配置。

3. git配置

   3.1. 创建文件目录, 用于私人 Git 仓库搭建, 并更改目录读写权限。

   ```
   cd /usr/local/
   mkdir hexoRepo
   chmod 775 -R /usr/local/hexoRepo/
   ```

   3.2. Git 初始化裸库。

   ```
   cd hexoRepo/
   git init --bare hexo.git
   ```

   3.3. 创建 Git 钩子(hook)。

   ```
   vim /usr/local/hexoRepo/hexo.git/hooks/post-receive
   ```

   3.4. 输入以下信息，用于指定 Git 的源代码 和 Git 配置文件。

   ```
   #!/bin/bash
   
   git --work-tree=/usr/local/hexo --git-dir=/usr/local/hexoRepo/hexo.git checkout -f
   ```

   3.5. 保存并退出后, 给该文件添加可执行权限。

   ```
   chmod +x /usr/local/hexoRepo/hexo.git/hooks/post-receive
   ```

4. 本地博客推送到云服务器

   4.1. 安装`hexo-deployer-git`插件。在命令行（即Git Bash）运行以下命令即可：

   ```
   $ npm install hexo-deployer-git --save
   ```

   4.2. 添加SSH key。

   * 创建一个 SSH key 。在命令行（即Git Bash）输入以下命令， 回车三下即可：

     ```
     $ ssh-keygen -t rsa -C "邮箱地址"
     ```

   * 添加到 github。 复制密钥文件内容（路径形如`C:\Users\Administrator\.ssh\id_rsa.pub`），粘贴到[New SSH Key](https://github.com/settings/keys)即可。

   * 测试是否添加成功。在命令行（即Git Bash）依次输入以下命令，返回“You’ve successfully authenticated”即成功：

     ```
     $ ssh -T git@github.com
     $ yes
     ```

   4.3. 修改`_config.yml`（在站点目录下）。文件末尾修改为：

   ```
   # Deployment
   ## Docs: https://hexo.io/docs/deployment.html
   deploy:
     type: git
     repo: root@xxx.xxx.xxx.xxx:/usr/local/hexoRepo/hexo  //用户名@域名或 IP 地址:/usr/local/hexoRepo/hexo
     branch: master
   ```

   注意：上面仓库地址写ssh地址，不写http地址。

   4.4. 推送到GithubPages。在命令行（即Git Bash）依次输入以下命令， 返回`INFO Deploy done: git`即成功推送：

   ```
   $ hexo g
   $ hexo d
   ```

5. 等待1分钟左右，浏览器访问个人域名。

   至此，您的Hexo博客已经搭建在云服务器, 域名为个人域名。



### 主题优化

#### 选择主题

Hexo默认的主题是landscape，推荐以下主题：

1. [snippet](https://github.com/shenliyang/hexo-theme-snippet#hexo-theme-snippet)
2. [Hiero](https://github.com/iTimeTraveler/hexo-theme-hiero#hiero)
3. [JSimple](https://github.com/tangkunyin/hexo-theme-jsimple#jsimple)
4. [BlueLake](https://github.com/chaooo/hexo-theme-BlueLake#bluelake)



#### 应用主题

1. 下载主题
2. 将下载好的主题文件夹，粘贴到站点目录的`themes`下。
3. 更改站点配置文件`_config.yml` 的theme字段，为主题文件夹的名称：

```
# Extensions
## Plugins: https://hexo.io/plugins/
## Themes: https://hexo.io/themes/
theme: <主题文件夹的名称>
```



#### 主题优化

以上主题都有比较详细的说明文档，本节主要解决主题优化的常见问题。

主题优化一般包括：

* **设置「RSS」**

* **添加「标签」页面**

* **添加「分类」页面**

* **设置「字体」**

  问题：引用国外字体镜像较慢。

  解决：可以改用国内的。将\themes\*\layout_partials\head external-fonts.swig文件中fonts.google.com改成fonts.lug.ustc.edu.cn。

* **设置「代码高亮主题」**

* **侧边栏社交链接**

  问题：图标哪里找？

  解决：[Font Awesome](https://fontawesome.com/icons?d=gallery)

* **开启打赏功能**

  问题：微信支付宝二维码不美观，规格不一。

  解决：[在线生成二维码](https://cli.im/weixin)

* **设置友情链接**

* **腾讯公益404页面**

* **站点建立时间**

* **订阅微信公众号**

* **设置「动画效果」**

  问题：慢，需要等待 JavaScript 脚本完全加载完毕后才会显示内容。
  解决：将主题配置文件`_config.yml`中，use_motion字段的值设为 `false` 来关闭动画。

* **设置「背景动画」**



主题优化还包括：

##### 添加背景图

在 themes/*/source/css/_custom/custom.styl 中添加如下代码：

```
body{
    background:url(/images/bg.jpg);
    background-size:cover;
    background-repeat:no-repeat;
    background-attachment:fixed;
    background-position:center;
}
```

##### 修改Logo字体

在 `themes/*/source/css/_custom/custom.styl` 中添加如下代码：

```
@font-face {
    font-family: Zitiming;
    src: url('/fonts/Zitiming.ttf');
}
.site-title {
    font-size: 40px !important;
	font-family: 'Zitiming' !important;
}
```

其中字体文件在 `themes/next/source/fonts` 目录下，里面有个 `.gitkeep` 的隐藏文件，打开写入你要保留的字体文件，比如我的是就是写入 `Zitiming.ttf` ，具体字库自己从网上下载即可。

##### 修改内容区域的宽度

编辑主题的 `source/css/_variables/custom.styl` 文件，新增变量：

```
// 修改成你期望的宽度
$content-desktop = 700px

// 当视窗超过 1600px 后的宽度
$content-desktop-large = 900px
```

##### 网站标题栏背景颜色

```
.site-meta {
  background: $blue; //修改为自己喜欢的颜色
}
```

##### 自定义鼠标样式

打开 `themes/*/source/css/_custom/custom.styl` ,在里面写下如下代码：

```
// 鼠标样式
  * {
      cursor: url("http://om8u46rmb.bkt.clouddn.com/sword2.ico"),auto!important
  }
  :active {
      cursor: url("http://om8u46rmb.bkt.clouddn.com/sword1.ico"),auto!important
  }
```

##### 文章加密访问

打开 `themes/*/layout/_partials/head.swig`文件,在 ``之前插入代码：

```
<script>
    (function(){
        if('{{ page.password }}'){
            if (prompt('请输入密码') !== '{{ page.password }}'){
                alert('密码错误');
                history.back();
            }
        }
    })();
</script>
```

写文章时加上`password: *`：

```
---
title: 2018
date: 2018-10-25 16:10:03
password: 123456
---
```

##### 实现点击出现桃心效果

1. 在`/themes/*/source/js/src`下新建文件`click.js`，接着把以下粘贴到`click.js`文件中。
   代码如下：

```
!function(e,t,a){function n(){c(".heart{width: 10px;height: 10px;position: fixed;background: #f00;transform: rotate(45deg);-webkit-transform: rotate(45deg);-moz-transform: rotate(45deg);}.heart:after,.heart:before{content: '';width: inherit;height: inherit;background: inherit;border-radius: 50%;-webkit-border-radius: 50%;-moz-border-radius: 50%;position: fixed;}.heart:after{top: -5px;}.heart:before{left: -5px;}"),o(),r()}function r(){for(var e=0;e<d.length;e++)d[e].alpha<=0?(t.body.removeChild(d[e].el),d.splice(e,1)):(d[e].y--,d[e].scale+=.004,d[e].alpha-=.013,d[e].el.style.cssText="left:"+d[e].x+"px;top:"+d[e].y+"px;opacity:"+d[e].alpha+";transform:scale("+d[e].scale+","+d[e].scale+") rotate(45deg);background:"+d[e].color+";z-index:99999");requestAnimationFrame(r)}function o(){var t="function"==typeof e.onclick&&e.onclick;e.onclick=function(e){t&&t(),i(e)}}function i(e){var a=t.createElement("div");a.className="heart",d.push({el:a,x:e.clientX-5,y:e.clientY-5,scale:1,alpha:1,color:s()}),t.body.appendChild(a)}function c(e){var a=t.createElement("style");a.type="text/css";try{a.appendChild(t.createTextNode(e))}catch(t){a.styleSheet.cssText=e}t.getElementsByTagName("head")[0].appendChild(a)}function s(){return"rgb("+~~(255*Math.random())+","+~~(255*Math.random())+","+~~(255*Math.random())+")"}var d=[];e.requestAnimationFrame=function(){return e.requestAnimationFrame||e.webkitRequestAnimationFrame||e.mozRequestAnimationFrame||e.oRequestAnimationFrame||e.msRequestAnimationFrame||function(e){setTimeout(e,1e3/60)}}(),n()}(window,document);
```

1. 在`\themes\*\layout\_layout.swig`文件末尾添加：

```
<!-- 页面点击小红心 -->
<script type="text/javascript" src="/js/src/clicklove.js"></script>
```

##### 静态资源压缩

在站点目录下：

```
$ npm install gulp -g
```

安装gulp插件：

```
npm install gulp-minify-css --save
npm install gulp-uglify --save
npm install gulp-htmlmin --save
npm install gulp-htmlclean --save
npm install gulp-imagemin --save
```

在 `Hexo` 站点下新建 `gulpfile.js`文件，文件内容如下：

```
var gulp = require('gulp');
var minifycss = require('gulp-minify-css');
var uglify = require('gulp-uglify');
var htmlmin = require('gulp-htmlmin');
var htmlclean = require('gulp-htmlclean');
var imagemin = require('gulp-imagemin');
// 压缩css文件
gulp.task('minify-css', function() {
  return gulp.src('./public/**/*.css')
  .pipe(minifycss())
  .pipe(gulp.dest('./public'));
});
// 压缩html文件
gulp.task('minify-html', function() {
  return gulp.src('./public/**/*.html')
  .pipe(htmlclean())
  .pipe(htmlmin({
    removeComments: true,
    minifyJS: true,
    minifyCSS: true,
    minifyURLs: true,
  }))
  .pipe(gulp.dest('./public'))
});
// 压缩js文件
gulp.task('minify-js', function() {
    return gulp.src(['./public/**/.js','!./public/js/**/*min.js'])
        .pipe(uglify())
        .pipe(gulp.dest('./public'));
});
// 压缩 public/demo 目录内图片
gulp.task('minify-images', function() {
    gulp.src('./public/demo/**/*.*')
        .pipe(imagemin({
           optimizationLevel: 5, //类型：Number  默认：3  取值范围：0-7（优化等级）
           progressive: true, //类型：Boolean 默认：false 无损压缩jpg图片
           interlaced: false, //类型：Boolean 默认：false 隔行扫描gif进行渲染
           multipass: false, //类型：Boolean 默认：false 多次优化svg直到完全优化
        }))
        .pipe(gulp.dest('./public/uploads'));
});
// 默认任务
gulp.task('default', [
  'minify-html','minify-css','minify-js','minify-images'
]);
```

只需要每次在执行 `generate` 命令后执行 `gulp` 就可以实现对静态资源的压缩，压缩完成后执行 `deploy` 命令同步到服务器：

```
hexo g
gulp
hexo d
```

##### 修改访问URL路径

默认情况下访问URL路径为：`domain/2018/10/18/关于本站`,修改为 `domain/About/关于本站`。 编辑 `Hexo` 站点下的 `_config.yml` 文件，修改其中的 `permalink`字段：

```
permalink: :category/:title/
```

##### 博文置顶

1. 安装插件

   ```
   $ npm uninstall hexo-generator-index –save
   $ npm install hexo-generator-index-pin-top –save
   ```

   然后在需要置顶的文章的Front-matter中加上top即可：

   ```
   ---
   title: 2018
   date: 2018-10-25 16:10:03
   top: 10
   ---
   ```

2. 设置置顶标志

   打开：/themes/*/layout/_macro/post.swig，定位到`<div class="post-meta">`标签下，在此便签下行，插入如下代码：

   ```yaml
   {% if post.top %}
     <i class="fa fa-thumb-tack"></i>
     <font color=7D26CD>置顶</font>
     <span class="post-meta-divider">|</span>
   {% endif %}
   ```

   

##### 在右上角或者左上角实现fork me on github

1. 选择样式[GitHub Ribbons](https://blog.github.com/2008-12-19-github-ribbons/),
2. 修改图片跳转链接,将`<a href="https://github.com/you">`中的链接换为自己Github链接：
3. 打开 `themes/next/layout/_layout.swig` 文件，把代码复制到`<div class="headband"></div>`下面。

##### 主页文章添加边框阴影效果

打开 `themes/*/source/css/_custom/custom.styl` ,向里面加代码:

```
// 主页文章添加阴影效果
.post {
   margin-top: 0px;
   margin-bottom: 60px;
   padding: 25px;
   -webkit-box-shadow: 0 0 5px rgba(202, 203, 203, .5);
   -moz-box-shadow: 0 0 5px rgba(202, 203, 204, .5);
}
```

##### 显示当前浏览进度

修改`themes/*/_config.yml`，把 `false` 改为 `true`：

```
# Back to top in sidebar
b2t: true

# Scroll percent label in b2t button
scrollpercent: true
```

##### 创建分类页

在终端窗口下，定位到 `Hexo` 站点目录下，新建：

```
$ cd <站点目录>
$ hexo new page categories
```

##### 加入 广告

主要有两种：[百度SSP](https://ssp.baidu.com/static/register.html)和[谷歌Adsense](https://www.google.com/adsense/start/#/?modal_active=none)。方法类似：

1. 注册，复制广告代码

2. 部署到网站。

   2.1. 新建 `theme/*/layout/_custom/google_ad.swig`，将 AdSense 上的代码粘贴进去

   2.2. 头部。在 `theme/*/layout/_custom/head.swig` 中也粘贴一份

   2.3. 每篇博客。在 `theme/*/layout/post.swig` 里中在希望看到的地方加上：

   ```
   {% include '_custom/google_ad.swig' %}
   ```

   例如：在 `<div id="posts" class="posts-expand"> </div>` 中间插入，总代码如下：

   ```
   {% block content %}
     <div id="posts" class="posts-expand">
       {{ post_template.render(page) }}
       {% include '_custom/google_ad.swig' %}
     </div>
   {% endblock %}
   ```

3. 等待审核通过。如果失败，可再次申请。

##### 添加萌萌哒

1. 安装插件

   ```
   npm install --save hexo-helper-live2d
   ```

2. 复制你喜欢的模型名字：

   Epsilon2.1

   [![img](Epsilon2.1.gif)](https://huaji8.top/img/live2d/Epsilon2.1.gif)

   Gantzert_Felixander

   [![img](Gantzert_Felixander.gif)](https://huaji8.top/img/live2d/Gantzert_Felixander.gif)

   haru

   [![img](haru.gif)](https://huaji8.top/img/live2d/haru.gif)

   miku

   [![img](miku.gif)](https://huaji8.top/img/live2d/miku.gif)

   ni-j

   [![img](ni-j.gif)](https://huaji8.top/img/live2d/ni-j.gif)

   nico

   [![img](nico.gif)](https://huaji8.top/img/live2d/nico.gif)

   nietzche

   [![img](nietzche.gif)](https://huaji8.top/img/live2d/nietzche.gif)

   nipsilon

   [![img](nipsilon.gif)](https://huaji8.top/img/live2d/nipsilon.gif)

   nito

   [![img](nito.gif)](https://huaji8.top/img/live2d/nito.gif)

   shizuku

   [![img](shizuku.gif)](https://huaji8.top/img/live2d/shizuku.gif)

   tsumiki

   [![img](tsumiki.gif)](https://huaji8.top/img/live2d/tsumiki.gif)

   wanko

   [![img](wanko.gif)](https://huaji8.top/img/live2d/wanko.gif)

   z16

   [![img](z16.gif)](https://huaji8.top/img/live2d/z16.gif)

   hibiki

   [![img](hibiki.gif)](https://huaji8.top/img/live2d/hibiki.gif)

   koharu

   [![img](koharu.gif)](https://huaji8.top/img/live2d/koharu.gif)

   haruto

   [![img](haruto.gif)](https://huaji8.top/img/live2d/haruto.gif)

   Unitychan

   [![img](Unitychan.gif)](https://huaji8.top/img/live2d/Unitychan.gif)

   tororo

   [![img](tororo.gif)](https://huaji8.top/img/live2d/tororo.gif)

   hijiki

   [![img](hijiki.gif)](https://huaji8.top/img/live2d/hijiki.gif)

3. 将以下代码添加到主题配置文件`_config.yml`，修改<你喜欢的模型名字>：

   ```
   live2d:
     enable: true
     scriptFrom: local
     pluginRootPath: live2dw/
     pluginJsPath: lib/
     pluginModelPath: assets/
     tagMode: false
     log: false
     model:
       use: live2d-widget-model-<你喜欢的模型名字>
     display:
       position: right
       width: 150
       height: 300
     mobile:
       show: true
   ```

4. 建配置文件

   4.1. 在站点目录下建文件夹`live2d_models`，

   4.2. 再在`live2d_models`下建文件夹`<你喜欢的模型名字>`,

   4.3. 再在`<你喜欢的模型名字>`下建json文件：<你喜欢的模型名字>.model.json

5. 安装模型。在命令行（即Git Bash）运行以下命令即可：

   > npm install –save live2d-widget-model-<你喜欢的模型名字>

6. 在命令行（即Git Bash）运行以下命令， 在`http://127.0.0.1:4000/`查看测试结果:

   > hexo clean && hexo g && hexo s



### 插件配置

以下插件（评论系统、数据统计与分析、内容分享服务、搜索服务）各选一个即可。

#### 评论系统

|                                             | 推荐指数 | 优点                        | 缺点               |
| ------------------------------------------- | -------- | --------------------------- | ------------------ |
| [Valine](https://valine.js.org/)            | 4        | 每天30000条评论，10GB的储存 | 作者评论无标识     |
| [来必力/livere](https://livere.com/)        | 4        | 多种账号登录                | 评论无法导出       |
| [畅言](http://changyan.kuaizhan.com/)       | 3        | 美观                        | 必须备案域名       |
| [gitment](https://github.com/imsun/gitment) | 3        | 简洁                        | 只能登陆github评论 |
| Disqus                                      | 1        |                             | 需要翻*墙          |

##### Valine

1.1. 获取APP ID 和 APP Key

请先登录或注册 [LeanCloud](https://leancloud.cn/), 进入控制台后点击左下角创建应用，

进入刚刚创建的应用，选择左下角的`设置`>`应用Key`，然后就能看到你的`APP ID`和`APP Key`了。

1.2. 填写APP ID 和 APP Key到主题配置文件`_config.yml`

1.3. 运行`hexo g&&hexo d`推送到博客。

##### 来必力/livere

2.1. 登陆 [来必力](https://livere.com/) 获取你的 LiveRe UID。

2.2. 填写LiveRe UID到主题配置文件`_config.yml`

##### 畅言

3.1.获取APP ID 和 APP Key

请先登录或注册 [畅言](http://changyan.kuaizhan.com/), 点击“立即免费获取畅言”，

新建站点，点击管理，点击评论插件>评论管理，

点击后台总览，然后就能看到你的`APP ID`和`APP Key`了。

3.2. 填写APP ID 和 APP Key到主题配置文件`_config.yml`

3.3. 运行`hexo g&&hexo d`推送到博客。

##### gitment

4.1. 安装插件：

> npm i –save gitment

4.2. 申请应用

在[New OAuth App](https://github.com/settings/applications/new)为你的博客应用一个密钥:

```
Application name:随便写
Homepage URL:这个也可以随意写,就写你的博客地址就行
Application description:描述,也可以随意写
Authorization callback URL:这个必须写你的博客地址
```

4.3. 配置

编辑主题配置文件`themes/*/_config.yml`:

```
# Gitment
# Introduction: https://imsun.net/posts/gitment-introduction/
gitment:
  enable: true
  mint: true # RECOMMEND, A mint on Gitment, to support count, language and proxy_gateway
  count: true # Show comments count in post meta area
  lazy: false # Comments lazy loading with a button
  cleanly: false # Hide 'Powered by ...' on footer, and more
  language: # Force language, or auto switch by theme
  github_user: {you github user id}
  github_repo: 公开的git仓库,评论会作为那个项目的issue
  client_id: {刚才申请的ClientID}
  client_secret: {刚才申请的Client Secret}
  proxy_gateway: # Address of api proxy, See: https://github.com/aimingoo/intersect
  redirect_protocol: # Protocol of redirect_uri with force_redirect_pro
```

##### Disqus

编辑 主题配置文件`themes/*/_config.yml`， 将 disqus 下的 enable 设定为 true，同时提供您的 shortname。count 用于指定是否显示评论数量。

```
disqus:
  enable: false
  shortname:
  count: true
```

#### 数据统计与分析

|                                                   | 推荐指数 | 优点                                           | 缺点   |
| ------------------------------------------------- | -------- | ---------------------------------------------- | ------ |
| [不蒜子](http://ibruce.info/2015/04/04/busuanzi/) | 4        | 可直接将访问次数显示在您在网页上（也可不显示） | 只计数 |
| 百度统计                                          | 3        |                                                | 收录慢 |

##### 不蒜子

编辑 主题配置文件 `themes/*/_config.yml`中的`busuanzi_count`的配置项即可。

* 当`enable: true`时，代表开启全局开关。
* 若`site_uv`（本站访客数）、`site_pv`（本站访客数）、`page_pv`（本文总阅读量）的值均为`false`时，不蒜子仅作记录而不会在页面上显示。

注意：

```
不蒜子官方因七牛强制过期原有的『dn-lbstatics.qbox.me』域名（预计2018年10月初），与客服沟通数次无果，即使我提出为此付费也不行，只能更换域名到『busuanzi.ibruce.info』！
```

解决办法：

1. 找到主题调用不蒜子的swig文件。一般在”\themes*\layout_third-party\analytics\busuanzi-counter.swig”

2. 更改域名

   ```
   把原有的：
   <script async src="//dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>
   域名改一下即可：
   <script async src="//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
   ```

##### 百度统计

1. 登录 [百度统计](http://tongji.baidu.com/)，定位到站点的代码获取页面

2. 复制统计脚本 id，如图：

   [![img](analytics-baidu-id.png)](http://theme-next.iissnan.com/uploads/five-minutes-setup/analytics-baidu-id.png)

3. 编辑 主题配置文件`themes/*/_config.yml`，修改字段 `google_analytics`，值设置成你的统计脚本 id。

#### 内容分享服务

|                                                              | 推荐指数 | 优点 | 缺点                          |
| ------------------------------------------------------------ | -------- | ---- | ----------------------------- |
| [百度分享](http://share.baidu.com/)                          | 4        | 稳定 | 不太美观                      |
| [need-more-share2](https://github.com/revir/need-more-share2) | 4        | 美观 | 更新不及时（比如微信分享API） |

##### 百度分享

编辑 主题配置文件，添加/修改字段 `baidushare`，值为 `true`即可。

```
# 百度分享服务
baidushare: true
```

##### need-more-share2

编辑 主题配置文件，添加/修改字段 `needmoreshare2`，值为 `true`即可。

```
needmoreshare2:
  enable: true
```

#### 搜索服务

|              | 推荐指数 | 优点     | 缺点   |
| ------------ | -------- | -------- | ------ |
| Local Search | 4        | 配置方便 |        |
| Swiftype     | 2        |          | 需注册 |
| Algolia      | 2        |          | 需注册 |

##### Local Search

添加百度/谷歌/本地 自定义站点内容搜索

1. 安装 `hexo-generator-searchdb`，在站点的根目录下执行以下命令：

   ```
   $ npm install hexo-generator-searchdb --save
   ```

2. 编辑 站点配置文件，新增以下内容到任意位置：

   ```
   search:
     path: search.xml
     field: post
     format: html
     limit: 10000
   ```

3. 编辑 主题配置文件，启用本地搜索功能：

   ```
   # Local search
   local_search:
     enable: true
   ```

### 错误分析

如果你使用Hexo遇到同样的问题,这里有一些常见问题的解决方案。

#### YAML Parsing Error

```
JS-YAML: incomplete explicit mapping pair; a key node is missed at line 18, column 29:
      last_updated: Last updated: %s
```

1. 参数中包含冒号，请用加引号，如`Last updated: %s`

```
JS-YAML: bad indentation of a mapping entry at line 18, column 31:
      last_updated："Last updated: %s"
```

1. 字段后面的冒号必须为**英文冒号**，如：last_updated:
2. 字段冒号后面必须跟一个空格，如：last_updated: “Last updated: %s”

#### EMFILE Error

```
Error: EMFILE, too many open files
```

生成大量的文件时，可能遇到EMFILE错误。

可以运行以下命令来增加允许同步I / O操作的数量。

```
$ ulimit -n 10000
```

#### Process Out of Memory

当`hexo g`时，遇到以下错误：

```
FATAL ERROR: CALL_AND_RETRY_LAST Allocation failed - process out of memory
```

如下，更改`hexo-cli`文件的第一行，来增大nodejs堆内存.该bug已在[新版本](https://github.com/hexojs/hexo/issues/1735)修复。

```
#!/usr/bin/env node --max_old_space_size=8192
```

#### Git Deployment Problems

1. **RPC failed**

   ```
   error: RPC failed; result=22, HTTP code = 403
   
   fatal: 'username.github.io' does not appear to be a git repository
   ```

   确保你有你的电脑上设置git正确或尝试使用HTTPS存储库URL。

1. **Error: ENOENT: no such file or directory**

这个需要有一定的git的知识，因为可能是由于写错了标签,类别,或文件名，导致本地和github冲突了，Git不能自动合并这一变化所以它打破了自动分支。

**解决办法：**

1. 检查文章的标签和类别,确保本地和github上是相同的。
2. 合并分支（Commit）。
3. 清除，重构。在站点目录下，命令行（即Git Bash）运行`hexo clean`和`hexo g`
4. 手动将站点目录下的`public`文件夹复制到您的桌面
5. 从你的master分支切换到部署在本地分支。
6. 从桌面复制`public`文件夹到本地分支。
7. 合并分支到github（Commit）。
8. 切回master分支。

#### Server Problems

```
Error: listen EADDRINUSE
```

你可能使用相同的端口，同时开启了两个Hexo服务器。如果需要同时开启，可以尝试修改端口设置：

```
$ hexo server -p 5000
```

#### Plugin Installation Problems

```
npm ERR! node-waf configure build
```

这个错误可能发生在试图安装一个用Cc++或另一个javascript语言编写的插件。确保您已经安装了正确的编译器在您的计算机上。

#### Error with DTrace (Mac OS X)

```
{ [Error: Cannot find module './build/Release/DTraceProviderBindings'] code: 'MODULE_NOT_FOUND' }
{ [Error: Cannot find module './build/default/DTraceProviderBindings'] code: 'MODULE_NOT_FOUND' }
{ [Error: Cannot find module './build/Debug/DTraceProviderBindings'] code: 'MODULE_NOT_FOUND' }
```

DTrace安装可能有问题，重装:

```
$ npm install hexo --no-optional
```

详见 [#1326](https://github.com/hexojs/hexo/issues/1326#issuecomment-113871796)

#### Iterate Data Model on Jade or Swig

Hexo使用仓库的数据模型。这不是一个数组,所以你可能需要将对象转换为iterable。

```
{% for post in site.posts.toArray() %}
{% endfor %}
```

#### Data Not Updated

一些数据不能更新或新生成的文件的最后一个版本完全相同。清理缓存，再试一次：

```
$ hexo clean
```

#### No command is executed

那个不能使用除`help`、`init`和`version`以外的命令行（即Git Bash）时, 有可能时站点目录下的`package.json`文件，缺少`hexo` ，如下:

```
{
  "hexo": {
    "version": "3.2.2"
  }
}
```

#### Escape Contents

Hexo使用Nunjucks渲染的页面. `{ { } }`或`{ % % }`将解析和可能会引起麻烦， 如果要在博文中出现，必须使用三引号：

```
Hello {{ sensitive }}
```

```
#### ENOSPC Error (Linux)

如果运行命令`$ hexo server` 返回一个错误:
Error: watch ENOSPC …
可以通过运行`$ npm dedupe`或者以下命令行（即Git Bash）：
$ echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
来增加测试时，你可以看见的文件数量。
```



```
#### EMPERM Error (Windows Subsystem for Linux)

如果在Windows Subsystem for Linux，运行命令`$ hexo server` 返回这个错误:
Error: watch /path/to/hexo/theme/ EMPERM

因为目前在Windows Subsystem for Linux中，有些内容更改时，还不能实时更新到hexo服务器。
所以需要重新编译，再启动服务器：
$ hexo generate
$ hexo server -s
```



```
#### Template render error

有时运行命令`$ hexo generate` 返回一个错误:
FATAL Something’s wrong. Maybe you can find the solution here: http://hexo.io/docs/troubleshooting.html
Template render error: (unknown path)

这意味着有些认不出来单词在你的文件，并且很可能在你的新博文,或者配置文件`_config.yml`中，比如缩进错误：
```



### 常用操作

#### 创建文章

命令：

```
$ hexo new [layout] <title>
```

参数说明：

* [layout]可以为以下三种：

| 参数名 | 功能                    | 文章路径       |
| ------ | ----------------------- | -------------- |
| post   | 新建博文                | source/_posts  |
| page   | 新建页面（如404，分类） | source         |
| draft  | 草稿                    | source/_drafts |

草稿可通过一下命令发布：

```
$ hexo publish [layout] <title>
```

* title注意：

  不是博文标题，

  是博文markdown文件的名字，

  也是博文链接的后缀（如`https://www.simon96.online/2018/10/12/hexo-tutorial/`中的hexo-tutorial）

#### 文章模版

* 创建模版

  在新建文章时，Hexo 会根据 `scaffolds` 文件夹内相对应的文件来建立文件，例如：

  ```
  $ hexo new blog “simon”
  ```

   在执行这行指令时，Hexo 会尝试在 `scaffolds` 文件夹中寻找 `blog.md`，并根据其内容建立文章。

* 修改参数

  以下是您可以在模版中使用的变量：

| 变量   | 描述         |
| ------ | ------------ |
| layout | 布局         |
| title  | 标题         |
| date   | 文件建立日期 |

#### Front-matter

就是博文最上方以 `---` 分隔的那部分。

默认可以使用的Front-matter：

| 参数         | 描述                 | 默认值       |
| ------------ | -------------------- | ------------ |
| `layout`     | 布局                 |              |
| `title`      | 标题                 |              |
| `date`       | 建立日期             | 文件建立日期 |
| `updated`    | 更新日期             | 文件更新日期 |
| `comments`   | 开启文章的评论功能   | true         |
| `tags`       | 标签（不适用于分页） |              |
| `categories` | 分类（不适用于分页） |              |
| `permalink`  | 覆盖文章网址         |              |

------



