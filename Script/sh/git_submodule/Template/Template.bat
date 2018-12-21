:: =================================================================== ::
::  ����������ģ��������������ļ�
::  
:: 
:: =================================================================== ::
:: �رջ���
@echo off
:: ���������ӳ�
setlocal enabledelayedexpansion
:: ������ɫ
color 0A
:: ���Կ���
set debug=0

:::::::::::::::::::::::::::��������:::::::::::::::::::::::::::::::

:: �ļ���(��������׺)
set _filename=Template
:: ��ģ����
set _name=public
:: git��ַ
set _git=https://xxx.com/xx/%_name%.git
:: ��ģ���֧ 
set _branch=master
:: ����ǰ���õĽű�·��
set _sh=
:: �������õĽű�·��
set _sh2=
:: �Ƿ������ļ���ʱ���
set is_TimestampFileName=1
:::::::::::::::::::::::::::��������:::::::::::::::::::::::::::::::




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
echo ����ʱ�䣺"%datetime%"

:: ����ʱ�� ��( 20181207180016 )
set deti=%de%%ti%
:::: ȥ�����пո�
set timestamp=%deti: =%
echo ʱ�����"%timestamp%"
if %debug%==1 echo ------------------------ ��������ʱ���ʱ���  ----------------------

:: EQU - ����
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
:: �������ƣ�outfile							  	  ::
:: �������ܣ�����ļ�								  ::
:: ����������arg1: ����ļ��� 					  	  ::
:: 			 arg2: git��ַ 						  	  ::
::                 �磬https://github.com/ter/Ajax.git::
::           arg3: ��ģ���� 						  ::
::                 ��ģ�����·��					  ::
::         [arg4]: ��ģ���֧ 						  ::
::         [arg5]: ����ǰ�ű�·��(���·��)			  ::
::         [arg6]: �����ű�·��(���·��)			  ::
:: ����ֵ�� 									 	  ::
:: 													  ::
:: ================================================== ::
:outfile

set dn=%~1
set git=%~2
set name=%~3

:: EQU - ����
if "%~4" EQU "" (
	set branch=master
) else (
	set branch=%~4
) 

:: EQU - ����
if "%~5" EQU "" (
	set sh=
) else (
	set sh=%~5
)
:: EQU - ����
if "%~6" EQU "" (
	set sh=
) else (
	set sh=%~6
) 
 
echo ------------------------ �������  ------------------------
echo ###################################################### >%dn%
echo #  ��ģ�������������ļ� >>%dn%
echo #  >>%dn%
echo # ����ʱ�䣺%datetime%  >>%dn%
echo #------------------------------------------------ >>%dn%
echo #  ��׺   		���� >>%dn%
echo # .add        �����ģ�� >>%dn%	
echo # .init	      ��ʼ����ģ�� >>%dn%
echo # .update	  ������ģ�� >>%dn%
echo # .del		  ɾ����ģ�� >>%dn%
echo #------------------------------------------------ >>%dn%
echo #  git     :  git ��ַ >>%dn%
echo #  name    :  ��ģ������ >>%dn%
echo #  branch  :  ��ģ���֧ >>%dn%
echo #  sh  	   :  ����ǰ���õĽű�  >>%dn%
echo #  sh2     :  �������õĽű�  >>%dn%
echo ###################################################### >>%dn%
echo git=%git%>>%dn%
echo name=%name%>>%dn%
echo branch=%branch%>>%dn%
echo sh=%sh%>>%dn%
echo sh2=%sh2%>>%dn%

echo. 
echo ������ģ��������ļ������ɣ��뾡��ת���ļ�
echo [ %dn% ]
echo.
echo ------------------------ �������  ------------------------
GOTO:EOF

