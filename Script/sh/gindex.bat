:: =================================================================== ::
::  ����md�ļ�����index.md ģ��
::  
::  �����������ֶ��޸Ļ����
::  ԭ�е�index.md ����Ϊ index.md.bak0
:: 
::  ֱ�����нű�������ǰĿ¼������md�ļ�
::  �϶������ļ��ô˽ű��򿪣���ֻ�������ļ�
::  
:: ���Ŀ¼�� 
:: ����Ŀ¼�� ./source/_posts/Dev/<SubModule Name>/
:: ���Ŀ¼�� ./source_md/<SubModule Name>/doc/md/...
:: 
:: ���ļ����룺ANSI
:: =================================================================== ::
:: �رջ���
@echo off
:: ���Կ���
set debug=0
:: ���������ӳ�
setlocal EnableDelayedExpansion


:: cd��ת����Ŀ¼(��Ϊ��ǰĿ¼��<SubModule Name>��������Ҫ����)
cd %~dp0
cd..
:: ����Դ��Ŀ¼
set root=%cd%
:: ���õ�ǰ�ű�Ŀ¼
set thisdir=%~dp0

:: ��ת�ؽű�·��
cd %thisdir%
:: Ŀ¼��
for %%i in ("%cd%\.") do (
  set dirname=%%~nxi
)

:: ��ȡhexoĿ¼ HexoRoot
call :PosChar %root% source\_posts  hpos
set HexoRoot=!root:~0,%hpos%!

:: ����Ŀ���Ŀ¼
set DestRoot=%HexoRoot%source_md


REM HexoRoot: E:\...\Hexo\
REM root: E:\...\Hexo\source\_posts\Dev
REM thisdir: E:\...\Hexo\source\_posts\Dev\js.JavaScript\
REM dirname: js.JavaScript
if %debug%==1 echo ---HexoRoot: %HexoRoot%
if %debug%==1 echo ---root: %root%
if %debug%==1 echo ---thisdir: %thisdir%
if %debug%==1 echo ---dirname: %dirname%


:: �ű����ò���(��������ļ�)
set HanldeFile=%1

:: �ļ���
set filename=index.md


if %debug%==1 echo ------------------------ ��������ʱ���ʱ���  ----------------------

:: ���ڷָ���
set delim=-

:: ���ڴ���( 2018-12-10 )
for /f "tokens=1-4  delims=/ " %%a in ("%date%") do (
	set _de=%%a%delim%%%b%delim%%%c
	set de=%%a%%b%%c
	set week=%%d
)
:: ʱ�䴦��( 21:43:58 )
for /f "tokens=1-4  delims=:." %%a in ("%time%") do (
	set _ti=%%a:%%b:%%c
	set ti=%%a%%b%%c
)

:: ��ǰ����ʱ��( 2018-12-10 21:43:58 )
set "datetime=%_de% %_ti%"
if %debug%==1 echo ����ʱ�䣺"%datetime%"

:: ����ʱ�� ��( 20181207180016 )
set deti=%de%%ti%
:::: ȥ�����пո�
set timestamp=%deti: =%
if %debug%==1 echo ʱ�����"%timestamp%"
if %debug%==1 echo ------------------------ ��������ʱ���ʱ���  ----------------------


:: EQU - ����  NEQ - ������
:: �жϽű�����·���Ƿ����Ҫ��(·�����Ƿ����ָ���ַ�)
call :PosChar %root%  _posts  aa
if "%aa%" EQU "-1" (
	echo �ű�����Ŀ¼������Ҫ��
	echo �ű������˳�...
	pause
	GOTO:EOF
)


:: EQU - ����  NEQ - ������
:: ����
if "%HanldeFile%"  EQU "" (
	goto Files
) else (
	goto File
)



GOTO:EOF
:: [�������ļ�]
:: ����׷�ӵ�source_md\...\%filename%�ļ�����
:File

:: ����ָ���ĵ����ļ�
for /f "usebackq tokens=*" %%a in (`dir /a/b/s %HanldeFile%`) do (
	REM [filedir: E:\...\Hexo\source\_posts\Dev\js.JavaScript\Advanced ]
	REM [file:	  E:\...\Hexo\source\_posts\Dev\js.JavaScript\Advanced\Ajaxgaoji.md ]
	REM [filename: Ajaxgaoji ][filenameprefx: Ajaxgaoji.md ]
	if %debug%==1 echo [filedir: %%~dpa ]
	if %debug%==1 echo [file: %%a ]
	if %debug%==1 echo [filename: %%~na ][filenameprefx: %%~nxa ]

	REM ��ȡ���Ŀ¼ Rdir   �磬\Advanced\
	REM ����ǰ·���滻Ϊ��
	set str=%%~dpa
	set Rdir=!str:%root%\%dirname%=!

	if %debug%==1 echo Root: %root%
	if %debug%==1 echo DestRoot: %DestRoot%
	if %debug%==1 echo dirname: %dirname%
	if %debug%==1 echo Rdir: !Rdir!
	if %debug%==1 echo Rpath: !Rdir!%filename%
	
	REM Դ
	set s=%root%\%dirname%!Rdir!%filename%
	REM Ŀ��
	set d=%DestRoot%\%dirname%\doc\md!Rdir!%filename%
	if %debug%==1 echo s: !s!
	if %debug%==1 echo d: !d!
	
	REM ���ݲ���
	if exist "!d!"  (
		if not exist "!d!.bak0"  (
			ren "!d!"  "%filename%.bak0"
		)
	)

	REM Ŀ�겻���ڣ������YAML��Header
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
		echo # ���� >>!d!
		echo. >>!d!	
	)
	
	call :getYAML  %%a  abbrlink abbrlink
	call :getYAML  %%a  title _title
	if %debug%==1 echo abbrlink---: "!abbrlink!" 
	if %debug%==1 echo title---: "!_title!"
	
	REM EQU - ����  NEQ - ������
	REM ������ݵ�Ŀ��(�ų�%filename%)
	if "%%~nxa" NEQ "%filename%" (
		echo.## %%~na >>!d!
		echo [����Ԥ��]^(%%~nxa^)    [Blog]^(http://blog.kuma8866.top/posts/!abbrlink!/^)     [Github]^(https://github.com/KumaDocCenter/%dirname%/blob/master/doc/md/%%~nxa^)>>!d!
		REM change_line Ч�������룬δ����
		REM call :change_line  %%a  cb01
		echo. >>!d!
		echo. >>!d!
		echo. >>!d!
	)
)
GOTO:EOF





GOTO:EOF
:: [���������ļ�]
:: ���ݸ�д��source_md\...\%filename%�ļ�
:Files


:: �����ض���׺�������ļ�
for /f "usebackq tokens=*" %%a in (`dir /a/b/s *.md`) do (
	REM [filedir: E:\...\Hexo\source\_posts\Dev\js.JavaScript\Advanced ]
	REM [file:E:\...\Hexo\source\_posts\Dev\js.JavaScript\Advanced\Ajaxgaoji.md ]
	REM [filename: Ajaxgaoji ][filenameprefx: Ajaxgaoji.md ]
	if %debug%==1 echo [filedir: %%~dpa ]
	if %debug%==1 echo [file: %%a ]
	if %debug%==1 echo [filename: %%~na ][filenameprefx: %%~nxa ]

	REM ��ȡ���Ŀ¼ Rdir   �磬\Advanced\
	REM ����ǰ·���滻Ϊ��
	set str=%%~dpa
	set Rdir=!str:%root%\%dirname%=!

	if %debug%==1 echo Root: %root%
	if %debug%==1 echo DestRoot: %DestRoot%
	if %debug%==1 echo dirname: %dirname%
	if %debug%==1 echo Rdir: !Rdir!
	if %debug%==1 echo Rpath: !Rdir!%filename%
	
	REM Դ
	set s=%root%\%dirname%!Rdir!%filename%
	REM Ŀ��
	set d=%DestRoot%\%dirname%\doc\md!Rdir!%filename%
	if %debug%==1 echo s: !s!
	if %debug%==1 echo d: !d!
	
	REM ���ݲ���
	if exist "!d!"  (
		if not exist "!d!.bak0"  (
			ren "!d!"  "%filename%.bak0"
		)
	)

	REM Ŀ�겻���ڣ������YAML��Header
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
		echo # ���� >>!d!
		echo. >>!d!	
	)
	
	call :getYAML  %%a  abbrlink abbrlink
	call :getYAML  %%a  title _title
	if %debug%==1 echo abbrlink---: "!abbrlink!" 
	if %debug%==1 echo title---: "!_title!"
	
	REM EQU - ����  NEQ - ������
	REM ������ݵ�Ŀ��(�ų�%filename%)
	if "%%~nxa" NEQ "%filename%" (
		echo.## %%~na >>!d!
		echo [����Ԥ��]^(%%~nxa^)    [Blog]^(http://blog.kuma8866.top/posts/!abbrlink!/^)     [Github]^(https://github.com/KumaDocCenter/%dirname%/blob/master/doc/md/%%~nxa^)>>!d!
		REM change_line Ч�������룬δ����
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

::::::::����ʾ��:::::::::::
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
:: �������ƣ�change_line							  ::
:: �������ܣ�����ÿ������					 		  ::
:: ����������arg1: �ļ�					 		  	  ::
::  		 	   ֻ��������#��ͷ�ĸ�ʽ����		  ::
::  		 	   # !FormData!						  ::
::           arg2: �ص���������			 			  ::
::           	   ���ڴ���������					  ::
:: ����ֵ��          							      ::
::    �������ݣ�	      			  				  ::
::    %cRes%  �� �����ĵ�������					  ::
::    %~1	  �� �����ĵ�������					  ::
::        			  					  			  ::
:: ================================================== ::
:change_line

:: ��ÿ��#���滻Ϊ�ո񣬺����� *

::----------------------------------------------------------------------------
:: ��ע�⡿
REM findstr "\<#.*" Ajax.md  �Ľ������
:: �ļ�ԭʼ����
REM # �塢FormData
REM ## 5.1��ʹ��FormData�ռ�������
REM ## 5.2��ʹ��FormData����ļ��ϴ�
::
:: ʵ������
REM # �塢FormData
REM ## 5.1��ʹ��FormData�ռ�������
REM ## 5.2��ʹ��FormData����ļ��ϴ�
::----------------------------------------------------------------------------
:: ���������ļ�����
for /f "usebackq tokens=*" %%i in (`findstr "\<#.*" %~1`) do (
	if %debug%==1  echo line: "%%i"
	
	REM ���� # ����
	call :CharNum  "%%i"  #  cNum
	REM �µ�ǰ׺�ַ� Prefix
	set /A nNum=!cNum!-1
	set /A nNum=!nNum!*2
	call :BuildChar " "  !nNum!  "" "* " Prefix
	if %debug%==1 echo nStr: "!Prefix!"
	
	REM ���滻���ַ� changeChar
	call :BuildChar "#"  !cNum!  "" "" changeChar
	if %debug%==1 echo oStr: "!changeChar!"
	
	REM �ַ��滻
	set str=%%i
	call :change_Char  str "!changeChar!"  "!Prefix!"  res
	if %debug%==1 echo res: "!res!"

	REM ���ûص�����
	call :%~2  "!res!"
)
GOTO:EOF






::::::::����ʾ��:::::::::::
REM call :getYAML  file key  VarName

::call :getYAML  Ajaxgaoji.md  typora-root-url tr
::echo typora-root-url---: %tr%

GOTO:EOF
:: ================================================== ::
:: �������ƣ�getYAML							 	  ::
:: �������ܣ���ȡYAML��ָ��key��ֵ		 			  ::
:: ����������arg1: �ļ�					 		  	  ::
::  		 arg2: YAML key			 			 	  ::
::  		 arg3: ������				 			  ::
::  		 	   �洢����ı�������	 			  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    %<arg3>%  �� YAML key��ֵ					      ::
::        			  					  			  ::
:: ================================================== ::
:getYAML
:: �ջ� setlocal ... endlocal
setlocal

:: ����key
set Ykey=%~2

:: EQU - ����  NEQ - ������
:: ��ȡ YAML �е�ָ��key(�磬typora-root-url)��ֵ���洢�ڱ����� mdroot
for /f "usebackq tokens=* skip=1" %%a in ("%~1") do (
	if %debug%==1 echo [Yline: %%a ]
	REM ��ǰ�����ݺ�"---"�Ƚ� 
	if "%%a" EQU "---" (
		REM ��ȣ����˳�
		GOTO gg
	) else (
		REM ����ȣ��������ǰ�����ݣ�������ָ������
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
REM �������
set %~3=%mdroot%
)
GOTO:EOF







:: =================================================================== ::
::  �ַ�������
:: 
:: �������ƣ�PosChar							  	  ::
:: �������ܣ����ַ����в������ַ����״γ���λ��		  ::
:: 
:: �������ƣ�PosLastChar						  	  ::
:: �������ܣ����ַ����в������ַ������һ�γ���λ��	  ::
:: 
:: �������ƣ�StrLen							  		  ::
:: �������ܣ��ַ�������								  ::
::
:: �������ƣ�BuildChar								  ::
:: �������ܣ��ַ�������		 						  ::
:: 
:: �������ƣ�CharNum							      ::
:: �������ܣ�ָ���ַ��״��������ֵ�����				  ::
::
:: �������ƣ�change_Char							  ::
:: �������ܣ��ַ����޸�		 						  :: 
:: 
:: ���Ŀ¼��  
:: ����Ŀ¼��   
:: 
:: =================================================================== ::



::::::::����ʾ��:::::::::::
REM call :PosChar  Str SubStr VarName

:: �����ַ���
::set k=speed_dao_mmr
:: ���ú���
::call :PosChar %k% _ aa
::echo ...��0��ʼ����...
::echo �״γ���λ��(5): %aa%


GOTO:EOF
:: ================================================== ::
:: �������ƣ�PosChar							  	  ::
:: �������ܣ����ַ����в������ַ����״γ���λ��		  ::
:: ����������arg1: �ַ���				 		 	  ::
::  		 arg2: ���ַ���				 			  ::
::  		 arg3: ������				 			  ::
::  		 	   �洢����ı�������	 			  ::
::           							 			  ::
:: ����ֵ��          							      ::
::        %<arg3>%  �� ��ȡλ����Ϣ   			  	  ::
::        			   -1����ʾδ�ҵ�   			  ::
:: ================================================== ::
:PosChar
:: �ջ� setlocal ... endlocal
setlocal 

:: ��ȡ���ַ���
set SubStr=
:: �ַ���
set Str=%~1
:: λ�ü���
set F=0
:: ���ý������
set res=-1

:: ��ȡ��������ַ�������
call :StrLen  %~2  SubStrLen
if %debug%==1 echo SubStrLen: %SubStrLen%

::----------------------------------------------------------------
:: ��ע�⡿
:: set SubStr=!Str:~%F%,%SubStrLen%!
:: ��ȡ�ַ����Ͳ���2�Ƚ� ( "%SubStr%"=="%2" )
:: 		ƥ�䵽1���������ò����ؽ��( set res=%F% )���˳�
:: 		δƥ�䣬������ȡ�ַ����������Ƚϣ����ѭ��<ֱ��ƥ���ĩβ>
:: 		1����δƥ��ʱ������Ĭ��ֵ -1 ( set res=-1 )
::	
::----------------------------------------------------------------
:Pos_Begin
:: ��ȡ�ַ���
:: �ӵ�%F%����ʼ����ȡ%SubStrLen%��
set SubStr=!Str:~%F%,%SubStrLen%!

:: ���SubStrδ���壬�� SubStr=��ʱ���˳�
if not defined SubStr goto Pos_End

:: ��ȡ���ַ����ʹ������2�Ƚ� 
if "%SubStr%"=="%~2" (
    REM ��ȣ�������res=�������˳�
	set res=%F%
    goto Pos_End
) else (
    REM ����ȣ�����+1��ѭ��
	set /a F=%F%+1
    goto Pos_begin
)
:Pos_End
(
endlocal
REM �������
set %~3=%res%
)
GOTO:EOF


::::::::����ʾ��:::::::::::
REM :PosLastChar Str SubStr VarName

:: �����ַ���
::set k=speed_dao_mmr
:: ���ú���
::call :PosLastChar %k% _ bb
::echo ...��0��ʼ����...
::echo ���һ�γ���λ��(9)��%bb%



GOTO:EOF
:: ================================================== ::
:: �������ƣ�PosLastChar						  	  ::
:: �������ܣ����ַ����в������ַ������һ�γ���λ��	  ::
:: ����������arg1: �ַ���				 		 	  ::
::  		 arg2: ���ַ���				 			  ::
::  		 arg3: ������				 			  ::
::  		 	   �洢����ı�������	 			  ::
::           							 			  ::
:: ����ֵ��          							      ::
::        %<arg3>%  �� ��ȡλ����Ϣ   			  	  ::
::        			   -1����ʾδ�ҵ�   			  ::
:: ================================================== ::
:PosLastChar
:: �ջ� setlocal ... endlocal
setlocal 

:: ��ȡ���ַ���
set SubStr=
:: �ַ���
set Str=%~1
:: λ�ü���
set F=0
:: ���ý������
set res=-1

:: ��ȡ��������ַ�������
call :StrLen  %~2  SubStrLen
if %debug%==1 echo SubStrLen: %SubStrLen%

::----------------------------------------------------------------
:: ��ע�⡿
:: set SubStr=!Str:~%F%,%SubStrLen%!
:: ��ȡ�ַ����Ͳ���2�Ƚ� ( "%SubStr%"=="%2" )
:: 		ƥ�䵽�����ý��( set res=%F% )��������ȡ�ַ����������Ƚϣ����ѭ��<ֱ��ĩβ>
:: 		δƥ�䣬������ȡ�ַ����������Ƚϣ����ѭ��<ֱ��ƥ���ĩβ>
::		���ս��Ϊ���ƥ���λ�á�
::		1����δƥ��ʱ������Ĭ��ֵ -1 ( set res=-1 )
::	
::----------------------------------------------------------------
:PosLast_Begin
:: ��ȡ�ַ���
:: �ӵ�%F%����ʼ����ȡ%SubStrLen%��
set SubStr=!Str:~%F%,%SubStrLen%!
:: ���SubStrδ���壬�� SubStr=��ʱ���˳�
if not defined SubStr goto PosLast_End
:: ��ȡ���ַ����ʹ������2�Ƚ� 
if "%SubStr%"=="%~2" (
    REM ��ȣ�������res=����������+1��Ȼ��ѭ��
	set res=%F%
    set /a F=%F%+1
    goto PosLast_Begin
) else (
    REM ��ȣ�����+1��Ȼ��ѭ��
	set /a F=%F%+1
    goto PosLast_Begin
)
:PosLast_End
(
endlocal
REM �������
set %~3=%res%
)
GOTO:EOF


::::::::����ʾ��:::::::::::
REM call :StrLen  Str  VarName

::call :StrLen  abc  strl
::echo abc ���ȣ� %strl%
::echo abc ����zero�� %strlzero%

GOTO:EOF
:: ================================================== ::
:: �������ƣ�StrLen							  		  ::
:: �������ܣ��ַ�������								  ::
:: ����������arg1: �ַ���				 		 	  ::
::  		 arg2: ������				 			  ::
::  		 	   �洢����ı�������	 			  ::
::           							 			  ::
:: ����ֵ��          							      ::
::        %<arg2>%  �� ��ȡ����(ʵ�ʳ���)  			  ::
::    %<arg2zero>%  �� ��ȡ����(����-1)		  	 	  ::
:: ================================================== ::
:StrLen
:: �ջ� setlocal ... endlocal
setlocal  
:: �ַ���
set str=%~1

:strLen_Loop
:: EQU - ����  NEQ - ������
:: �� %len% ���ַ���ʼ��ȡ�����
:: ��ʼʱ��û������len��������Ϊ�����ַ���
if "!str:~%len%!" NEQ "" (
	REM �����ڿ�ʱ��len+1 ��ѭ��
	set /A len+=1
	goto strLen_Loop
)
(
endlocal
REM �������
set %~2=%len%
set /A %~2zero=%len%-1
)
GOTO:EOF



::::::::����ʾ��:::::::::::
REM call :BuildChar  Char  Num  Prefix  Suffix   VarName

::call :BuildChar "A"  3  "" "" cres
::call :BuildChar "A"  3  "B" "C" cres
::echo cres: "!cres!"


GOTO:EOF
:: ================================================== ::
:: �������ƣ�BuildChar								  ::
:: �������ܣ��ַ�������		 						  ::
:: ����������arg1: �ַ�				 		  	  	  ::
::  		 	   ��Ҫ�����ĵ����ַ�	 			  ::
::  		 arg2: ����				 				  ::
::  		 arg3: ǰ׺,���� ""		 			  	  ::
::  		 arg4: ��׺,���� ""	 					  ::
::  		 arg5: ������				 			  ::
::  		 	   �洢����ı�������	 			  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    %<arg5>%  �� ���							      ::
::        			  					  			  ::
:: ================================================== ::
:BuildChar
:: �ջ� setlocal ... endlocal
setlocal

:: �ַ�
set Char=%~1
:: ����
set Num=%~2
:: ����
set i=1
:: ���
set res=

::GTR - ���� 
:BuildChar_Loop
:: ���������������˳�
if !i! GTR %Num% GOTO BuildChar_Loop_END
:: �ַ�����
set res=!res!!Char!
:: ����+1
set /A i+=1
:: ѭ��
GOTO BuildChar_Loop

:BuildChar_Loop_END
(
endlocal
REM �������
set %~5=%~3%res%%~4
)
GOTO:EOF




::::::::����ʾ��:::::::::::
REM call :CharNum  Str  Char VarName

::call :CharNum  ####AFDFE#  #  res
::echo # ����(4)�� %res%


GOTO:EOF
:: ================================================== ::
:: �������ƣ�CharNum							      ::
:: �������ܣ�ָ���ַ��״��������ֵ�����				  ::
:: ����������arg1: �ַ���				 		 	  ::
::  		 arg2: �ַ�				 			  	  ::
::  		 	   �����ַ�					 		  ::
::  		 arg3: ������				 			  ::
::  		 	   �洢����ı�������	 			  ::
::           							 			  ::
:: ����ֵ��          							      ::
::        %<arg3>%  �� ��ȡָ���ַ����ֵ�����  		  ::
::   										  	 	  ::
:: ================================================== ::
:CharNum
:: �ջ� setlocal ... endlocal
setlocal 
 
:: �ַ���
set str=%~1
:: ����
set len=0

:CharNum_Loop
:: EQU - ����  NEQ - ������
:: �� %len% ���ַ���ʼ��ȡ1��
if "!str:~%len%,1!" EQU "%~2" (
	REM ����"%~2"ʱ��len+1 ��ѭ��
	set /A len+=1
	goto CharNum_Loop
)
(
endlocal
REM �������
set %~3=%len%
)
GOTO:EOF



::::::::����ʾ��:::::::::::
REM call :change_Char  Str  Ostr Nstr  VarName

::call :change_Char  str Ostr Nstr  res

GOTO:EOF
:: ================================================== ::
:: �������ƣ�change_Char							  ::
:: �������ܣ��ַ����޸�		 						  ::
:: ����������arg1: ԭʼ�ַ����ı�������				  ::
::  		 arg2: ���ַ���				 			  ::
::  		 arg3: ���ַ���				 			  ::
::  		 arg4: ������				 			  ::
::  		 	   �洢����ı�������	 			  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    %<arg4>%  �� ���ַ����滻Ϊ���ַ����Ľ��		  ::
::        			  					  			  ::
:: ================================================== ::
:change_Char

:: ԭʼ�ַ���
set _Str=%~1
:: ���ַ���
set _oStr=%~2
:: ���ַ���
set _nStr=%~3

:: �ַ��滻
set %~4=!%_Str%:%_oStr%=%_nStr%!

GOTO:EOF




:: ==========[Function]================================================================== ::

