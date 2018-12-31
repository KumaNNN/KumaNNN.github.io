:: =================================================================== ::
:: 复制source下的index.md 到 source_md 下
:: 
:: 自动删除本脚本
::
:: 存放目录： 
:: 运行目录： ./source/_posts/Dev/<SubModule Name>
::
:: =================================================================== ::
:: 关闭回显
@echo off
:: 开启变量延迟扩展
SETLOCAL EnableDelayedExpansion 
:: 调试开关
set debug=0

:: 是否删除本脚本
set is_del=1

:: cd跳转到根目录(因为当前目录：<SubModule Name>，所以需要更改)
cd %~dp0
cd..
:: 设置源根目录
set root=%cd%
:: 设置当前脚本目录
set thisdir=%~dp0

:: 跳转回脚本路径并获取目录名
cd %thisdir%
for %%i in ("%cd%\.") do (
  set dirname=%%~nxi
)

:: 获取hexo目录 HexoRoot
call :PosChar %root% source\_posts  hpos
set HexoRoot=!root:~0,%hpos%!

:: 设置目标根目录
set DestRoot=%HexoRoot%source_md


REM HexoRoot: E:\...\Hexo\
REM root: E:\...\Hexo\source\_posts\Dev
REM thisdir: E:\...\Hexo\source\_posts\Dev\js.JavaScript\
REM dirname: js.JavaScript
if %debug%==1 echo ---HexoRoot: %HexoRoot%
if %debug%==1 echo ---root: %root%
if %debug%==1 echo ---thisdir: %thisdir%
if %debug%==1 echo ---dirname: %dirname%



:: EQU - 等于  NEQ - 不等于
:: 判断脚本所在路径是否符合要求(路径中是否包含指定字符)
call :PosChar %root%  _posts  aa
if "%aa%" EQU "-1" (
	echo 脚本运行目录不符合要求
	echo 脚本即将退出...
	pause
	GOTO:EOF
)


:: 遍历当前路径下的index.md文件(存在的)
:: 复制文件
for /r "%thisdir%" %%i in (index.md) do if exist %%i  (
	REM echo File: %%i 
	
	REM 获取相对目录 str 
	REM 如，\Advanced\
	REM 将当前路径和文件名替换为空
	set str=%%i
	set str=!str:%root%\%dirname%=!
	set str=!str:index.md=!
		
	if %debug%==1 echo Root: %root%
	if %debug%==1 echo DestRoot: %DestRoot%
	if %debug%==1 echo dirname: %dirname%
	if %debug%==1 echo Rdir: !str!
	if %debug%==1 echo Rpath: !str!index.md
	
	REM 源
	set s=%root%\%dirname%!str!index.md
	REM 目标目录
	set d=%DestRoot%\%dirname%\doc\md!str!
	if %debug%==1 echo s: !s!
	if %debug%==1 echo d: !d!
	
	REM 目录存在才复制
	if exist "%DestRoot%\%dirname%" (
		if exist "%DestRoot%\%dirname%\doc\md" (
			xcopy "!s!"  "!d!"  /Y/Q 
		)
	)
)
:: EQU - 等于  NEQ - 不等于
:: 删除本脚本
if "%is_del%" EQU "1"  del %0
GOTO:EOF



:: ==========[Function]================================================================== ::


::::::::调用示例:::::::::::
REM call :PosChar  Str SubStr VarName

:: 设置字符串
::set k=speed_dao_mmr
:: 调用函数
::call :PosChar %k% _ aa
::echo ...从0开始计算...
::echo 首次出现位置(5): %aa%


GOTO:EOF
:: ================================================== ::
:: 函数名称：PosChar							  	  ::
:: 函数功能：在字符串中查找子字符串首次出现位置		  ::
:: 函数参数：arg1: 字符串				 		 	  ::
::  		 arg2: 子字符串				 			  ::
::  		 arg3: 变量名				 			  ::
::  		 	   存储结果的变量名称	 			  ::
::           							 			  ::
:: 返回值：          							      ::
::        %<arg3>%  ： 获取位置信息   			  	  ::
::        			   -1，表示未找到   			  ::
:: ================================================== ::
:PosChar
:: 闭环 setlocal ... endlocal
setlocal

:: 截取的字符串
set SubStr=
:: 字符串
set Str=%~1
:: 位置计数
set F=0
:: 设置结果变量
set res=-1

:: 获取传入的子字符串长度
call :StrLen  %~2  SubStrLen
if %debug%==1 echo SubStrLen: %SubStrLen%

::----------------------------------------------------------------
:: 【注解】
:: set SubStr=!Str:~%F%,%SubStrLen%!
:: 截取字符串和参数2比较 ( "%SubStr%"=="%2" )
:: 		匹配到1个，则设置并返回结果( set res=%F% )并退出
:: 		未匹配，继续截取字符串，继续比较，如此循环<直到匹配或到末尾>
:: 		1个都未匹配时，返回默认值 -1 ( set res=-1 )
::	
::----------------------------------------------------------------
:Pos_Begin
:: 截取字符串
:: 从第%F%个开始，截取%SubStrLen%个
set SubStr=!Str:~%F%,%SubStrLen%!

:: 如果SubStr未定义，即 SubStr=空时，退出
if not defined SubStr goto Pos_End

:: 截取的字符串和传入参数2比较 
if "%SubStr%"=="%~2" (
    REM 相等，则设置res=计数并退出
	set res=%F%
    goto Pos_End
) else (
    REM 不相等，计数+1并循环
	set /a F=%F%+1
    goto Pos_begin
)
:Pos_End
(
endlocal
REM 输出变量
set %~3=%res%
)
GOTO:EOF



::::::::调用示例:::::::::::
REM call :StrLen  Str  VarName

::call :StrLen  abc  strl
::echo abc 长度： %strl%
::echo abc 长度zero： %strlzero%

GOTO:EOF
:: ================================================== ::
:: 函数名称：StrLen							  		  ::
:: 函数功能：字符串长度								  ::
:: 函数参数：arg1: 字符串				 		 	  ::
::  		 arg2: 变量名				 			  ::
::  		 	   存储结果的变量名称	 			  ::
::           							 			  ::
:: 返回值：          							      ::
::        %<arg2>%  ： 获取长度(实际长度)  			  ::
::    %<arg2zero>%  ： 获取长度(长度-1)		  	 	  ::
:: ================================================== ::
:StrLen
:: 闭环 setlocal ... endlocal
setlocal
  
:: 字符串
set str=%~1

:strLen_Loop
:: EQU - 等于  NEQ - 不等于
:: 从 %len% 个字符开始截取到最后
:: 开始时，没有设置len变量，则为整个字符串
if "!str:~%len%!" NEQ "" (
	REM 不等于空时，len+1 并循环
	set /A len+=1
	goto strLen_Loop
)
(
endlocal
REM 输出变量
set %~2=%len%
set /A %~2zero=%len%-1
)
GOTO:EOF


