---
title: GitHub  Blog架构
mathjax: false
categories:
  - Pre
typora-root-url: GitHubBlog
typora-copy-images-to: GitHubBlog
abbrlink: 3884487082
date: 2018-12-12 02:35:46
updated: 2018-12-12 02:35:51
tags:
top: 999
---

# GitHub  Blog架构

## 参考方案



### 环境配置

**博客程序** ： [hexo](https://hexo.io/zh-cn/)  -  静态站点生成器

**写作程序** ： [Typora](https://www.typora.io/)  -  makedown 编辑器

**持续集成** ： [Travis-ci](https://travis-ci.com)  - 用于构建项目的开源持续集成环境



### 项目规划

#### Blog仓库

Blog仓库名：`KumaNNN.github.io`

* 此为用户站点，通过各分支进行管理。

* **master**  ： 内容发布分支。

* **<blog\>**  ： blog源程序分支（以 blog源程序的名称命名，如 `Hexo`）

  * `source_md/<SubModules>`  ：内容源，子模块，拉取文档库中可引用的分支(默认：`md`)

    * 本地管理时，用子模块方式；
    * 集成环境，~~直接当作仓库管理~~  [Travis CI默认克隆git子模块](https://docs.travis-ci.com/user/customizing-the-build/#git-submodules)  ，且集成环境中并不需要操作此目录。

  * `source/_post`  ： hexo内容源，通过一定的脚本自动化将`source_md/<SubModules>`  的内容复制到此。

    * 因为hexo每次生成时都需要修改源文件，所有分开存放。 

  * `themes/<SubModules>  `  ：主题源，子模块，拉取主题库中的`MyMaster`分支。

  * `Script`  ： 脚本存放目录，存放相关的自定义脚本或钩子脚本。

  * `public`  ：  hexo发布目录。子模块(或git仓库)，已配置将其下内容发布到本仓库`master`分支。

    * 当作 子模块，易于管理，因为子模块提交记录不在当前分支。
    * 使用`hexo g`生成内容前，通常需要使用`hexo clean` 清除此文件夹及其内容，以确保更改达到预期效果。这样会将此文件夹下的版本数据库`.git`也删除，如果每次都初始化，将不能保留提交记录。
      * **本地**： 
        * 方案一：(当作git仓库时) 手动执行脚本，在其它地方克隆并检出`master` 分支，并复制`.git` 目录到`public`下。 
          * 会产生git嵌套，在管理上带来一定的麻烦，慎用。
          * 在线上，只提交了此文件夹的内容，而放弃其它内容，倒无所谓。
        * 方案二：(当作子模块时) 用脚本修复`public/.git` 文件。==使用中== 
        * 在不使用线上的 **持续集成** 时，可这样做。
        * 使用线上的 **持续集成** 时，放弃此子模块的提交。
      * **线上**： 已在配置文件中配置，可保留提交记录。
        * Travis-ci 根据配置，克隆并检出指定分支(`Hexo`) ，安装依赖，`hexo g`生成内容，在其它地方克隆并检出`master` 分支并复制`.git` 目录到`public`下，最后只提交并推送`public`下的内容到`master`分支，放弃其它内容。

    

#### 文档(子仓库)和主题

==修正==：**文档(子仓库)** 已采用单分支(`master`) ，子模块化到`source_md/<SubModules>` ，再通过脚本复制`source_md/<SubModules>/doc/md/*` 到 `source/<SubModules>/` 



**注意**： 文档和主题 ，可用组织进行管理

* 文档<组织名>： `KumaDocCenter`
  * 管理库[^1]： `KumaDocCenter.github.io`
  * 文档分库存储，~~特定目录（如，md）新建分支(`md`)，以便引用。~~  已采用单分支
  * ~~保持数据一致性：`md分支` 定期合并到master分支，或参考 [git从其他分支checkout文件到当前分支](#git从其他分支checkout文件到当前分支)。~~ 已采用单分支
* 主题<组织名>：`BlogThemes<blog源程序名称>`    如，`BlogThemesHexo`
  * 管理库[^1]： `BlogThemes<blog源程序名称>.github.io`     如，`BlogThemesHexo.github.io`
  * blog源程序的主题，Fork成独立库，以便管理。
  * 库命名格式：
    * `<username>_<blog源程序名称>_主题名称`
    * `<orgname>_<blog源程序名称>_主题名称`
  * 从`master`新建分支`mymaster`，作为自己的博客主题，所有配置在此分支。





## 工作流

注： ==推荐每个分支一个目录，而不是在同一目录切换分支==。

`staged`  :  暂存。在此脚本中通常用于待处理目录。



### 本地

#### 子仓库初始化

* 复制父项目下的`Start.bat`文件和`Script`文件夹到未初始化的子仓库，并运行`Start.bat`文件
* ~~修改某些子仓库的名称和git地址。嵌套领域可用`.`连结，如 `Apache.httpd`~~  已通过脚本实现
  * ~~需修改的文件：`*.add` `*.init` `*.del`  `*.updata`  `.git/config`~~ 已通过脚本实现
  * git嵌套： 可以忽略整个子目录
    * 因为文件夹已嵌套，且用`.`连结作为仓库名，已便于区分，才可以这样做。
    * 适用于，想把上级目录也用git管理的情景。
* 根据名称，建立远端仓库，并进行推送，以便子模块拉取。
* **多分支脚本流程**：
  1. 检测`.git` 文件，存在则退出脚本。不存在则继续执行脚本。
  2. 特定目录处理。
     * 一些不存在的目录会自动创建，如 `doc/md`  `doc/Readme`
  3. 空目录处理。
     * 因为git会自动忽略空目录。
     * 对于空目录，添加 .gitkeep 文件
  4. 仓库配置。
     * 初始化仓库，配置用户名，邮箱，添加远程仓库等等。
  5. 首次提交
     * 提交空白仓库，只包含 .gitignore 文件
     * 提交信息： `Commit_0 : init`
  6. 第2次提交 + 新建分支
     * 增加 doc/md 和 Script目录，并依此新建md分支
     * 提交信息： `Commit_1 : + doc/md/* and Script`
  7. 第3次提交
     * 添加所有文件
     * 提交信息：`Commit_2 : + All file`
  8. 复制钩子
     * ~~==提交钩子(post-commit)==~~  子仓库暂无
  9. YAML输出
  10. 输出子模块批处理配置文件
     * 手动复制此配置文件到其它地方。
  11. 结果输出
* **单分支脚本流程**：
  1. 检测`.git` 文件，存在则退出脚本。不存在则继续执行脚本。
  2. 特定目录处理。
     * 一些不存在的目录会自动创建，如 `doc/md`  `doc/Readme`
  3. 空目录处理。
     * 因为git会自动忽略空目录。
     * 对于空目录，添加 .gitkeep 文件
  4. 仓库配置。
     * 初始化仓库，配置用户名，邮箱，添加远程仓库等等。
  5. 首次提交
     * 提交空白仓库，只包含 .gitignore 文件
     * 提交信息： `Commit_0 : init`
  6. 第2次提交
     * 添加所有文件
     * 提交信息：`Commit_1 : + All file`
  7. 复制钩子
     * ~~==提交钩子(post-commit)==~~  子仓库暂无
  8. YAML输出
  9. 输出子模块批处理配置文件
    * 手动复制此配置文件到其它地方。
  10. 结果输出



**产生的文件有：**

* `init.log`  ： 仓库初始化日志，转移
  * 管理库： `data\SubRepo\init`
* `*.[Repo]add` `*.init` `*.[Repo]del`  `*.[Repo]updata`  ： 子模块批处理配置文件，转移
  * 父项目： `.git\myconf\submodule\staged`
  * 管理库： `data\SubRepo\conf`
* `doc/md/*.YAML`  ：(`md` 分支或`doc/md`) md 文件的YAML头，处理后删除
  * 将其内容复制到相应的md文件头部，然后删除此`*.YAML`文件，最后git提交。





#### 父项目添加子模块(子仓库)

* 运行脚本 `Script\sh\submodule_batch.bat` ，添加子模块。
* 子模块稀疏检出(`doc/md`)
* 复制钩子
  * ==提交钩子(post-commit)== ，在配置文件中已配置，脚本会自动复制此钩子。
* 脚本配置如下
  * 配置读取目录  ： `.git\myconf\submodule\staged` 
    * 从该目录下读取子模块批处理配置文件
  * 完成目录  ： `.git\myconf\submodule\ok`
    * 处理完毕后，将配置文件移动到此。
* 配置文件格式参考  `Script\sh\git_submodule\Template` 
* 注： 子模块git数据库在父项目下的.git目录下。





#### 写作在子仓库

* 完全可当做为普通git仓库来管理。
* (==单分支==)子仓库有`master`分支。
* (==多分支==)子仓库有`master`分支和`md` 分支。
  * `md` 分支源自`master`分支的`doc/md` ，最终需要将最新的数据合并到`master`分支，以作存储。
  * 所以`doc/md`的更改推荐在`md`分支下进行，然后定期合并到`master`分支
  * `master`分支==不能==合并到`md` 分支，会造成结构不符合当初预期。
  * 若需要从`master`分支检出`md` 分支所需的最新数据，可通过其它方法，如[git从其他分支checkout文件到当前分支](#git从其他分支checkout文件到当前分支)
* git提交并推送。





#### 写作在子模块

* 进入子模块，当做为普通git仓库来管理单分支。
* (==单分支==)子模块只检出`master` 分支，且==禁止==检出其它分支。
* (==多分支==)子模块只检出`md` 分支，且==禁止==检出其它分支。
  * `md` 分支源自`master`分支的`doc/md` ，最终需要将最新的数据合并到`master`分支，以作存储。
  * 所以`doc/md`的更改推荐在`md`分支下进行，然后定期合并到`master`分支
  * `master`分支==不能==合并到`md` 分支，会造成结构不符合当初预期。
  * 若需要从`master`分支检出`md` 分支所需的最新数据，可通过其它方法，如[git从其他分支checkout文件到当前分支](#git从其他分支checkout文件到当前分支)
* [可选] 手动执行`md.bat` 脚本，处理新增的md文件。
* git提交
* 触发==提交钩子(post-commit)== 
  * 写入`复制状态` 数据到子模块git数据库目录下。
* git推送。





#### 写作在父仓库TODO

> 可能某些内容并没有依赖子仓库，是在本项目中(`source/*`)，此时，就需要在父仓库中写在。

* 在父仓库 `source/*` 下更改内容 ，git提交并推送。
  * 使用线上持续集成时： 提交当前分支(`Hexo`) ，忽略`public` 子模块。
    * 需要配置，参考 [忽略submodule中的修改或新增文件](#忽略submodule中的修改或新增文件)。
  * 不使用线上持续集成时： 先提交`public`子模块，再提交当前分支(`Hexo`) 。
* git提交
* 触发==预提交钩子(pre-commit)==，
  * 修复public。
  * 调用脚本，读取配置(`copy.conf`) ，按需复制 `source_md/<SubModuleName>/doc/md/` 下的内容到 `source/_posts/Dev/<SubModuleName>` 。
  * ~~处理source/* md文件~~





### 线上

#### 使用 Travis-ci 持续集成TODO

已配置如下流程

* Travis-ci 检测仓库接收的推送。

  * 拉取博客程序分支(`Hexo`)
  * 安装依赖，`hexo g`生成内容
  * 在其它地方克隆并检出`master` 分支并复制`.git` 目录到`public`下
  * 最后只提交并推送`public`下的内容到`master`分支，放弃其它内容。

  



## Build

### bat脚本

* 子模块(子仓库)，==提交钩子(post-commit)==，写入数据到配置文件中（包含`状态`，`路径` 等信息）
* 父仓库(Hexo)，==预提交钩子(pre-commit)==   , for   读取（遍历）子仓库中配置文件的变量，根据status参数，直接执行相应的命令。

  



### shell 脚本

git钩子的shell脚本，用`#!/bin/sh` ，而大部分任务流有bat脚本完成。

根据shell脚本调用方式，最终选择 fork方式。

这样能保证shell后面的命令继续执行，但不能获取子 Shell 中的环境变量

> 如
>
> ```
> #!/bin/sh
> 
> ./out.bat $@
> echo AAAAA
> ```
>
> * $# 是传给脚本的参数个数
> * $0 是脚本本身的名字
> * $1 是传递给该shell脚本的第一个参数
> * $2 是传递给该shell脚本的第二个参数
> * $@ 是传给脚本的所有参数的列表



[Shell 脚本中调用另一个 Shell 脚本的三种方式](https://www.cnblogs.com/insane-Mr-Li/p/9095668.html) 

> 主要以下有几种方式：    
>
> | 命令   | 说明                                                         |
> | ------ | ------------------------------------------------------------ |
> | fork   | 新开一个子 Shell 执行，子 Shell 可以从父 Shell 继承环境变量，但是子 Shell 中的环境变量不会带回给父 Shell。<br />fork 是最普通的, 就是直接在脚本里面用 path/to/foo.sh 来调用 ，不需 fork 关键字 |
> | exec   | 在同一个 Shell 内执行，但是父脚本中 exec 行之后的内容就不会再执行了 |
> | source | 在同一个 Shell 中执行，在被调用的脚本中声明的变量和环境变量, 都可以在主脚本中进行获取和使用，相当于合并两个脚本在执行 |



### 涉及的命令

for

xcopy

```
xcopy 1\* 11 /eiy

/E           复制目录和子目录，包括空目录。
/I           如果目标不存在，且要复制多个文件，则假定目标必须是目录。
/Y           取消提示以确认要覆盖现有目标文件。
```

复制1目录下的所有，不包含隐藏文件夹，到 11 目录





----

## 参考阅读

[^1]: 管理组织内所有库，默认为 `<orgname>.github.io`  ，`<orgname>`不用下划线等特殊字符

[把 git 仓库的子目录独立成新仓库](https://segmentfault.com/a/1190000012277504)

[Git 仓库拆拆拆](https://segmentfault.com/a/1190000002548731)




> ### git从其他分支checkout文件到当前分支
>
> 使用场景，把当前分支的某个文件替换为其他分支的文件
>
> 执行命令
>
> ```git
> git checkout <branch name> -- path
> ```
>
> path 就是你想要替换的目录或文件



> ### 忽略submodule中的修改或新增文件
>
> 我们要做的就是在`.gitmodules`的`[submodule “ProjectName”]`中添加一个`ignore`子项，这个ignore子项可以有3个可选的值，`untracked`, `dirty`和`all`, 它们的意思分别是：
>
> * **untracked** ：忽略 在子模块 新添加的，未受版本控制内容
> * **dirty** ： 忽略对\<ProjectName>目录下受版本控制的内容进行了修改
> * **all** ： 同时忽略untracked和dirty