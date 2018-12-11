@echo off
if exist init.bat (
	start init.bat
) else (
	start Script\sh\init.bat
	:: 删除本脚本
	del %0
	exit
)

