:: ============================================================================= ::
:: ������ģ�鹳��
::
:: ���˽ű���ScriptĿ¼һ���Ƶ��Ӳֿ��Ŀ¼��
:: ע�� ͨ��������˽ű�������ϻ�ɾ������
::
:: ���Ŀ¼�� ./Script/sh 
:: ����Ŀ¼�� ./
:: 
:: ��������� 
:: %1 : ��ģ����      (Ajax)
:: ============================================================================= ::

:: �رջ���
@echo off
:: ���������ӳ�
setlocal enabledelayedexpansion
:: ���Կ���
set debug=0

:: cd��ת����Ŀ¼(��Ϊ��ǰ���Ŀ¼��./Script/sh��������Ҫ����)
cd %~dp0
cd..
cd..
:: ���ø�Ŀ¼·��
set root=%cd%
:: ���õ�ǰ�ű�·��
set thispath=%~dp0
:: ������ģ���Ŀ¼
set SubModuleRoot=source_md

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
if %debug%==1 echo "%datetime%"

:: ����ʱ�� ��( 20181207180016 )
set deti=%de%%ti%
:::: ȥ�����пո�
set timestamp=%deti: =%
if %debug%==1 echo "%timestamp%"

if %debug%==1 echo ------------------------ ��������ʱ���ʱ���  ----------------------




echo ------------------------ ���ƹ���  ------------------------
:: %1 : ��ģ����      (Ajax)
:: ֻ��������ģ�飬�Ӳֿⲻ��Ҫ�˹���
:: .git/modules/source_md/Ajax

:: �����ļ�Դ·��
set hook_spath=Script\hook\SubModule
:: �����ļ�Ŀ��·��
set hook_dpath=.git\modules\%SubModuleRoot%\%1

call :copy_hook  "%hook_spath%"   "%hook_dpath%"  post-commit  %timestamp%
call :copy_hook  "%hook_spath%"   "%hook_dpath%"  post-checkout  %timestamp%
call :copy_hook  "%hook_spath%"   "%hook_dpath%"  post-merge  %timestamp%
call :copy_hook  "%hook_spath%"   "%hook_dpath%"  pre-push  %timestamp%

echo ------------------------ ���ƹ���  ------------------------

exit




:: ==========[Function]================================================================== ::


GOTO:EOF
:: ================================================== ::
:: �������ƣ�copy_hook								  ::
:: �������ܣ����ƹ���								  ::
:: ����������arg1: �����ļ�Դ·�� 					  ::
::           	   �磬Script\hook\SubModule		  ::
::           arg2: �����ļ�Ŀ��·��					  ::
::           	   �磬.git\modules\source_md\Ajax	  ::
::           arg3: ��������	 					 	  ::
::           arg4: ʱ���	 					 	  ::
:: ����ֵ�� 									 	  ::
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


:: %1 : ��ģ����      (Ajax)
:: ֻ��������ģ�飬�Ӳֿⲻ��Ҫ�˹���
:: .git/modules/source_md/Ajax
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
:: ���ù�������
set hookname=%~3
:: �����򱸷�
if exist "%~2\hooks\%hookname%"  (
 	ren %~2\hooks\%hookname%   %hookname%.%~4  
)
:: ���ƹ���
xcopy  %~1\%hookname%   %~2\hooks\  /Y
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 

GOTO:EOF
:: ==========[Function]================================================================== ::
