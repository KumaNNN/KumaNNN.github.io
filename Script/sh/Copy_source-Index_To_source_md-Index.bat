:: =================================================================== ::
:: ����source�µ�index.md �� source_md ��
:: 
:: �Զ�ɾ�����ű�
::
:: ���Ŀ¼�� 
:: ����Ŀ¼�� ./source/_posts/Dev/<SubModule Name>
::
:: =================================================================== ::
:: �رջ���
@echo off
:: ���������ӳ���չ
SETLOCAL EnableDelayedExpansion 
:: ���Կ���
set debug=0

:: �Ƿ�ɾ�����ű�
set is_del=1

:: cd��ת����Ŀ¼(��Ϊ��ǰĿ¼��<SubModule Name>��������Ҫ����)
cd %~dp0
cd..
:: ����Դ��Ŀ¼
set root=%cd%
:: ���õ�ǰ�ű�Ŀ¼
set thisdir=%~dp0

:: ��ת�ؽű�·������ȡĿ¼��
cd %thisdir%
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



:: EQU - ����  NEQ - ������
:: �жϽű�����·���Ƿ����Ҫ��(·�����Ƿ����ָ���ַ�)
call :PosChar %root%  _posts  aa
if "%aa%" EQU "-1" (
	echo �ű�����Ŀ¼������Ҫ��
	echo �ű������˳�...
	pause
	GOTO:EOF
)


:: ������ǰ·���µ�index.md�ļ�(���ڵ�)
:: �����ļ�
for /r "%thisdir%" %%i in (index.md) do if exist %%i  (
	REM echo File: %%i 
	
	REM ��ȡ���Ŀ¼ str 
	REM �磬\Advanced\
	REM ����ǰ·�����ļ����滻Ϊ��
	set str=%%i
	set str=!str:%root%\%dirname%=!
	set str=!str:index.md=!
		
	if %debug%==1 echo Root: %root%
	if %debug%==1 echo DestRoot: %DestRoot%
	if %debug%==1 echo dirname: %dirname%
	if %debug%==1 echo Rdir: !str!
	if %debug%==1 echo Rpath: !str!index.md
	
	REM Դ
	set s=%root%\%dirname%!str!index.md
	REM Ŀ��Ŀ¼
	set d=%DestRoot%\%dirname%\doc\md!str!
	if %debug%==1 echo s: !s!
	if %debug%==1 echo d: !d!
	
	REM Ŀ¼���ڲŸ���
	if exist "%DestRoot%\%dirname%" (
		if exist "%DestRoot%\%dirname%\doc\md" (
			xcopy "!s!"  "!d!"  /Y/Q 
		)
	)
)
:: EQU - ����  NEQ - ������
:: ɾ�����ű�
if "%is_del%" EQU "1"  del %0
GOTO:EOF



:: ==========[Function]================================================================== ::


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


