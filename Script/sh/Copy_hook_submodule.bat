:: ============================================================================= ::
:: 复制子模块钩子
::
:: 将此脚本和Script目录一起复制到子仓库根目录。
:: 注： 通常情况，此脚本运行完毕会删除自身
::
:: 存放目录： ./Script/sh 
:: 运行目录： ./
:: 
:: 必须参数： 
:: %1 : 子模块名      (Ajax)
:: ============================================================================= ::

:: 关闭回显
@echo off
:: 开启变量延迟
setlocal enabledelayedexpansion
:: 调试开关
set debug=0

:: cd跳转到根目录(因为当前存放目录：./Script/sh，所以需要更改)
cd %~dp0
cd..
cd..
:: 设置根目录路径
set root=%cd%
:: 设置当前脚本路径
set thispath=%~dp0
:: 设置子模块根目录
set SubModuleRoot=source_md

if %debug%==1 echo ------------------------ 简易日期时间和时间戳  ----------------------

:: 日期分隔符
set delim=-

:: 日期处理( 2018-12-10 )
for /f "tokens=1-4  delims=/ " %%a in ("%date%") do (
	set _de=%%a%delim%%%b%delim%%%c
	set de=%%a%%b%%c
	set week=%%d
)
:: 时间处理( 21:43:58 )
for /f "tokens=1-4  delims=:." %%a in ("%time%") do (
	set _ti=%%a:%%b:%%c
	set ti=%%a%%b%%c
)

:: 当前日期时间( 2018-12-10 21:43:58 )
set "datetime=%_de% %_ti%"
if %debug%==1 echo "%datetime%"

:: 日期时间 戳( 20181207180016 )
set deti=%de%%ti%
:::: 去除所有空格
set timestamp=%deti: =%
if %debug%==1 echo "%timestamp%"

if %debug%==1 echo ------------------------ 简易日期时间和时间戳  ----------------------




echo ------------------------ 复制钩子  ------------------------
:: %1 : 子模块名      (Ajax)
:: 只适用于子模块，子仓库不需要此钩子
:: .git/modules/source_md/Ajax

:: 钩子文件源路径
set hook_spath=Script\hook\SubModule
:: 钩子文件目标路径
set hook_dpath=.git\modules\%SubModuleRoot%\%1

call :copy_hook  "%hook_spath%"   "%hook_dpath%"  post-commit  %timestamp%
call :copy_hook  "%hook_spath%"   "%hook_dpath%"  post-checkout  %timestamp%
call :copy_hook  "%hook_spath%"   "%hook_dpath%"  post-merge  %timestamp%
call :copy_hook  "%hook_spath%"   "%hook_dpath%"  pre-push  %timestamp%

echo ------------------------ 复制钩子  ------------------------

exit




:: ==========[Function]================================================================== ::


GOTO:EOF
:: ================================================== ::
:: 函数名称：copy_hook								  ::
:: 函数功能：复制钩子								  ::
:: 函数参数：arg1: 钩子文件源路径 					  ::
::           	   如，Script\hook\SubModule		  ::
::           arg2: 钩子文件目标路径					  ::
::           	   如，.git\modules\source_md\Ajax	  ::
::           arg3: 钩子名称	 					 	  ::
::           arg4: 时间戳	 					 	  ::
:: 返回值： 									 	  ::
:: 		      						 				  ::
:: ================================================== ::
:copy_hook
if %debug%==1 echo Localtion: %this%: %~0 .................
if %debug%==1 echo ---arg0: %~0 
if %debug%==1 echo ---arg1: %~1 
if %debug%==1 echo ---arg2: %~2 
if %debug%==1 echo ---arg3: %~3 
if %debug%==1 echo ---arg4: %~4 
if %debug%==1 echo ---arg5: %~5
if %debug%==1 echo ---arg6: %~6 
if %debug%==1 echo ---arg7: %~7 
if %debug%==1 echo ---arg8: %~8
if %debug%==1 echo ---arg9: %~9
if %debug%==1 echo Localtion: %this%: %~0 .................


:: %1 : 子模块名      (Ajax)
:: 只适用于子模块，子仓库不需要此钩子
:: .git/modules/source_md/Ajax
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
:: 设置钩子名称
set hookname=%~3
:: 存在则备份
if exist "%~2\hooks\%hookname%"  (
 	ren %~2\hooks\%hookname%   %hookname%.%~4  
)
:: 复制钩子
xcopy  %~1\%hookname%   %~2\hooks\  /Y
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 

GOTO:EOF
:: ==========[Function]================================================================== ::
