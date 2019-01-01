:: =================================================================== ::
::  处理source/* md文件
:: 生成一些YAML数据
:: 
:: 手动执行或钩子调用
:: 存放目录： ./Script/sh 
:: 运行目录： ./
::
:: =================================================================== ::
:: 关闭回显
@echo off
:: 调试开关
set debug=1
:: 开启变量延迟
setlocal EnableDelayedExpansion
:: 当前文件名
set this=%0

:: cd跳转到根目录
cd %~dp0
cd..
cd..

:: 设置根目录路径
set root=%cd%

REM 目标存在则备份
if exist public (
	if exist public.bak (
		REM 删除目录
		rd /S/Q public
	) else (
		REM 重命名目录
		ren public  public.bak
	)
)

(
	REM hexo 清除
	hexo clean
	REM hexo 生成
	hexo g
) && (
	echo cd: %cd%
	REM 删除目录
	rd /S/Q %cd%\public
	REM 恢复目录 
	ren  %cd%\public.bak  public
)

exit



