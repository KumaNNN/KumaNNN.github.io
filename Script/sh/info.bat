:: ============================================================================= ::
:: 仓库配置信息
::
:: 将此脚本和Script目录一起复制到子仓库根目录。
:: 注： 通常情况，此脚本运行完毕会删除自身
::
:: 存放目录： ./Script/sh 
:: 运行目录： ./ 
:: 
:: ============================================================================= ::

:: 关闭回显
@echo off

:: 先跳转到脚本目录
cd %~dp0

:: 获取目录名  EQU - 等于
:: 如果当前脚本目录是public，则目录名为自定义
:: 如果当前脚本目录是不是public，则2次cd且目录名为cd所在
:::: cd跳转到根目录(因为当前存放目录：./Script/sh，所以需要更改)
for %%a in ("%~dp0\.") do ( 
	if "%%~na" EQU "public" (
		set dirname=KumaNNN.github.io
		set dd=1
	) else (
		cd..
		cd..
		for %%i in ("%cd%\.") do (
		  set dirname=%%~ni
		)
	) 
)
echo 目录名: %dirname% 


:: 设置根目录路径
set root=%cd%
:: 设置当前脚本路径
set thispath=%~dp0


echo ------------------------ 仓库配置  ------------------------ 


echo 配置用户名...
git config user.name "kuma8866"

echo 配置邮箱... 
git config user.email "kuma8866@163.com" 

echo 配置提交缓存...
git config http.postBuffer  524288000   

echo 添加远程仓库...
git remote add origin https://github.com/KumaDocCenter/%dirname%.git


echo ------------------------ 仓库配置  ------------------------ 

:: 删除脚本自身
if "%dd%" EQU "1"  del %0 