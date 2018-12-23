---
title: docker技术
date: 2018-12-18 12:30:37
updated: 2018-12-18 12:30:37 
mathjax: false
categories: 
tags:
typora-root-url: docker
typora-copy-images-to: docker
top: 
---


# docker 技术

## 简介

**Docker** 是一种容器虚拟化技术，使用Go 语言（golang 谷歌出的一门新的语言，目前也是最有发展潜力的语言，俗称21世纪的C语言，并且作者之一就是之前的C语言之父）（区块链技术的公链开发也是使用GO语言）开发，并遵从 Apache2.0 协议开源。其主要的目的是让开发者打包他们的应用以及依赖包到一个轻量级、可移植的容器中，然后可以快速的部署到服务器上进行运用。



![1535707891599](/1535707891599.png)



**相关资源：**

+ [官网](https://www.docker.com/)
+ [docker仓库](https://hub.docker.com/)
+ [官方文档](https://docs.docker.com/install/overview/)
+ [中文社区](http://www.docker.org.cn/index.html)
+ [docker菜鸟教程](http://www.runoob.com/docker/docker-tutorial.html)



## 为什么要使用Docker呢

当我们做一个项目，最不想面对的不是开发，也不是调试，而是部署！


比如你这个机器上的环境是 PHP7 你用另一个机器上却是 PHP5 或者压根就没有 PHP 环境。

好了，这个时候你怎么解决呢。 对，只要去新机器上你就要部署 PHP。



嗯~ 好吧， 部署PHP 就 PHP，但是你的项目里面还要用到 MySQL，好的没问题， 你又要去编译安装PHP 操作 mysql 的扩展。 哦对了，有的时候项目里面还有 redis、memcache、swoole， 哦， 还有阿里云的接口，对对对对对对哦。 乱七八糟的东西真的好多，搞完了几个小时没有了，遇到网络卡了，那就更没有谱了。



**那么，对于上面的问题，常见的解决方案是怎样的呢？**



希望做到开发和运维是同一个人进行完成，也就是提出一个 **devops** 这个职位。

![1538204318442](/1538204318442.png)

学习了docker之后，则开发人员就是代替运维人员进行项目的部署的吗？

答： 不是。因为有些硬件部署的东西还是要运维人员（懂数据库---> 一般都是DBA）。



**好了， 我们进化到，快速1.0 时代**

1. 购买服务器或者云服务器

2. 项目运行环境搭建，例如lamp或者lnmp环境

3. 将本地开发好的项目代码上传至测试服务器，调试运行

4. 当测试无误后，`灰度发布`到正式的服务器

5. 本地开发，然后在上传测试服务器.....


**于是，我们再次加入光荣的进化， 快速2.0时代**

1. 将代码和环境打包至docker的镜像里面，上传至镜像仓库
2. 将形成的镜像文件，一个命令 pull 了下来，一个命令 docker start XXXXXX 服务起来了。如果是多服务，那就写个docker-compose.file吧。如果是集群部署，有Kubernetes(k8s)、Mesos，Fleet和Swarm这些技术。 所以docker 是部署的最佳辅助。



## Docker能干什么呢？

Docker属于这种==容器技术==，也使用了虚拟化，那么**容器虚拟化**和**传统的虚拟化**有啥区别呢？



### 虚拟化简介

虚拟化，是指通过虚拟化技术将一台物理计算机虚拟为多台逻辑计算机。在一台计算机上同时运行多个逻辑计算机，每个逻辑计算机可运行不同的操作系统，并且应用程序都可以在相互独立的空间内运行而互不影响，从而显著提高计算机的工作效率。

![1535707942475](/1535707942475.png)

+ **VMM** 全称是 Virtual Machine Monitor，虚拟机监控系统，也叫 **Hypervisor**，是虚拟化层的具体实现。主要是以软件的方式，实现一套和物理主机环境完全一样的虚拟环境，物理主机有的所有资源，包括 CPU、内存、网络 IO、设备 IO等等，它都有。这样的方式相当于 VMM 对物理主机的资源进行划分和隔离，使其可以充分利用资源供上层使用。虚拟出的资源以虚拟机的形式提供服务，一个虚拟机本质上和一台物理机没有什么区别，可以跑各种操作系统，在之上再跑各种应用。这种方式无疑是计算机历史上非常里程碑的一步，你想想，以前可能要买多台服务器才能解决的事，现在只用一台就解决了。

+ 虚拟机通常叫做**客户机（guest）**，物理机叫**宿主机（host）**，VMM 处在中间层，既要负责对虚拟资源的管理，包括虚拟环境的调度，虚拟机之间的通信以及虚拟机的管理等，又要负责物理资源的管理，包括处理器、中断、内存、设备等的管理，此外，还要提供一些附加功能，包括定时器、安全机制、电源管理等。

  ![1535707976594](/1535707976594.png)



### 典型的虚拟化产品

- **VMware** 

  VMware 可以说是虚拟化的鼻祖，现在很多公司都是在模仿 VMware 的产品，相应用过 VMware 虚拟机的朋友应该不陌生了，VMware 提供了很多的虚拟化产品，从服务器到桌面都有很多应用。主要有面向企业级应用的 ESX Server，面向服务端的入门级产品 VMware Server，面向桌面的主打产品 VMware Workstation（这个相信大家经常用），面向苹果系统的桌面产品 VMware Fusion，还有提供整套虚拟应用产品的 VMware vSphere，细分的话还有 VMware vStorage（虚拟存储），VMware vNet（虚拟网络）等。


- **Xen** 

  Xen 是一款开源虚拟机软件，Xen 结合了 Hypervisor 模型和宿主模型，属于一种混合的虚拟化模型，基于 Xen 的虚拟化产品也有很多，比如 Ctrix、VirtualIron、RedHat 和 Novell 等都有相应的产品。这个一般是研究机构用得多一些，生产环境中大部分用的是 KVM。

- **KVM** 

  KVM 也是一款开源软件，于 2007 年 2 月被集成到了 Linux 2.6.20 内核中，成为了内核的一部分。KVM 采用的是基于 Intel VT 的硬件辅助虚拟化技术，以及结合 Qemu 来提供设备虚拟化，从实现上看，属于宿主模型。使用 KVM 的厂商很多啊，像我们比较熟悉 VMware Workstation 和 VirtualBox 都在使用，在此就不一一列举了。



### 容器虚拟化

![1538205542757](/1538205542757.png)



上面的传统的虚拟化技术。在很长的一段时间内占据了很大的市场份额，带了的很多的便捷之处，但随之而来的弊端的也是比较多的。

**传统的虚拟化技术弊端：**

+ **虚拟机内部攻击:** 传统的网络安全设备无法查看虚拟机内的网络通信，因而无法检测或抑制源于同一主机的虚拟机的攻击。

- **雪崩效应:** 如果同时一台物理机挂了，上面跑的虚拟机就全挂了。
- **资源调度复杂:** 由于虚拟机里面的资源的调用都是通过中间层进行转换后最终还是需要物理机进行调用。这样无形之中增加了调度的复杂程度。



通过上面的了解，我们发现虚拟化的技术存在的主要问题就是安全方面和资源调度的复杂度。则有没有更好的技术来解决这些问题呢？例如对资源调用方面的问题的解决。通过上面的讲解我们发现出现问题的本质是在中间多了一个虚拟主机，则我们是否可以减少虚拟主机，而是通过一定的技术来直接通过物理主机的操作系统来调用资源呢？达到一个轻量级的虚拟化呢？

答：**使用docker基于容器的虚拟化技术**



### Docker 的应用场景

+ Web 应用的自动化打包和发布
+ 自动化测试和持续集成、发布
+ 在服务型环境中部署和调整数据库或其他的后台应用
+ ......





### Docker 的优点

+ **简化程序**：Docker 让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，然后发布到任何流行的 Linux 机器上，便可以实现虚拟化。Docker改变了虚拟化的方式，使开发者可以直接将自己的成果放入Docker中进行管理。方便快捷已经是 Docker的最大优势，过去需要用数天乃至数周的任务，在Docker容器的处理下，只需要数秒就能完成。
+ **避免选择恐惧症**：如果你有选择恐惧症，还是资深患者。Docker 帮你打包你的纠结！比如 Docker 镜像；Docker 镜像中包含了运行环境和配置，所以 Docker 可以简化部署多种应用实例工作。比如 Web 应用、后台应用、数据库应用、大数据应用比如 Hadoop 集群、消息队列等等都可以打包成一个镜像部署。
+ **节省开支**：一方面，云计算时代到来，使开发者不必为了追求效果而配置高额的硬件，Docker 改变了高性能必然高价格的思维定势。Docker 与云的结合，让云空间得到更充分的利用。不仅解决了硬件管理的问题，也改变了虚拟化的方式。





## Docker 引擎

一般我们常说的docker指的就是docker引擎，也就是docker这个应用软件。那么docker引擎到底是啥呢？



**Docker 引擎**是一个包含以下主要组件的C/S架构应用程序。

Docker 引擎组件的流程如下图所示：

![1535708028027](/1535708028027.png)

## Docker 特点

**轻松快捷的配置**

这是Docker的一个主要功能，可帮助我们轻松快速地配置系统。可以在更少的时间和精力的情况下部署代码。 由于Docker可以在各种各样的环境中使用，基础架构不再要求与应用程序的环境相关联。



**提高工作效率**

通过放宽技术配置和应用的快速部署。 毫无疑问，它节约了时间提高了生产率。 Docker不仅有助于在孤立环境中执行应用程序，而且还减少了资源。



**应用隔离**

Docker提供用于在隔离环境中运行应用程序的容器。 每个容器独立于另一个容器，并允许执行任何类型的应用程序。



**云调度**

它是Docker容器的集群和调度工具。 Swarm使用Docker API作为其前端，这有助于我们使用各种工具来控制它。 它还可以将Docker主机集群控制为一个虚拟主机。 这是一个用于启用可插拔后端的自组织引擎组。



**安全管理**

它允许将保密数据保存到云群 (swarm) 中，然后选择给予服务访问某些保密数据。它包括一些重要的命令给引擎，如保密数据检查，保密数据创建等。



## Docker 系统架构

Docker 使用客户端-服务器 (C/S) 架构模式，使用远程 API 来管理和创建 Docker 容器。

Docker 容器通过 Docker 镜像来创建。



容器与镜像的关系类似于面向对象编程中的对象与类。

| Docker | 面向对象 |
| ------ | ---- |
| 镜像     | 类    |
| 容器     | 对象   |

![1535708059536](/1535708059536.png)



**docker基本组成**

| 标题            | 备注                                                         |
| --------------- | ------------------------------------------------------------ |
| 镜像(Images)    | Docker 镜像是用于创建 Docker 容器的模板。                    |
| 容器(Container) | 容器是独立运行的一个或一组应用。                             |
|                 |                                                              |
| 主机(Host)      | 一个物理或者虚拟的机器用于执行 Docker 守护进程和容器。       |
| 仓库(Registry)  | Docker 仓库用来保存镜像，可以理解为代码控制中的代码仓库。[Docker Hub](https://hub.docker.com/)，国内   [Docker阿里云 ](https://dev.aliyun.com)  提供了庞大的镜像集合供使用。 |



# ==Docker安装==

可以在任何操作系统上安装 Docker，无论是 Mac，Windows，Linux 还是任何云服务器。在这里，我们将以 Linux Centos 6.8 作为开发环境。注意：这个软件在windows下支撑十分不友好，并且目前只能在windows10通过模拟软件实现，所有不建议使用。

1. centos
2. Ubuntu操作系统（支撑最好）更新迭代非常快（每半年更新一次）18.x  (14.4 、16.x  LTS)



## 前提条件

Docker 需要两个重要的安装要求：

- Docker运行在CentOS7上，系统必须是 64 位，且内核版本为3.10以上

- Docker运行在CentOS6.5或者更高的版本上，系统必须是64位，且内核版本为2.6.32-431或者更高


要查看当前的内核版本，请打开终端并键入`uname -r`命令以查看内核版本：

```
[root@dockerTest /]# uname -r
2.6.32-696.6.3.el6.x86_64
```



查看操作系统是32位还是64位，请打开终端并键入`uname -m`命令以查看内核版本：

```
[root@dockerTest /]# uname -m 
x86_64
```



本次使用的阿里云的Centos6.8作为演示。以前使用的 centos5.5是无法使用的，大家需要自行使用 centos6.8 或者 centos7。



## CentOS6.8安装Docker

1. 安装epel源，这个是一个单独开发出来的yum源，里面包含了redHat公司开发出来的大部分rpm包。

   ```
   yum -y install epel-release
   ```

2. 安装docker

   ```
   yum install -y docker-io
   ```

3. 查看配置文件

   ```
   cat /etc/sysconfig/docker
   ```

4. 启动服务

   ```
   service docker start
   ```

5. 查看版本信息

   ```
   docker version
   ```

   

6. 由于网络原因，我们在 pull Image 的时候，从`Docker Hub`上下载会很慢... 所以，国内的 Docker 爱好者们就添加了一些国内的镜像 (mirror)，方便大家使用。使用比较多的是阿里云镜像和163镜像。在 `/etc/sysconfig/docker`文件，加入如下信息

   ```
   # /etc/sysconfig/docker
   #
   # Other arguments to pass to the docker daemon process
   # These will be parsed by the sysv initscript and appended
   # to the arguments list passed to docker -d
   
   # 开始注意 在这里加上如下的阿里云镜像信息
   # https://dev.aliyun.com/search.html
   other_args="--registry-mirror=https://w59xfqxq.mirror.aliyuncs.com"
   # 结束
   ```

   前往阿里的docker网站，然后找到属于自己的加速镜像url地址

   ![1538209122316](/1538209122316.png)

   url地址：

   ![1538209096174](/1538209096174.png)

7. 重启docker服务，让配置文件生效


```
service docker restart
```



# ==Docker常用命令==

## 帮助命令

+ docker version

+ docker info

+ docker --help

+ docker COMMAND --help


## 镜像命令

+ `docker images `：查看镜像，查看当前这个操作系统里面，docker管理了哪些镜像，如果没有，则我们需要使用一定的命令去docker的仓库（我们配置好的阿里云的加速镜像）下载一些镜像回来。



+ `docker search  镜像名称`   ：搜索镜像信息

  ![1538209735450](/1538209735450.png)

+ `docker pull 镜像名称`     ： 从仓库拉取镜像

  ![1538210011991](/1538210011991.png)

+ `docker rmi  镜像ID `：删除镜像

  ![1538211202985](/1538211202985.png)



# ==Docker基本使用==

## 第一个 Docker 应用程序 - hello world

Docker 允许你在容器内运行应用程序， 使用 **docker run** 命令来在容器内运行一个应用程序。

输出Hello world

```
> docker run ubuntu:15.10 /bin/echo "Hello world"
```

各个参数解析：

- docker：Docker 的二进制执行文件
- run ：与前面的 docker 组合来运行一个容器
- ubuntu:15.10   ：指定要运行的镜像，Docker首先从本地主机上查找镜像是否存在，如果不存在，Docker 就会从镜像仓库 Docker Hub 下载公共镜像
- /bin/echo "Hello world" ：在启动的容器里执行的命令



以上命令完整的意思可以解释为：Docker 以 ubuntu15.10 镜像创建一个新容器(启动该操作系统)，然后在容器里执行 bin/echo "Hello world"，然后输出结果。



通过上面的操作我们可以通过容器输出一个 hello world，那么docker run 到底做了什么呢？



## 底层原理

1. 先在本地查找镜像文件是否存在 
   * 如果不存在，则使用 `docker pull` 去docker仓库下载对应的镜像到本地
   * 如果存在，则直接运行
2. 然后在使用`docker run`运行这个镜像



思考：上面的命令我们运行完毕之后，输出hello world，好像不可以在输入其他的命令，也就是没有一个交互式的窗口供开发者输入其他的命令。现在希望可以和"镜像"进行交互？



## 运行交互式的容器

我们通过 docker 的两个参数 `-i` `-t`，让 docker 运行的容器实现"对话"的能力

```
> docker run [--name container_name] -it ubuntu:15.10 /bin/bash
```

参数解释：

- `-t`：在新容器内指定一个伪终端或终端
- `-i`：允许你对容器内的标准输入进行交互
- `--name`： 可选，给容器指定名称，在不使用的情况下，系统自动生成

此时我们已进入一个 ubuntu15.10 系统的容器

我们尝试在容器中运行命令 ls 当前目录下的文件列表

```
root@1820f09f44a2:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
```



## 退出容器

退出容器的环境，可用如下方法：

- 运行 exit
- 使用 CTRL + D



注意：如果启用的是交互模式，则会占据当前的终端，如果要退出，可以按一下ctrl+d，但是这样按了之后，当前的这个启动的镜像就会立刻关闭（相当于该操作系统已经关机）。但是有的我们希望操作系统类似一个服务在后台进行运行，作为一个守护进程。



## 以后台模式运行容器

使用以下命令创建一个以进程方式运行的容器

```
 > docker run -d ubuntu:15.10 /bin/sh -c "while true; do echo hello docker; sleep 1; done"
```

注意：`-d`选项代表的 daemon ，代表是在后台作为守护进程，不会占据终端，到时候如果我们镜像是一个Nginx服务则会有明显的优势。



在输出中，我们没有看到期望的"hello docker"，而是一串长字符

`0977407542d16c5xxx....`

这个长字符串叫做容器ID，对每个容器来说都是唯一的，我们可以通过容器ID来查看对应的容器发生了什么。

首先，我们需要确认容器有在运行，可以通过 `docker ps` 来查看

```
docker ps 
```

CONTAINER ID：容器ID

NAMES：自动分配的容器名称

在容器内使用 `docker logs` 命令，查看容器内的标准输出

```
docker logs 容器ID
```



## 与正在运行的容器交互

```
docker exec -it <container_id> /bin/bash
```



## 停止容器

```
docker stop container_name | container_id
```





# ==Docker 容器管理==

## Docker 客户端

docker 客户端非常简单 ,我们可以直接输入 `docker` 命令来查看到 Docker 客户端的所有命令选项。

```
[root@localhost ~]# docker
Usage: docker [OPTIONS] COMMAND [arg...]

A self-sufficient runtime for linux containers.

Options:

  --api-cors-header=                   Set CORS headers in the remote API
  -b, --bridge=                        Attach containers to a network bridge
  ......
  --userland-proxy=true                Use userland proxy for loopback traffic
  -v, --version=false                  Print version information and quit

Commands:
    attach    Attach to a running container
    build     Build an image from a Dockerfile
 	......
    rmi       Remove one or more images
    run       Run a command in a new container
  	
Run 'docker COMMAND --help' for more information on a command.

```

可以通过命令 `docker command --help` 更深入的了解指定的 Docker 命令使用方法。

例如我们要查看 `docker run` 指令的具体使用方法

```
[root@localhost ~]# docker run --help

Usage: docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

Run a command in a new container

  -a, --attach=[]             Attach to STDIN, STDOUT or STDERR
  ......
  -w, --workdir=              Working directory inside the container

```



## 运行 WEB 容器

前面我们运行的容器并没有一些什么特别的用处。

接下来让我们尝试使用 docker 构建一个 web 应用程序。

我们将在 docker 容器中运行一个 nginx服务。

```
[root@localhost ~]# docker run -d -P nginx
73c7e70ab5066a0ea3a8637ad105aec2135bc89281df73a957b88dc9fc00f8f1

```

参数说明：

- `-d`：让容器在后台运行
- `-P`： 大写，将容器内部使用的网络端口映射到我们使用的主机上



## 查看 WEB 容器

使用 `docker ps` 来查看我们正在运行的容器

```
[root@localhost ~]# docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS                   NAMES
73c7e70ab506        nginx               "nginx -g 'daemon of   30 seconds ago      Up 30 seconds       0.0.0.0:32768->80/tcp   thirsty_curie  
```

这里多了端口信息

```
PORTS
0.0.0.0:32768->80/tcp 
```

Docker 开放了 `80` 端口（nginx 默认端口）映射到宿主机端口 `32768` 上。



这时我们可以通过浏览器访问WEB应用

```
Welcome to nginx!
If you see this page, the nginx web server is successfully installed and working. Further configuration is required.

For online documentation and support please refer to nginx.org.
Commercial support is available at nginx.com.

Thank you for using nginx.
```



我们也可以指定小写的 `-p` 标识来绑定指定端口

```
docker run -d -p 8080:80 nginx
```

`8080` ： 宿主机端口

`80` ： 客户机端口



## 查询全部容器

```
docker ps -a
```



## 查看 WEB 应用日志

docker logs [ID或者名字] 可以查看容器内部的标准输出：

```
 docker logs -f container_name
```

这个命令和之前的` tail -f log.txt` 实时的刷新文件里面的内容

参数说明：

- `-f`：让 dokcer logs 像使用 tail -f 一样来输出容器内部的标准输出

从上面，我们可以看到应用程序使用的是 8080 端口并且能够查看到应用程序的访问日志。



## 查看 WEB 应用容器的进程

我们还可以使用 `docker top` 来查看容器内部运行的进程

```
 docker top container_name
```



## 检查 WEB 应用程序

使用 `docker inspect` 来查看Docker的底层信息。它会返回一个 JSON 文件记录着 Docker 容器的配置和状态信息：

```
docker inspect container_name
```



## 重启 WEB 应用容器

```
docker restart container_name
```



## 查询最后一次创建的容器

```
docker ps -l
```



## 停止WEB应用容器

```
docker stop amazing_archimedes
```



## 启动已停止的容器

```
docker start container_name
```



## 移除 WEB 应用容器

我们可以使用 `docker rm` 命令来删除不需要的容器：

```
docker rm container_name
```

**注意**：删除容器时，容器必须是停止状态，否则会报错



### 一次性删除所有的容器

1. 一次性的获取到所有的容器id

   ```
   [root@dockerTest ~]# docker ps --help
   
   Usage: docker ps [OPTIONS]
   
   List containers
   
     -a, --all=false       Show all containers (default shows just running)
     --before=             Show only container created before Id or Name
     -f, --filter=[]       Filter output based on conditions provided
     --help=false          Print usage
     -l, --latest=false    Show the latest created container, include non-running
     -n=-1                 Show n last created containers, include non-running
     --no-trunc=false      Don't truncate output
     -q, --quiet=false     Only display numeric IDs
     -s, --size=false      Display total file sizes
     --since=              Show created since Id or Name, include non-running
   
   
   ```

   通过上面的 `-q` 和` -a `选项得知可以获取到所有的container_id

   ```
   [root@dockerTest ~]# docker ps -qa
   b05b380be910
   426e1205819c
   56f7777b2202
   53136538a213
   
   ```

2. 删除的命令

   ```
   docker rm container_id
   
   ```

   结合起来操作

   ```
   [root@dockerTest ~]# docker rm -f  $(docker ps -aq)
   ```

   `-f `必须加上，代表将所有的运行或者没有运行的全部删除，**强制**的意思。



### 一次性删除所有的镜像

1. 获取所有的镜像的id

   ```
   [root@dockerTest ~]# docker images --help
   
   Usage: docker images [OPTIONS] [REPOSITORY]
   
   List images
   
     -a, --all=false      Show all images (default hides intermediate images)
     --digests=false      Show digests
     -f, --filter=[]      Filter output based on conditions provided
     --help=false         Print usage
     --no-trunc=false     Don't truncate output
     -q, --quiet=false    Only show numeric IDs
   [root@dockerTest ~]# docker images -qa
   f0b47291ac45
   1b7e7036c201
   1b7e7036c201
   3b1857c391bb
   a20949e68a8f
   254ab22d517d
   ```

2. 删除镜像

   ```
   docker rmi image_id
   ```

   结合起来

   ```
   [root@dockerTest ~]# docker rmi $(docker images -qa)
   ```



# ==Docker镜像管理==

## 镜像列表

我们可以使用 `docker images` 来列出本地主机上的镜像：

```
[root@localhost ~]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
tomcat              latest              fb269ccd26c4        6 days ago          462.5 MB
nginx               latest              27b195993ac0        6 days ago          109 MB
mysql               5.6                 c3354236fd23        6 days ago          256 MB
hello-world         latest              3535063d9957        13 days ago         1.848 kB
centos              latest              88ec626ba223        7 weeks ago         199.7 MB
[root@localhost ~]# 
```

**选项说明：**

- REPOSITORY：表示镜像的名称
- TAG：镜像的标签
- IMAGE ID：镜像ID
- CREATED：镜像创建时间
- SIZE：镜像大小

同一仓库源可以有多个 TAG，代表这个仓库源的不同个版本，如 ubuntu 仓库源里，有15.10、14.04等多个不同的版本，我们使用 `REPOSITORY:TAG` 来定义不同的镜像。



所以，我们如果要使用版本为15.10的ubuntu系统镜像来运行容器时，命令如下：

```
docker run -it ubuntu:15.10 /bin/bash
```



如果要使用版本为14.04的ubuntu系统镜像来运行容器时，命令如下：

```
docker run -it ubuntu:14.04 /bin/bash
```

如果你不指定一个镜像的版本标签，例如你只使用 ubuntu，docker 将默认使用 ubuntu:latest 镜像。



## 获取镜像

当我们在本地主机上使用一个不存在的镜像时 Docker 就会自动下载这个镜像。如果我们想预先下载这个镜像，我们可以使用 `docker pull` 命令来下载它。

```
docker pull ubuntu:14.04
```

下载完成后，我们可以直接使用这个镜像来运行容器。



## 查找镜像

我们可以从 Docker Hub 网站来搜索镜像，Docker Hub 网址为： [https://hub.docker.com/](https://hub.docker.com/)

我们也可以使用 `docker search` 命令来搜索镜像。比如我们需要一个 `httpd` 的镜像来作为我们的 `web` 服务。我们可以通过 `docker search` 命令搜索 `httpd` 来寻找适合我们的镜像。

```
docker search ubuntu
```

说明：

- NAME：镜像仓库源的名称
- DESCRIPTION：镜像的描述
- STARS：收藏数
- OFFICIAL：是否docker官方发布



## 创建镜像

当我们从 docker 镜像仓库中下载的镜像不能满足我们的需求时，我们可以通过以下两种方式对镜像进行更改：

- 从已经创建的容器中更新镜像，并且提交这个镜像
- 使用 Dockerfile 指令来创建一个新的镜像



## 更新镜像

更新镜像之前，我们需要使用镜像来创建一个容器：

```
docker run -it ubuntu:15.10 /bin/bash
```



在运行的容器==内==使用 `apt-get update` 命令进行更新。

在完成操作之后，输入 `exit` 命令来退出这个容器。

此时ID为 `9a3dcafd7a83` 的容器，是按我们的需求更改的容器。我们可以通过命令 `docker commit` 来提交容器副本。

**各参数说明：**

- `-m`：提交的描述信息
- `-a`：指定镜像作者
- `9a3dcafd7a83`：容器ID
- `lusifer/ubuntu:v2`：指定要创建的目标镜像名

我们可以使用 `docker images` 命令来查看我们的新镜像 `lusifer/ubuntu:v2`：

```
 docker images
```



使用我们的新镜像 lusifer/ubuntu 来启动一个容器：

```
 docker run -it lusifer/ubuntu:v2 /bin/bash
```



## 设置镜像标签

我们可以使用 `docker tag` 命令，为镜像添加一个新的标签。

docker tag 镜像ID，这里是 **6cdd9c6b840d** ，用户名称、镜像源名(repository name)和新的标签名(tag)。

使用 `docker images` 命令可以看到，ID为 **6cdd9c6b840d** 的镜像多一个标签。

```
docker images
```



# ==Docker数据卷==

## 简介

数据卷是一个可以供一个或多个容器使用的特殊目录。可以保存容器运行过程中产生的数据，达到主机和容器之间的数据共享，同时也可以实现多个容器之间的**数据共享和持久化**。



## 为什么要使用数据卷呢？

由于docker的容器只能做读操作，在容器运行期间产生的任何数据信息，在关闭后都不会被保留，但是在运行的过程中，有些服务例如mysql产生数据的数据需要做持久化操作，则这个时候就需要一个地方进行数据的持久化操作。

![1538273772522](/1538273772522.png)



**那么当我们使用数据卷后，会解决那些问题呢？**

1. 绕过 "写-拷贝" 系统，以达到本地磁盘 IO 的性能，（比如运行一个容器，在容器中对数据卷修改内容，会直接改变宿主机上的数据卷中的内容，所以是本地磁盘IO的性能，而不是先在容器中写一份，最后还要将容器中的修改的内容拷贝出来进行同步。）
2. 绕过 "写-拷贝" 系统，有些文件不需要在 `docker commit` 打包进镜像文件。
3. 在多个容器间共享目录。
4. 在宿主和容器间共享目录。
5. 在宿主和容器间共享一个文件。

## 如何使用呢？

**方法一**：在dockerfile 的 VOLUME 中指定目录，如 `VOLUME /var/lib/test`

**方法二**：`docker run` 命令中加 `-v` 选项。如：

```
# 直接共享容器目录 -v 容器目录
docker run -d -P -v /var/www/html   nginx 
```



![1538273986512](/1538273986512.png)



**注意：** 这里定义的 `/var/www/html` 数据卷，但是不知道宿主机上与之对应的在哪里。我们需要仔细的观察 `docker inspect` 的结果，是非常长的一段东西。

```
# 直接挂载宿主机目录 -v 宿主机目录:容器目录
docker run -d -P -v /root/docker/nginx:/usr/local/nginx/www   nginx
```

**注意：** 这里 “Name”: “ae15b45565ac99bc...”，这个并不是容器 id 而是数据卷的 ID，我们可以在 `/var/lib/docker/volumes/` 下找到名为这个数字的目录。它就是我们数据卷在宿主机上对应的目录。





## 备份数据卷

这其实是利用 `tar` 命令来执行的。

备份的原理：使用 `tar -zcvf` 对数据卷打包压缩



如，创建一个 MySQL 容器：

```
docker run -p 3306:3306 --name mysql \
-v /usr/local/docker/mysql/conf:/etc/mysql \
-v /usr/local/docker/mysql/logs:/var/log/mysql \
-v /usr/local/docker/mysql/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
-d mysql

```

进入 `/usr/local/docker/mysql` 目录，使用 `tar -zxvf backup.tar.gz .` 打包当前目录，即可得到一个压缩包，这个压缩包就是我们需要的备份数据。



## 恢复数据卷

解压缩备份数据压缩包

```
tar -zxvf backup.tar.gz
```

重新启动一个新的容器并将数据卷指向需要还原的数据卷目录(`mysql/backup`)

```
docker run -p 3306:3306 --name mysql \
-v /usr/local/docker/mysql/backup/conf:/etc/mysql \
-v /usr/local/docker/mysql/backup/logs:/var/log/mysql \
-v /usr/local/docker/mysql/backup/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
-d mysql
```



# ==Dockerfile==

## 简介

Dockerfile是一个包含 多条docker指令 的文本文档。可以编写的指令为 docker在命令行中的任何命令。 Docker通过读取Dockerfile中的指令自动生成镜像。



`docker build` 命令用于从Dockerfile构建镜像。

```
docker build -t asion:v1.0 . 
```



## Dockerfile文件示例

```
# 该指令用于设置后续操作的基础镜像。有效的 Dockerfile 必须使用FROM作为其第一条指令。
FROM scratch
# 设置作者信息
MAINTAINER asion<gogery@163.com>
ADD file.txt /
LABEL name="CentOS Base Image" \
    vendor="CentOS" \
    license="GPLv2" \
    build-date="2016-06-02"

# 设置执行的命令
CMD ["/bin/bash"]
```

**注意**：docker的镜像是分层处理的，每层只能完成读的操作，不支持写入。

![1538275210672](/1538275210672.png)

![1538275268972](1538275268972.png)



## Dockerfile构建过程解析

### 基础知识

1. 每条保留字指令都必须为大写字母且后面至少要一个参数
2. 指令按照从上到下，顺序执行
3. \# 代表注释
4. 每条指令都会创建一个新的镜像层，并对该镜像层进行提交



### Dockerfile执行流程

1. docker从基础镜像运行一个容器
2. 执行一条指令并对容器作出修改
3. 执行类型 docker commit 的操作提交一个新的镜像层
4. docker基于刚提交的镜像运行一个新的容器
5. 执行Dockerfile中的下一条指令直到所有的指令执行完成



## Dockerfile保留字指令

可以在Dockerfile文件中使用`RUN`，`CMD`，`FROM`等指令来快速的构建自己的镜像。



### FROM

该指令用于设置后续操作的基础镜像。有效的 Dockerfile 必须使用`FROM`作为其第一条指令。

```
FROM ubuntu
```



### MAINTAINER

指定镜像的作者

```
MAINTAINER <name>
```



### RUN

该指令用于执行当前镜像的任何命令。

```
RUN /bin/bash -c 'echo "Hello World"'
```



### CMD

用于执行镜像的应用程序。应该以下形式使用CMD

```
CMD ["executable", "param1", "param2"]
```

这是使用CMD的首选方法。Dockerfile文件中只能有一个CMD。如果使用多个CMD，则只会执行最后一个CMD。

例：`CMD ["/bin/echo", "this is a echo test"]`



### COPY

该指令用于将来自源的新文件或目录复制到目的地的容器的文件系统。

```
COPY abc/  /xyz
```

规则：

* `source`路径必须在构建的上下文之内。无法使用`COPY ../something /something`，因为docker构建的第一步是将上下文目录(和子目录)发送到 docker 守护程序。
* 如果`source`是目录，则会复制目录的全部内容，包括文件系统元数据。



### WORKDIR

WORKDIR用于为Dockerfile中的`RUN`，`CMD`和`COPY`指令设置工作目录。

备注：可以简单理解为 `cd` 命令，但是如果目录不存在它会自动创建。



## 构建镜像

我们使用命令 `docker build` ， 从零开始来创建一个新的镜像。为此，我们需要创建一个 Dockerfile 文件，其中包含一组指令来告诉 Docker 如何构建我们的镜像。



每一个指令都会在镜像上创建一个新的层，每一个指令的前缀都必须是大写的。

第一条FROM，指定使用哪个镜像源

RUN 指令告诉docker 在镜像内执行命令，安装了什么......



然后，我们使用 Dockerfile 文件，通过 `docker build` 命令来构建一个镜像。

```
docker build -t asion/centos:latest .
```

**参数说明：**

* `-t` ：指定要创建的目标镜像名
* `. `：Dockerfile 文件所在目录，可以指定 Dockerfile 的绝对路径

使用 `docker images` 查看创建的镜像已经在列表中存在



我们可以使用新的镜像来创建容器

```
 docker run -it asion/centos /bin/bash
```



# 本地镜像发布到阿里云

当开发者在本地构建好一个拥有各类开发环境的镜像后，可以共享给互联网上的其他的用户使用？

当然可以，这个时候我们可以将自己的本地镜像发布到阿里云的仓库，实现共享。



1. 基于Dockerfile构建一个容器
2. 在该容器中配置好相关的环境
3. 使用docker commit 创建一个新的本地镜像
4. 登录到阿里云docker平台 https://dev.aliyun.com/search.html
5. 在后台创建仓库
6. 将本地镜像推到到仓库
7. 查看发布的镜像信息
8. 将阿里云上发布的镜像下载到本地进行使用



# Docker附录

## Docker 资源链接

### 官方网站

Docker 官方主页：https://www.docker.com
Docker 官方博客：https://blog.docker.com/
Docker 官方文档：https://docs.docker.com/
Docker Store：https://store.docker.com
Docker Cloud：https://cloud.docker.com
Docker Hub：https://hub.docker.com
Docker 的源代码仓库：https://github.com/moby/moby
Docker 发布版本历史：https://docs.docker.com/release-notes/
Docker 常见问题：https://docs.docker.com/engine/faq/
Docker 远端应用 API：https://docs.docker.com/develop/sdk/



### 实践参考

Dockerfile 参考：https://docs.docker.com/engine/reference/builder/
Dockerfile 最佳实践：
https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/



### 技术交流

Docker 邮件列表： https://groups.google.com/forum/#!forum/docker-user
Docker 的 IRC 频道：https://chat.freenode.net#docker
Docker 的 Twitter 主页：https://twitter.com/docker



### 其它

Docker 的 StackOverflow 问答主页：https://stackoverflow.com/search?q=docker



# 参考阅读



[用Docker和Vagrant构建简洁高效开发环境](http://cloud.51cto.com/art/201503/470256.htm)

[八种最常见Docker开发模式](http://cloud.51cto.com/art/201503/469496.htm)

[Docker学习总结之Docker与Vagrant之间的特点比较](https://www.cnblogs.com/vikings-blog/p/3973265.html)

[**Docker与Vagrant的简单区别**](http://dockone.io/article/271)

[docker 和vagrant比较](https://blog.csdn.net/carolzhang8406/article/details/80153869)





