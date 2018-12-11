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

:: cd跳转到根目录(因为当前存放目录：./Script/sh，所以需要更改)
cd %~dp0
cd..
cd..
:: 设置根目录路径
set root=%cd%
:: 设置当前脚本路径
set thispath=%~dp0


:: 获取目录名  EQU - 等于
if "%1" EQU "" (
	for %%i in ("%~dp0\.") do (
	  set dirname=%%~ni
	)
) else (
	set dirname=%1
)
echo 目录名: %dirname% 


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