:: ============================================================================= ::
:: �Ӳֿ��ʼ��
::
:: ���˽ű���ScriptĿ¼һ���Ƶ��Ӳֿ��Ŀ¼��
:: ע�� ͨ��������˽ű�������ϻ�ɾ������
::
:: ���Ŀ¼�� ./Script/sh 
:: ����Ŀ¼�� ./ 
:: 
:: ============================================================================= ::


:: ===================================��־����========================================== ::
:: �رջ���
@echo off
:: ���������ӳ�
setlocal enabledelayedexpansion
:: ������ɫ
color 0A

:: �洢��̾�� ! 
set "T=^!"

:: cd��ת����Ŀ¼(��Ϊ��ǰ���Ŀ¼��./Script/sh��������Ҫ����)
cd %~dp0
cd..
cd..
:: ���ø�Ŀ¼·��
set root=%cd%
:: ���õ�ǰ�ű�·��
set thispath=%~dp0

:: ��־����
set log=1
:: ��־�ļ���
set logName=init.log
:: ���� ANSI ����ҳ,�����ַ�������ȷʶ�� 
chcp 936  
:: ��¼��־
if %log%==1 (
	@call :output>%logName%
) else (
	call :output
)

:: ɾ�����ű�
::del %0
exit
GOTO:EOF
:: ===================================��־����========================================== ::

:: ===================================���Ĵ���========================================== ::
:output

:: ---------------------------------- Ԥ����  ---------------------------------- ::

:::::::::::::::::::::::::git���ݿ��ж�:::::::::::::::::::::::::::::::::::
:: ����git���ݿ⣬���˳��ű�������ִ�нű�
IF EXIST .git (
    echo .git �ļ��д���	
	exit
) ELSE (
    echo ִ�в���... 
)
:::::::::::::::::::::::::git���ݿ��ж�:::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::�ض�Ŀ¼����:::::::::::::::::::::::::::::::::::
:: ָ��Ŀ¼�����ڣ��򴴽�
IF NOT EXIST "doc/md" ( mkdir "doc/md" )
IF NOT EXIST "doc/Readme" ( mkdir "doc/Readme" )
:::::::::::::::::::::::::�ض�Ŀ¼����:::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::��Ŀ¼����:::::::::::::::::::::::::::::::::::
:: ���ڿ�Ŀ¼����� .gitkeep �ļ�

:: -------------------------------------------------------- ::
:: for ѭ�� ('dir /ad /b /s')�е�Ϊ��ǰλ���µ�����Ŀ¼ȫ·���ļ��ϡ�
:: ��,
:: E:\share\z
:: E:\share\xshell
:: E:\share\cmder
:: 
:: for ѭ�� ('dir "%%i" /a /b')���ٴν������·������dir��
:: ���Ŀ¼Ϊ��(������Ŀ¼���ļ�)���򲻻����κ������
:: �� for /f %%j in ('dir "%%i" /a /b') Ϊfalse������ִ��do��������
::
:: set n=0 : ��� for /f %%j in ('dir "%%i" /a /b')  ��䡣
:: for /f %%j in ('dir "%%i" /a /b') Ϊtrue�������ǿ�Ŀ¼ʱ��n+1
:: !n! : ������!���������ܶ�ȡ set /a n+=1 �е�n
:: if !n!==0 : ��ʾ��һ�����δִ�У��������ֿ�Ŀ¼ %%i
:: �� %%i ��һ��Ҫ������ļ��������Ӧ��
:: -------------------------------------------------------- ::
for /f "delims=" %%i in ('dir /ad /b /s') do (
    set n=0
    for /f %%j in ('dir "%%i" /a /b') do ( set /a n+=1 )
    if !n!==0 echo git��Ŀ¼���� >%%i\.gitkeep
)
:::::::::::::::::::::::::��Ŀ¼����:::::::::::::::::::::::::::::::::::

echo ------------------------ ����ʱ���  ------------------------
:: ���ڴ���( 20181207 )
for /f "tokens=1-3  delims=/ " %%a in ("%date%") do (
	set de=%%a%%b%%c
)
:: ʱ�䴦��( 180016 )
for /f "tokens=1-3  delims=:." %%a in ("%time%") do (
	set ti=%%a%%b%%c
)
:: ����ʱ�� ��( 20181207180016 )
set deti=%de%%ti%
:::: ȥ�����пո�
set deti=%deti: =%
echo "%deti%"
echo ------------------------ ����ʱ���  ------------------------


:: ��ȡĿ¼��
for %%i in ("%cd%\.") do (
  set dirname=%%~ni
)
echo Ŀ¼��: %dirname% 


:: ---------------------------------- Ԥ����  ---------------------------------- ::


echo ------------------------ �ֿ�����  ------------------------ 

echo ��ʼ���ֿ�...
git init

echo �����û���...
git config user.name "kuma8866"

echo ��������... 
git config user.email "kuma8866@163.com" 

echo �����ύ����...
git config http.postBuffer  524288000   

echo ���Զ�ֿ̲�...
git remote add origin https://github.com/KumaDocCenter/%dirname%.git


echo ------------------------ �ֿ�����  ------------------------ 

:: bat������<>&�ȷ���������ļ���
:: �������ǰ���^
:: echo #include ^<stdio.h^> >.1.txt
:: ����հ� echo.
:: echo.  >>.gitignore
:: ����setlocal EnableDelayedExpansion ��!�ͱ�������,������ˣ�
:: ������Ҫ��ǰ���棡�ڱ����С�


echo ------------------------START: Commit_0  ------------------------ 
:: �ύ�հײֿ⣬ֻ���� .gitignore �ļ�

echo ��� .gitignore...
echo /start.bat >>.gitignore
echo /*.add >>.gitignore
echo !T!.gitignore >>.gitignore

echo ��ӵ��ݴ�...
git add .gitignore

echo git�ύ...
git commit -m "Commit_0 : init"

echo ------------------------END: Commit_0  ------------------------ 


echo ------------------------START: Commit_1  ------------------------ 
:: ���� doc/md �� ScriptĿ¼�����½�md��֧

echo ��� .gitignore...
echo /*.add >>.gitignore
echo !T!doc/md >>.gitignore
echo !T!Script >>.gitignore

echo ��ӵ��ݴ�...
git add .gitignore
git add doc/md/
git add Script/


echo git�ύ...
git commit -m "Commit_1 : + doc/md/* and Script"

echo �½�md��֧...
git checkout -b md

echo �л���master��֧...
git checkout master

echo ------------------------END: Commit_1  ------------------------ 



echo ------------------------START: Commit_2  ------------------------ 
::  ���������ļ�

echo ��� .gitignore...
echo .DS_Store >.gitignore
echo Thumbs.db >>.gitignore
echo /start.bat >>.gitignore
echo !T!.gitignore >>.gitignore
echo !T!**/.gitkeep >>.gitignore
echo /*.add >>.gitignore

echo ��ӵ��ݴ�...
git add .

echo git�ύ...
git commit -m "Commit_2 : + All file"

echo ------------------------END: Commit_2  ------------------------ 


echo ------------------------ ���ƹ���  ------------------------
:: ������󣬱��ⲻ��Ҫ�Ĵ���
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
:: ���ù�������
set hookname=post-commit
:: �����򱸷�
if exist ".git\hooks\%hookname%"  (
	ren .git\hooks\%hookname%   %hookname%.%deti%  
)
:: ���ƹ���
xcopy  Script\hook\SubRepo\%hookname%   .git\hooks\  /Y
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 

echo ------------------------ ���ƹ���  ------------------------


echo ------------------------ �������  ------------------------

set "dn=%dirname%.%deti%.add"
set git=https://github.com/KumaDocCenter/%dirname%.git
set name=%dirname%
set branch=md
set sh=info.bat

echo ###################################################### >%dn%
echo #  ��ģ�������������ļ� >>%dn%
echo #  ��׺   		���� >>%dn%
echo # .add        �����ģ�� >>%dn%	
echo # .init	      ��ʼ����ģ�� >>%dn%
echo # .update	  ������ģ�� >>%dn%
echo # .del		  ɾ����ģ�� >>%dn%
echo #------------------------------------------------ >>%dn%
echo #  git     :  git ��ַ >>%dn%
echo #  name    :  ��ģ������ >>%dn%
echo #  branch  :  ��ģ���֧ >>%dn%
echo #  sh  	   :  ��ִ�еĶ���ű� ·�� >>%dn%
echo ###################################################### >>%dn%
echo git=%git%>>%dn%
echo name=%name%>>%dn%
echo branch=%branch%>>%dn%
echo sh=%sh%>>%dn%

echo. 
echo ������ģ��������ļ������ɣ��뾡��ת���ļ�
echo [ %dn% ]
echo.
echo ------------------------ �������  ------------------------


echo ------------------------ YAML���  ------------------------

echo �л���md��֧
git checkout md

:: ���ýű�
call %~dp0YAMLwrite.bat

echo ��ӵ��ݴ�...
git add .

echo git�ύ...
git commit -m "Commit_3 : + md's YAML"

echo �л���master��֧
git checkout master

echo ------------------------ YAML���  ------------------------


echo ########################## �鿴��� ##########################
echo.
git branch -v

echo -----------------------------------------------------------

git log
echo.
echo ########################## �鿴��� ##########################


:: ===================================���Ĵ���========================================== ::




