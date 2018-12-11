:: ============================================================================= ::
:: 子仓库初始化
::
:: 将此脚本和Script目录一起复制到子仓库根目录。
:: 注： 通常情况，此脚本运行完毕会删除自身
::
:: 存放目录： ./Script/sh 
:: 运行目录： ./ 
:: 
:: ============================================================================= ::


:: ===================================日志处理========================================== ::
:: 关闭回显
@echo off
:: 开启变量延迟
setlocal enabledelayedexpansion
:: 设置颜色
color 0A

:: 存储感叹号 ! 
set "T=^!"

:: cd跳转到根目录(因为当前存放目录：./Script/sh，所以需要更改)
cd %~dp0
cd..
cd..
:: 设置根目录路径
set root=%cd%
:: 设置当前脚本路径
set thispath=%~dp0

:: 日志开关
set log=1
:: 日志文件名
set logName=init.log
:: 换成 ANSI 代码页,中文字符可以正确识别 
chcp 936  
:: 记录日志
if %log%==1 (
	@call :output>%logName%
) else (
	call :output
)

:: 删除本脚本
::del %0
exit
GOTO:EOF
:: ===================================日志处理========================================== ::

:: ===================================核心代码========================================== ::
:output

:: ---------------------------------- 预处理  ---------------------------------- ::

:::::::::::::::::::::::::git数据库判断:::::::::::::::::::::::::::::::::::
:: 存在git数据库，则退出脚本，否则，执行脚本
IF EXIST .git (
    echo .git 文件夹存在	
	exit
) ELSE (
    echo 执行操作... 
)
:::::::::::::::::::::::::git数据库判断:::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::特定目录处理:::::::::::::::::::::::::::::::::::
:: 指定目录不存在，则创建
IF NOT EXIST "doc/md" ( mkdir "doc/md" )
IF NOT EXIST "doc/Readme" ( mkdir "doc/Readme" )
:::::::::::::::::::::::::特定目录处理:::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::空目录处理:::::::::::::::::::::::::::::::::::
:: 对于空目录，添加 .gitkeep 文件

:: -------------------------------------------------------- ::
:: for 循环 ('dir /ad /b /s')中的为当前位置下的所有目录全路径的集合。
:: 如,
:: E:\share\z
:: E:\share\xshell
:: E:\share\cmder
:: 
:: for 循环 ('dir "%%i" /a /b')，再次将上面的路径进行dir。
:: 如果目录为空(即无子目录或文件)，则不会有任何输出。
:: 则 for /f %%j in ('dir "%%i" /a /b') 为false，不会执行do后面的命令。
::
:: set n=0 : 配合 for /f %%j in ('dir "%%i" /a /b')  语句。
:: for /f %%j in ('dir "%%i" /a /b') 为true，即不是空目录时，n+1
:: !n! : 必须用!包裹，才能读取 set /a n+=1 中的n
:: if !n!==0 : 表示上一行语句未执行，即，出现空目录 %%i
:: 此 %%i 不一定要输出到文件，可灵活应用
:: -------------------------------------------------------- ::
for /f "delims=" %%i in ('dir /ad /b /s') do (
    set n=0
    for /f %%j in ('dir "%%i" /a /b') do ( set /a n+=1 )
    if !n!==0 echo git空目录处理 >%%i\.gitkeep
)
:::::::::::::::::::::::::空目录处理:::::::::::::::::::::::::::::::::::

echo ------------------------ 简易时间戳  ------------------------
:: 日期处理( 20181207 )
for /f "tokens=1-3  delims=/ " %%a in ("%date%") do (
	set de=%%a%%b%%c
)
:: 时间处理( 180016 )
for /f "tokens=1-3  delims=:." %%a in ("%time%") do (
	set ti=%%a%%b%%c
)
:: 日期时间 戳( 20181207180016 )
set deti=%de%%ti%
:::: 去除所有空格
set deti=%deti: =%
echo "%deti%"
echo ------------------------ 简易时间戳  ------------------------


:: 获取目录名
for %%i in ("%cd%\.") do (
  set dirname=%%~ni
)
echo 目录名: %dirname% 


:: ---------------------------------- 预处理  ---------------------------------- ::


echo ------------------------ 仓库配置  ------------------------ 

echo 初始化仓库...
git init

echo 配置用户名...
git config user.name "kuma8866"

echo 配置邮箱... 
git config user.email "kuma8866@163.com" 

echo 配置提交缓存...
git config http.postBuffer  524288000   

echo 添加远程仓库...
git remote add origin https://github.com/KumaDocCenter/%dirname%.git


echo ------------------------ 仓库配置  ------------------------ 

:: bat怎样把<>&等符号输出到文件里
:: 特殊符号前面加^
:: echo #include ^<stdio.h^> >.1.txt
:: 输出空白 echo.
:: echo.  >>.gitignore
:: 用了setlocal EnableDelayedExpansion 后!就变特殊了,输出不了，
:: 所以需要提前保存！在变量中。


echo ------------------------START: Commit_0  ------------------------ 
:: 提交空白仓库，只包含 .gitignore 文件

echo 输出 .gitignore...
echo /start.bat >>.gitignore
echo /*.add >>.gitignore
echo !T!.gitignore >>.gitignore

echo 添加到暂存...
git add .gitignore

echo git提交...
git commit -m "Commit_0 : init"

echo ------------------------END: Commit_0  ------------------------ 


echo ------------------------START: Commit_1  ------------------------ 
:: 增加 doc/md 和 Script目录，并新建md分支

echo 输出 .gitignore...
echo /*.add >>.gitignore
echo !T!doc/md >>.gitignore
echo !T!Script >>.gitignore

echo 添加到暂存...
git add .gitignore
git add doc/md/
git add Script/


echo git提交...
git commit -m "Commit_1 : + doc/md/* and Script"

echo 新建md分支...
git checkout -b md

echo 切换至master分支...
git checkout master

echo ------------------------END: Commit_1  ------------------------ 



echo ------------------------START: Commit_2  ------------------------ 
::  增加所有文件

echo 输出 .gitignore...
echo .DS_Store >.gitignore
echo Thumbs.db >>.gitignore
echo /start.bat >>.gitignore
echo !T!.gitignore >>.gitignore
echo !T!**/.gitkeep >>.gitignore
echo /*.add >>.gitignore

echo 添加到暂存...
git add .

echo git提交...
git commit -m "Commit_2 : + All file"

echo ------------------------END: Commit_2  ------------------------ 


echo ------------------------ 复制钩子  ------------------------
:: 放置最后，避免不必要的触发
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
:: 设置钩子名称
set hookname=post-commit
:: 存在则备份
if exist ".git\hooks\%hookname%"  (
	ren .git\hooks\%hookname%   %hookname%.%deti%  
)
:: 复制钩子
xcopy  Script\hook\SubRepo\%hookname%   .git\hooks\  /Y
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 

echo ------------------------ 复制钩子  ------------------------


echo ------------------------ 配置输出  ------------------------

set "dn=%dirname%.%deti%.add"
set git=https://github.com/KumaDocCenter/%dirname%.git
set name=%dirname%
set branch=md
set sh=info.bat

echo ###################################################### >%dn%
echo #  子模块批处理配置文件 >>%dn%
echo #  后缀   		作用 >>%dn%
echo # .add        添加子模块 >>%dn%	
echo # .init	      初始化子模块 >>%dn%
echo # .update	  更新子模块 >>%dn%
echo # .del		  删除子模块 >>%dn%
echo #------------------------------------------------ >>%dn%
echo #  git     :  git 地址 >>%dn%
echo #  name    :  子模块名称 >>%dn%
echo #  branch  :  子模块分支 >>%dn%
echo #  sh  	   :  待执行的额外脚本 路径 >>%dn%
echo ###################################################### >>%dn%
echo git=%git%>>%dn%
echo name=%name%>>%dn%
echo branch=%branch%>>%dn%
echo sh=%sh%>>%dn%

echo. 
echo 用于子模块的配置文件已生成，请尽快转移文件
echo [ %dn% ]
echo.
echo ------------------------ 配置输出  ------------------------


echo ------------------------ YAML输出  ------------------------

echo 切换至md分支
git checkout md

:: 调用脚本
call %~dp0YAMLwrite.bat

echo 添加到暂存...
git add .

echo git提交...
git commit -m "Commit_3 : + md's YAML"

echo 切换至master分支
git checkout master

echo ------------------------ YAML输出  ------------------------


echo ########################## 查看结果 ##########################
echo.
git branch -v

echo -----------------------------------------------------------

git log
echo.
echo ########################## 查看结果 ##########################


:: ===================================核心代码========================================== ::




