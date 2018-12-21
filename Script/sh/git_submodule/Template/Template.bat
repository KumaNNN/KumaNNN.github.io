:: =================================================================== ::
::  生成用于子模块批处理的配置文件
::  
:: 
:: =================================================================== ::
:: 关闭回显
@echo off
:: 开启变量延迟
setlocal enabledelayedexpansion
:: 设置颜色
color 0A
:: 调试开关
set debug=0

:::::::::::::::::::::::::::变量配置:::::::::::::::::::::::::::::::

:: 文件名(不包含后缀)
set _filename=Template
:: 子模块名
set _name=public
:: git地址
set _git=https://xxx.com/xx/%_name%.git
:: 子模块分支 
set _branch=master
:: 处理前调用的脚本路径
set _sh=
:: 处理后调用的脚本路径
set _sh2=
:: 是否启用文件名时间戳
set is_TimestampFileName=1
:::::::::::::::::::::::::::变量配置:::::::::::::::::::::::::::::::




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
echo 日期时间："%datetime%"

:: 日期时间 戳( 20181207180016 )
set deti=%de%%ti%
:::: 去除所有空格
set timestamp=%deti: =%
echo 时间戳："%timestamp%"
if %debug%==1 echo ------------------------ 简易日期时间和时间戳  ----------------------

:: EQU - 等于
if "%is_TimestampFileName%"  EQU "1" (
	set ttfn=.%timestamp%
) else (
	set ttfn=
)

call :outfile  %_filename%%ttfn%.add  %_git%  %_name%  %_branch%  %_sh%  %_sh2%
call :outfile  %_filename%%ttfn%.init  %_git%   %_name%  %_branch%  %_sh%  %_sh2%
call :outfile  %_filename%%ttfn%.update  %_git%   %_name%  %_branch%  %_sh%  %_sh2%
call :outfile  %_filename%%ttfn%.del  %_git%   %_name%  %_branch%  %_sh%  %_sh2%


GOTO:EOF
:: ================================================== ::
:: 函数名称：outfile							  	  ::
:: 函数功能：输出文件								  ::
:: 函数参数：arg1: 输出文件名 					  	  ::
:: 			 arg2: git地址 						  	  ::
::                 如，https://github.com/ter/Ajax.git::
::           arg3: 子模块名 						  ::
::                 子模块相对路径					  ::
::         [arg4]: 子模块分支 						  ::
::         [arg5]: 处理前脚本路径(相对路径)			  ::
::         [arg6]: 处理后脚本路径(相对路径)			  ::
:: 返回值： 									 	  ::
:: 													  ::
:: ================================================== ::
:outfile

set dn=%~1
set git=%~2
set name=%~3

:: EQU - 等于
if "%~4" EQU "" (
	set branch=master
) else (
	set branch=%~4
) 

:: EQU - 等于
if "%~5" EQU "" (
	set sh=
) else (
	set sh=%~5
)
:: EQU - 等于
if "%~6" EQU "" (
	set sh=
) else (
	set sh=%~6
) 
 
echo ------------------------ 配置输出  ------------------------
echo ###################################################### >%dn%
echo #  子模块批处理配置文件 >>%dn%
echo #  >>%dn%
echo # 创建时间：%datetime%  >>%dn%
echo #------------------------------------------------ >>%dn%
echo #  后缀   		作用 >>%dn%
echo # .add        添加子模块 >>%dn%	
echo # .init	      初始化子模块 >>%dn%
echo # .update	  更新子模块 >>%dn%
echo # .del		  删除子模块 >>%dn%
echo #------------------------------------------------ >>%dn%
echo #  git     :  git 地址 >>%dn%
echo #  name    :  子模块名称 >>%dn%
echo #  branch  :  子模块分支 >>%dn%
echo #  sh  	   :  处理前调用的脚本  >>%dn%
echo #  sh2     :  处理后调用的脚本  >>%dn%
echo ###################################################### >>%dn%
echo git=%git%>>%dn%
echo name=%name%>>%dn%
echo branch=%branch%>>%dn%
echo sh=%sh%>>%dn%
echo sh2=%sh2%>>%dn%

echo. 
echo 用于子模块的配置文件已生成，请尽快转存文件
echo [ %dn% ]
echo.
echo ------------------------ 配置输出  ------------------------
GOTO:EOF

