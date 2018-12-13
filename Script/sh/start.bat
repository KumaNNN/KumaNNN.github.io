@echo off
:: 开启变量延迟
setlocal enabledelayedexpansion

cd %~dp0

:: 判断脚本所在路径，Script\sh\或仓库根目录
if exist init.bat (
	REM 跳转到仓库根目录(当前脚本路径为 Script\sh\)
	cd.. 
	cd..  

	REM 设置根目录路径
	set root=!cd!
	REM 设置当前脚本路径
	set thispath=%~dp0

	REM 跳转到上级目录
	cd..
	REM 备份目录
	xcopy !root!\*  !root!.bak\  /eiy

	REM 删除文件
	rd  /s/q !root!.bak\Script
	del /f/s/q !root!.bak\start.bat
	
	REM 跳转到当前脚本路径
	cd !thispath!

	REM 调用脚本	
	start init.bat
) else (
	REM 设置根目录路径
	set root=!cd!
	REM 设置当前脚本路径
	set thispath=%~dp0

	REM 跳转到上级目录
	cd..
	REM 备份目录
	xcopy !thispath!*  !root!.bak\  /eiy

	REM 删除文件
	rd  /s/q !root!.bak\Script
	del /f/s/q !root!.bak\start.bat
	
	REM 跳转到当前脚本路径
	cd !thispath!
		
	REM 调用脚本
	start Script\sh\init.bat
	
	REM 删除本脚本并退出
	del %0
	exit
)

