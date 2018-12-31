:: =================================================================== ::
::  根据md文件生成index.md 模版
::  
::  部分内容需手动修改或添加
::  原有的index.md 备份为 index.md.bak0
:: 
::  直接运行脚本，则处理当前目录下所有md文件
::  拖动单个文件用此脚本打开，则只处理单个文件
::  
:: 存放目录： 
:: 运行目录： ./source/_posts/Dev/<SubModule Name>/
:: 输出目录： ./source_md/<SubModule Name>/doc/md/...
:: 
:: 本文件编码：ANSI
:: =================================================================== ::
:: 关闭回显
@echo off
:: 调试开关
set debug=0
:: 开启变量延迟
setlocal EnableDelayedExpansion


:: cd跳转到根目录(因为当前目录：<SubModule Name>，所以需要更改)
cd %~dp0
cd..
:: 设置源根目录
set root=%cd%
:: 设置当前脚本目录
set thisdir=%~dp0

:: 跳转回脚本路径
cd %thisdir%
:: 目录名
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


:: 脚本调用参数(待处理的文件)
set HanldeFile=%1

:: 文件名
set filename=index.md


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
if %debug%==1 echo 日期时间："%datetime%"

:: 日期时间 戳( 20181207180016 )
set deti=%de%%ti%
:::: 去除所有空格
set timestamp=%deti: =%
if %debug%==1 echo 时间戳："%timestamp%"
if %debug%==1 echo ------------------------ 简易日期时间和时间戳  ----------------------


:: EQU - 等于  NEQ - 不等于
:: 判断脚本所在路径是否符合要求(路径中是否包含指定字符)
call :PosChar %root%  _posts  aa
if "%aa%" EQU "-1" (
	echo 脚本运行目录不符合要求
	echo 脚本即将退出...
	pause
	GOTO:EOF
)


:: EQU - 等于  NEQ - 不等于
:: 调度
if "%HanldeFile%"  EQU "" (
	goto Files
) else (
	goto File
)



GOTO:EOF
:: [处理单个文件]
:: 内容追加到source_md\...\%filename%文件后面
:File

:: 遍历指定的单个文件
for /f "usebackq tokens=*" %%a in (`dir /a/b/s %HanldeFile%`) do (
	REM [filedir: E:\...\Hexo\source\_posts\Dev\js.JavaScript\Advanced ]
	REM [file:	  E:\...\Hexo\source\_posts\Dev\js.JavaScript\Advanced\Ajaxgaoji.md ]
	REM [filename: Ajaxgaoji ][filenameprefx: Ajaxgaoji.md ]
	if %debug%==1 echo [filedir: %%~dpa ]
	if %debug%==1 echo [file: %%a ]
	if %debug%==1 echo [filename: %%~na ][filenameprefx: %%~nxa ]

	REM 获取相对目录 Rdir   如，\Advanced\
	REM 将当前路径替换为空
	set str=%%~dpa
	set Rdir=!str:%root%\%dirname%=!

	if %debug%==1 echo Root: %root%
	if %debug%==1 echo DestRoot: %DestRoot%
	if %debug%==1 echo dirname: %dirname%
	if %debug%==1 echo Rdir: !Rdir!
	if %debug%==1 echo Rpath: !Rdir!%filename%
	
	REM 源
	set s=%root%\%dirname%!Rdir!%filename%
	REM 目标
	set d=%DestRoot%\%dirname%\doc\md!Rdir!%filename%
	if %debug%==1 echo s: !s!
	if %debug%==1 echo d: !d!
	
	REM 备份策略
	if exist "!d!"  (
		if not exist "!d!.bak0"  (
			ren "!d!"  "%filename%.bak0"
		)
	)

	REM 目标不存在，则输出YAML和Header
	if not exist "!d!"  (	
		echo --->!d!
		echo title: Index >>!d!
		echo date: %datetime% >>!d!
		echo updated: %datetime% >>!d!
		echo mathjax: false >>!d!
		echo categories:  >>!d!
		echo tags: >>!d!
		echo typora-root-url: index>>!d!
		echo typora-copy-images-to: index>>!d!
		echo top: ^0>>!d!
		echo --->>!d!
		echo.>>!d!
		echo.>>!d!
		echo # 索引 >>!d!
		echo. >>!d!	
	)
	
	call :getYAML  %%a  abbrlink abbrlink
	call :getYAML  %%a  title _title
	if %debug%==1 echo abbrlink---: "!abbrlink!" 
	if %debug%==1 echo title---: "!_title!"
	
	REM EQU - 等于  NEQ - 不等于
	REM 输出内容到目标(排除%filename%)
	if "%%~nxa" NEQ "%filename%" (
		echo.## %%~na >>!d!
		echo [本地预览]^(%%~nxa^)    [Blog]^(http://blog.kuma8866.top/posts/!abbrlink!/^)     [Github]^(https://github.com/KumaDocCenter/%dirname%/blob/master/doc/md/%%~nxa^)>>!d!
		REM change_line 效果不理想，未启用
		REM call :change_line  %%a  cb01
		echo. >>!d!
		echo. >>!d!
		echo. >>!d!
	)
)
GOTO:EOF





GOTO:EOF
:: [处理所有文件]
:: 内容覆写到source_md\...\%filename%文件
:Files


:: 遍历特定后缀的所有文件
for /f "usebackq tokens=*" %%a in (`dir /a/b/s *.md`) do (
	REM [filedir: E:\...\Hexo\source\_posts\Dev\js.JavaScript\Advanced ]
	REM [file:E:\...\Hexo\source\_posts\Dev\js.JavaScript\Advanced\Ajaxgaoji.md ]
	REM [filename: Ajaxgaoji ][filenameprefx: Ajaxgaoji.md ]
	if %debug%==1 echo [filedir: %%~dpa ]
	if %debug%==1 echo [file: %%a ]
	if %debug%==1 echo [filename: %%~na ][filenameprefx: %%~nxa ]

	REM 获取相对目录 Rdir   如，\Advanced\
	REM 将当前路径替换为空
	set str=%%~dpa
	set Rdir=!str:%root%\%dirname%=!

	if %debug%==1 echo Root: %root%
	if %debug%==1 echo DestRoot: %DestRoot%
	if %debug%==1 echo dirname: %dirname%
	if %debug%==1 echo Rdir: !Rdir!
	if %debug%==1 echo Rpath: !Rdir!%filename%
	
	REM 源
	set s=%root%\%dirname%!Rdir!%filename%
	REM 目标
	set d=%DestRoot%\%dirname%\doc\md!Rdir!%filename%
	if %debug%==1 echo s: !s!
	if %debug%==1 echo d: !d!
	
	REM 备份策略
	if exist "!d!"  (
		if not exist "!d!.bak0"  (
			ren "!d!"  "%filename%.bak0"
		)
	)

	REM 目标不存在，则输出YAML和Header
	if not exist "!d!"  (	
		echo --->!d!
		echo title: Index >>!d!
		echo date: %datetime% >>!d!
		echo updated: %datetime% >>!d!
		echo mathjax: false >>!d!
		echo categories:  >>!d!
		echo tags: >>!d!
		echo typora-root-url: index>>!d!
		echo typora-copy-images-to: index>>!d!
		echo top: ^0>>!d!
		echo --->>!d!
		echo.>>!d!
		echo.>>!d!
		echo # 索引 >>!d!
		echo. >>!d!	
	)
	
	call :getYAML  %%a  abbrlink abbrlink
	call :getYAML  %%a  title _title
	if %debug%==1 echo abbrlink---: "!abbrlink!" 
	if %debug%==1 echo title---: "!_title!"
	
	REM EQU - 等于  NEQ - 不等于
	REM 输出内容到目标(排除%filename%)
	if "%%~nxa" NEQ "%filename%" (
		echo.## %%~na >>!d!
		echo [本地预览]^(%%~nxa^)    [Blog]^(http://blog.kuma8866.top/posts/!abbrlink!/^)     [Github]^(https://github.com/KumaDocCenter/%dirname%/blob/master/doc/md/%%~nxa^)>>!d!
		REM change_line 效果不理想，未启用
		REM call :change_line  %%a  cb01
		echo. >>!d!
		echo. >>!d!
		echo. >>!d!
	)
)
GOTO:EOF


GOTO:EOF
:cb01
echo ----------------------------
if %debug%==1 echo cb01_line: %~1

REM echo %~1>>%filename%

echo ----------------------------
if %debug%==1 echo.
GOTO:EOF






:: ==========[Function]================================================================== ::

::::::::调用示例:::::::::::
REM call :get_pic_pathinfo  file 

::call :get_pic_pathinfo  Ajaxgaoji.md  cb01
::GOTO:EOF
:::cb01
::echo ----------------------------
::echo FileName---: %FileName%
::echo FileRpath---: %FileRpath%
::echo ----------------------------
::echo.
::GOTO:EOF


GOTO:EOF
:: ================================================== ::
:: 函数名称：change_line							  ::
:: 函数功能：更改每行数据					 		  ::
:: 函数参数：arg1: 文件					 		  	  ::
::  		 	   只解析如下#开头的格式数据		  ::
::  		 	   # !FormData!						  ::
::           arg2: 回调函数名称			 			  ::
::           	   用于处理单个数据					  ::
:: 返回值：          							      ::
::    单个数据：	      			  				  ::
::    %cRes%  ： 处理后的单行数据					  ::
::    %~1	  ： 处理后的单行数据					  ::
::        			  					  			  ::
:: ================================================== ::
:change_line

:: 将每个#号替换为空格，后连接 *

::----------------------------------------------------------------------------
:: 【注解】
REM findstr "\<#.*" Ajax.md  的结果如下
:: 文件原始数据
REM # 五、FormData
REM ## 5.1、使用FormData收集表单数据
REM ## 5.2、使用FormData完成文件上传
::
:: 实际数据
REM # 五、FormData
REM ## 5.1、使用FormData收集表单数据
REM ## 5.2、使用FormData完成文件上传
::----------------------------------------------------------------------------
:: 遍历单个文件内容
for /f "usebackq tokens=*" %%i in (`findstr "\<#.*" %~1`) do (
	if %debug%==1  echo line: "%%i"
	
	REM 计算 # 数量
	call :CharNum  "%%i"  #  cNum
	REM 新的前缀字符 Prefix
	set /A nNum=!cNum!-1
	set /A nNum=!nNum!*2
	call :BuildChar " "  !nNum!  "" "* " Prefix
	if %debug%==1 echo nStr: "!Prefix!"
	
	REM 待替换的字符 changeChar
	call :BuildChar "#"  !cNum!  "" "" changeChar
	if %debug%==1 echo oStr: "!changeChar!"
	
	REM 字符替换
	set str=%%i
	call :change_Char  str "!changeChar!"  "!Prefix!"  res
	if %debug%==1 echo res: "!res!"

	REM 调用回调函数
	call :%~2  "!res!"
)
GOTO:EOF






::::::::调用示例:::::::::::
REM call :getYAML  file key  VarName

::call :getYAML  Ajaxgaoji.md  typora-root-url tr
::echo typora-root-url---: %tr%

GOTO:EOF
:: ================================================== ::
:: 函数名称：getYAML							 	  ::
:: 函数功能：获取YAML中指定key的值		 			  ::
:: 函数参数：arg1: 文件					 		  	  ::
::  		 arg2: YAML key			 			 	  ::
::  		 arg3: 变量名				 			  ::
::  		 	   存储结果的变量名称	 			  ::
::           							 			  ::
:: 返回值：          							      ::
::    %<arg3>%  ： YAML key的值					      ::
::        			  					  			  ::
:: ================================================== ::
:getYAML
:: 闭环 setlocal ... endlocal
setlocal

:: 设置key
set Ykey=%~2

:: EQU - 等于  NEQ - 不等于
:: 获取 YAML 中的指定key(如，typora-root-url)的值，存储在变量名 mdroot
for /f "usebackq tokens=* skip=1" %%a in ("%~1") do (
	if %debug%==1 echo [Yline: %%a ]
	REM 当前行内容和"---"比较 
	if "%%a" EQU "---" (
		REM 相等，则退出
		GOTO gg
	) else (
		REM 不相等，则解析当前行内容，并设置指定变量
		for /f "usebackq tokens=1,* delims=: " %%i in ('%%a') do (
			if %debug%==1 echo [Ykey: %%i ]  [Yvalue: %%j ]
			REM "%%i" == "%Ykey%"
			if "%%i" EQU "%Ykey%" (
				set mdroot=%%j
			)
		)
	)
)
:gg
if %debug%==1 echo %Ykey%: "!mdroot!"
(
endlocal
REM 输出变量
set %~3=%mdroot%
)
GOTO:EOF







:: =================================================================== ::
::  字符串处理
:: 
:: 函数名称：PosChar							  	  ::
:: 函数功能：在字符串中查找子字符串首次出现位置		  ::
:: 
:: 函数名称：PosLastChar						  	  ::
:: 函数功能：在字符串中查找子字符串最后一次出现位置	  ::
:: 
:: 函数名称：StrLen							  		  ::
:: 函数功能：字符串长度								  ::
::
:: 函数名称：BuildChar								  ::
:: 函数功能：字符串构建		 						  ::
:: 
:: 函数名称：CharNum							      ::
:: 函数功能：指定字符首次连续出现的数量				  ::
::
:: 函数名称：change_Char							  ::
:: 函数功能：字符串修改		 						  :: 
:: 
:: 存放目录：  
:: 运行目录：   
:: 
:: =================================================================== ::



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
REM :PosLastChar Str SubStr VarName

:: 设置字符串
::set k=speed_dao_mmr
:: 调用函数
::call :PosLastChar %k% _ bb
::echo ...从0开始计算...
::echo 最后一次出现位置(9)：%bb%



GOTO:EOF
:: ================================================== ::
:: 函数名称：PosLastChar						  	  ::
:: 函数功能：在字符串中查找子字符串最后一次出现位置	  ::
:: 函数参数：arg1: 字符串				 		 	  ::
::  		 arg2: 子字符串				 			  ::
::  		 arg3: 变量名				 			  ::
::  		 	   存储结果的变量名称	 			  ::
::           							 			  ::
:: 返回值：          							      ::
::        %<arg3>%  ： 获取位置信息   			  	  ::
::        			   -1，表示未找到   			  ::
:: ================================================== ::
:PosLastChar
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
:: 		匹配到，设置结果( set res=%F% )，继续截取字符串，继续比较，如此循环<直到末尾>
:: 		未匹配，继续截取字符串，继续比较，如此循环<直到匹配或到末尾>
::		最终结果为最后匹配的位置。
::		1个都未匹配时，返回默认值 -1 ( set res=-1 )
::	
::----------------------------------------------------------------
:PosLast_Begin
:: 截取字符串
:: 从第%F%个开始，截取%SubStrLen%个
set SubStr=!Str:~%F%,%SubStrLen%!
:: 如果SubStr未定义，即 SubStr=空时，退出
if not defined SubStr goto PosLast_End
:: 截取的字符串和传入参数2比较 
if "%SubStr%"=="%~2" (
    REM 相等，则设置res=计数，计数+1，然后循环
	set res=%F%
    set /a F=%F%+1
    goto PosLast_Begin
) else (
    REM 相等，计数+1，然后循环
	set /a F=%F%+1
    goto PosLast_Begin
)
:PosLast_End
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



::::::::调用示例:::::::::::
REM call :BuildChar  Char  Num  Prefix  Suffix   VarName

::call :BuildChar "A"  3  "" "" cres
::call :BuildChar "A"  3  "B" "C" cres
::echo cres: "!cres!"


GOTO:EOF
:: ================================================== ::
:: 函数名称：BuildChar								  ::
:: 函数功能：字符串构建		 						  ::
:: 函数参数：arg1: 字符				 		  	  	  ::
::  		 	   需要构建的单个字符	 			  ::
::  		 arg2: 数量				 				  ::
::  		 arg3: 前缀,无则 ""		 			  	  ::
::  		 arg4: 后缀,无则 ""	 					  ::
::  		 arg5: 变量名				 			  ::
::  		 	   存储结果的变量名称	 			  ::
::           							 			  ::
:: 返回值：          							      ::
::    %<arg5>%  ： 结果							      ::
::        			  					  			  ::
:: ================================================== ::
:BuildChar
:: 闭环 setlocal ... endlocal
setlocal

:: 字符
set Char=%~1
:: 数量
set Num=%~2
:: 步长
set i=1
:: 结果
set res=

::GTR - 大于 
:BuildChar_Loop
:: 步长大于数量，退出
if !i! GTR %Num% GOTO BuildChar_Loop_END
:: 字符连接
set res=!res!!Char!
:: 步长+1
set /A i+=1
:: 循环
GOTO BuildChar_Loop

:BuildChar_Loop_END
(
endlocal
REM 输出变量
set %~5=%~3%res%%~4
)
GOTO:EOF




::::::::调用示例:::::::::::
REM call :CharNum  Str  Char VarName

::call :CharNum  ####AFDFE#  #  res
::echo # 数量(4)： %res%


GOTO:EOF
:: ================================================== ::
:: 函数名称：CharNum							      ::
:: 函数功能：指定字符首次连续出现的数量				  ::
:: 函数参数：arg1: 字符串				 		 	  ::
::  		 arg2: 字符				 			  	  ::
::  		 	   单个字符					 		  ::
::  		 arg3: 变量名				 			  ::
::  		 	   存储结果的变量名称	 			  ::
::           							 			  ::
:: 返回值：          							      ::
::        %<arg3>%  ： 获取指定字符出现的数量  		  ::
::   										  	 	  ::
:: ================================================== ::
:CharNum
:: 闭环 setlocal ... endlocal
setlocal 
 
:: 字符串
set str=%~1
:: 步长
set len=0

:CharNum_Loop
:: EQU - 等于  NEQ - 不等于
:: 从 %len% 个字符开始截取1个
if "!str:~%len%,1!" EQU "%~2" (
	REM 等于"%~2"时，len+1 并循环
	set /A len+=1
	goto CharNum_Loop
)
(
endlocal
REM 输出变量
set %~3=%len%
)
GOTO:EOF



::::::::调用示例:::::::::::
REM call :change_Char  Str  Ostr Nstr  VarName

::call :change_Char  str Ostr Nstr  res

GOTO:EOF
:: ================================================== ::
:: 函数名称：change_Char							  ::
:: 函数功能：字符串修改		 						  ::
:: 函数参数：arg1: 原始字符串的变量名称				  ::
::  		 arg2: 旧字符串				 			  ::
::  		 arg3: 新字符串				 			  ::
::  		 arg4: 变量名				 			  ::
::  		 	   存储结果的变量名称	 			  ::
::           							 			  ::
:: 返回值：          							      ::
::    %<arg4>%  ： 旧字符串替换为新字符串的结果		  ::
::        			  					  			  ::
:: ================================================== ::
:change_Char

:: 原始字符串
set _Str=%~1
:: 旧字符串
set _oStr=%~2
:: 新字符串
set _nStr=%~3

:: 字符替换
set %~4=!%_Str%:%_oStr%=%_nStr%!

GOTO:EOF




:: ==========[Function]================================================================== ::

