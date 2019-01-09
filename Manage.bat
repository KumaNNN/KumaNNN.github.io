:: =================================================================== ::
::  
:: 
:: REM Ϊ��Ԥ��Ч���������в����ľ��ļ������Բֿ�ÿ�ζ���1���ύ
:: ���Ŀ¼��  
:: ����Ŀ¼�� 
:: 
:: =================================================================== ::
:: Parser  ������

:::::::::::::::: Ԥ�ñ��� ::::::::::::::::
:: �رջ���
@echo off
:: ������ɫ
color 0A
:: ���Կ���
set debug=0
:: ���������ӳ�
setlocal EnableDelayedExpansion
:: ��ת���ű�Ŀ¼ 
cd %~dp0

:: ��ǰ�ļ���(xxx.bat)
set This=%~nx0
:: ��ǰ�ļ���ȫ·��(E:\...\xxx.bat)
set ThisFull=%~dpnx0
:: ��ǰ�ļ�Ŀ¼(E:\...\Script\sh)
set ThisDir=%cd%

:: EQU - ����  NEQ - ������
if  "%debug%" == "1"  echo This: %This%
if  "%debug%" == "1"  echo ThisFull: %ThisFull%
if  "%debug%" == "1"  echo ThisDir: %ThisDir%

:::::::::::::::: Ԥ�ñ��� ::::::::::::::::

:::::::::::::::: ȫ�ֱ��� ::::::::::::::::

:: posts����
set postsNum=0
:: pages����
set pagesNum=0
:: drafts����
set draftsNum=0

:: post����
set postNum=0
:: page����
set pageNum=0
:: draft����
set draftNum=0

call :is_DestDir  %ThisDir%###%ThisDir%  node_modules:source  0  res  rescd
:: if "%res%" == "1" echo in hexo
:: if "%res%" == "0" echo not in hexo

:: ��־Ŀ¼
set _logdir=%ThisDir%\%This%.log
if not exist %_logdir%\  mkdir  %_logdir%

:: �Ƿ���ļ�(1,�� 0,��)
set is_open=0

:::::::::::::::: ȫ�ֱ��� ::::::::::::::::

:: ��ת����
if "%res%" == "1" goto hexo
if "%res%" == "0" goto Other


:: ***********************************Other ����******************************************** ::

:: ==========[���¹���]========================================================================== ::
GOTO:EOF
:Other
:OtherArticleManage
:: cls�� �����Ļ��������
cls

echo.
echo -----------------------------------------------------      
echo   ************ ���¹��� ************
echo.
echo.
echo     1.�½�����  
echo     2.�����½�����
if exist %_logdir%\ (
	echo     4.ɾ����־Ŀ¼
)
echo.  
echo     3.�˳�
echo. 
echo -----------------------------------------------------    
set cho=
set /p cho=��ѡ��
  
if "%cho%" == "1" goto OtherArticleManage_New
if "%cho%" == "2" goto OtherArticleManage_BatchNew
if "%cho%" == "3" goto Texit
if exist %_logdir%\ (
	if "%cho%" == "4" goto OtherDelLogDir
)

:: ��������ʱ����ת�ص�ǰ�˵�
echo ��������...
pause
goto OtherArticleManage
GOTO:EOF

GOTO:EOF
:: ɾ����־Ŀ¼
:OtherDelLogDir

if %debug%==1 echo call :DelLogDir
call :DelLogDir

pause
goto OtherArticleManage
GOTO:EOF



GOTO:EOF
:OtherArticleManage_New
:: cls�� �����Ļ��������
cls

echo.
echo -----------------------------------------------------      
echo   ************ ���¹��� ************
echo.
echo  �½����£�
echo.
echo  ���﷨��
echo title:Title#tags:tag1,tag2,tag3,tag4,tag5#top:1#template:TemplateName#filename:FileName#type:post 
echo.
echo  �����͡�
echo title:���� 
echo 	[����] ���±���,�������ļ�����������׺�� 
echo tags:��ǩ1,��ǩ2,��ǩ3,��ǩ4,��ǩ5 
echo 	[��ѡ] ���5����ǩ 
echo top:1  
echo 	[��ѡ] �ö�ֵ����Χ(0~)��Ĭ��1 
echo template:ģ������ 
echo 	[��ѡ] ���ض�Ŀ¼������  
echo filename:�ļ��� 
echo 	[��ѡ] ָ���ļ�����������׺  
echo type:post 
echo 	[��ѡ] ָ����������(post ^| page ^| draft)  
echo.
echo.
echo     2.�ϼ��˵�   
echo     3.�˳�
echo. 
echo -----------------------------------------------------    
set cho=
set /p cho=�����룺
  
if "%cho%" == "2" goto OtherArticleManage
if "%cho%" == "3" goto Texit

:: EQU - ����  NEQ - ������
if "%cho%" NEQ ""  (
	if %debug%==1 echo call :out_md  1 "%cho%" 
	set is_open=1
	call :out_md  1 "%cho%" 
	pause
	goto OtherArticleManage_New
)

:: ��������ʱ����ת�ص�ǰ�˵�
echo ��������...
pause
goto OtherArticleManage_New
GOTO:EOF



GOTO:EOF
:OtherArticleManage_BatchNew
:: cls�� �����Ļ��������
cls

echo.
echo -----------------------------------------------------      
echo   ************ ���¹��� ************
echo.
echo  �����½����£�
echo.
if not exist write_list.conf (
echo     1.���������ļ����
) else (
echo     1.ִ�������½�����
)
echo.
echo     2.�ϼ��˵�   
echo     3.�˳�
echo. 
echo -----------------------------------------------------    
set cho=
set /p cho=��ѡ��

if not exist write_list.conf (	
	if "%cho%" == "1" goto OtherArticleManage_BatchNew_outConf
) else (	
	if "%cho%" == "1" goto OtherArticleManage_BatchNew_out	
)
if "%cho%" == "2" goto OtherArticleManage
if "%cho%" == "3" goto Texit

:: ��������ʱ����ת�ص�ǰ�˵�
echo ��������...
pause
goto OtherArticleManage_BatchNew
GOTO:EOF


GOTO:EOF
:OtherArticleManage_BatchNew_outConf

if %debug%==1 echo call :out_write_list 
call :out_write_list

pause
goto OtherArticleManage_BatchNew
GOTO:EOF


GOTO:EOF
:OtherArticleManage_BatchNew_out

set is_open=0
if %debug%==1 echo call :out_md   2  write_list.conf
call :out_md   2  write_list.conf

pause
goto OtherArticleManage
GOTO:EOF
:: ==========[���¹���]========================================================================== ::

:: ***********************************Other ����******************************************** ::




:: ***********************************Windows hexo ����******************************************** ::

GOTO:EOF
:hexo
:: cls�� �����Ļ��������
cls

echo.
echo -----------------------------------------------------      
echo   ************ Windows hexo ���� ************
echo.
echo ��ѡ��������ͣ�
echo.
echo     1.���¹���
echo     2.�������
echo     3.���ù���
if exist %_logdir%\ (
	echo     5.ɾ����־Ŀ¼
)
echo.      
echo     4.�˳�
echo. 
echo -----------------------------------------------------    
set cho=
set /p cho=��ѡ��

if "%cho%" == "1" goto HexoArticleManage
if "%cho%" == "2" goto HexoServiceManage
if "%cho%" == "3" goto HexoConfManage
if exist %_logdir%\ (
	if "%cho%" == "5" goto HexoDelLogDir
)
if "%cho%" == "4" goto Texit

:: ��������ʱ����ת�ص�ǰ�˵�
echo ��������...
pause
goto hexo
GOTO:EOF

GOTO:EOF
:: ɾ����־Ŀ¼
:HexoDelLogDir

if %debug%==1 echo call :DelLogDir
call :DelLogDir

pause
goto hexo
GOTO:EOF




:: ==========[���ù���]========================================================================= ::
GOTO:EOF
:HexoConfManage
:: cls�� �����Ļ��������
cls

echo.
echo -----------------------------------------------------      
echo   ************ Windows hexo ���� ************
echo.
echo Hexo ^>^> ���ù���
echo.
echo     1.�򿪸�Ŀ¼
echo     2.�������Ŀ¼
if not exist %This%.conf (
	echo     3.����ű������ļ�
) else (
	echo     3.��վ������
)
echo.
echo     4.�ϼ��˵�      
echo     5.�˳�
echo. 
echo -----------------------------------------------------
set cho=
set /p cho=��ѡ��

if "%cho%" == "1" goto HexoConfManage_OpenRoot
if "%cho%" == "2" goto HexoConfManage_OpenThemesRoot
if not exist %This%.conf (
	if "%cho%" == "3" goto HexoConfManage_outBatConf
) else (
	if "%cho%" == "3" goto HexoConfManage_OpenSiteConf
)
if "%cho%" == "4" goto hexo
if "%cho%" == "5" goto Texit


:: ��������ʱ����ת�ص�ǰ�˵�
echo ��������...
pause
goto HexoConfManage
GOTO:EOF


GOTO:EOF
:: �򿪸�Ŀ¼
:HexoConfManage_OpenRoot

if %debug%==1 echo start %cd%
start %cd%

pause
goto HexoConfManage
GOTO:EOF


GOTO:EOF
:: �������Ŀ¼
:HexoConfManage_OpenThemesRoot

if %debug%==1 echo  start %cd%\themes\
start %cd%\themes\

pause
goto HexoConfManage
GOTO:EOF


GOTO:EOF
:: ����ű������ļ�
:HexoConfManage_outBatConf

if %debug%==1 echo call :outBatConf 
call :outBatConf 

pause
goto HexoConfManage
GOTO:EOF


GOTO:EOF
:: ��վ������
:HexoConfManage_OpenSiteConf

if %debug%==1 echo call :Parser_SetVar   %This%.conf  
if %debug%==1 echo start %exe%  _config.yml
call :Parser_SetVar   %This%.conf  
start %exe%  _config.yml

pause
goto HexoConfManage
GOTO:EOF

:: ==========[���ù���]========================================================================= ::




:: ==========[�������]========================================================================= ::
GOTO:EOF
:HexoServiceManage
:: cls�� �����Ļ��������
cls

echo.
echo -----------------------------------------------------      
echo   ************ Windows hexo ���� ************
echo.
echo Hexo ^>^> �������
echo.
echo     1.���^(hexo clean^)
echo     2.����^(hexo g^)
echo     3.����^(hexo d^)
echo     4.���ñ��ط�����^(hexo s^)
if not exist public.bak (
echo     5.Public����
) else (
echo     5.Public�ָ�
)
echo     6.Public����^(֧�ֶ��߲���^)
echo.
echo     7.�ϼ��˵�      
echo     8.�˳�
echo. 
echo -----------------------------------------------------
set cho=
set /p cho=��ѡ��
  
if "%cho%" == "1" (
	if %debug%==1 echo call :Parser_cmd  "hexo clean"  1  0
	call :Parser_cmd  "hexo clean"  1  0
	pause
	goto HexoServiceManage
)
if "%cho%" == "2" (
	if %debug%==1 echo call :Parser_cmd  "hexo g"  1  0
	call :Parser_cmd  "hexo g"  1  0
	pause
	goto HexoServiceManage
) 
if "%cho%" == "3" (
	if %debug%==1 echo call :Parser_cmd  "hexo d"  0  1
	call :Parser_cmd  "hexo d"  0  0
	pause
	goto HexoServiceManage
) 
if "%cho%" == "4" (
	if %debug%==1 echo call :Parser_cmd  "hexo s"  0  1
	call :Parser_cmd  "hexo s"  0  1
	pause
	goto HexoServiceManage
)

if not exist public.bak (
	if "%cho%" == "5" goto HexoServiceManage_public_backup
) else (
	if "%cho%" == "5" goto HexoServiceManage_public_recovery
)

if "%cho%" == "6" goto HexoServiceManage_public_d
if "%cho%" == "7" goto hexo
if "%cho%" == "8" goto Texit

:: ��������ʱ����ת�ص�ǰ�˵�
echo ��������...
pause
goto HexoServiceManage
GOTO:EOF

GOTO:EOF
:HexoServiceManage_public_d
:: cls�� �����Ļ��������
cls

echo.
echo -----------------------------------------------------      
echo   ************ Windows hexo ���� ************
echo.
echo Hexo ^>^> ������� ^>^> Public����
echo.
if not exist public_git.conf (
	echo     1.�������
) else (
	echo     1.����git�ֿ�
	echo     2.ִ��Public����	
)
echo.
echo     3.�ϼ��˵�      
echo     4.���˵�      
echo     5.�˳�
echo. 
echo -----------------------------------------------------
set cho=
set /p cho=��ѡ��

if not exist public_git.conf (
	if "%cho%" == "1" goto HexoServiceManage_public_outconf
) else (	
	if "%cho%" == "1" goto HexoServiceManage_public_conf
	if "%cho%" == "2" goto HexoServiceManage_public_dd
)
if "%cho%" == "3" goto HexoServiceManage
if "%cho%" == "4" goto hexo
if "%cho%" == "5" goto Texit

:: ��������ʱ����ת�ص�ǰ�˵�
echo ��������...
pause
goto HexoServiceManage
GOTO:EOF



GOTO:EOF
:: �������
:HexoServiceManage_public_outconf

if %debug%==1 echo call :out_public_git
call :out_public_git

pause
goto HexoServiceManage_public_d
GOTO:EOF


GOTO:EOF
:: ����git�ֿ�
:HexoServiceManage_public_conf

if not exist "%cd%\public_deploy"  mkdir  "%cd%\public_deploy"
REM ���ĺ�������
if %debug%==1 echo call :GitSets public_git.conf  "%cd%\public_deploy"
call :GitSets public_git.conf  "%cd%\public_deploy"

pause
goto HexoServiceManage_public_d
GOTO:EOF


GOTO:EOF
:: ִ��Public����
:HexoServiceManage_public_dd

echo.
echo ���棡
echo Զ�˴��ڱ��ز����ڵ��ļ��������Զ����
echo ���û�м��������ɾ��Զ�˵���Щ�ļ�
echo.
echo ���й̶����ļ���������� [public_git] Ŀ¼��
echo ��Ŀ¼�����ݽ����Զ����Ƶ� [public_deploy] Ŀ¼�£������ļ���
echo.
echo �Ƿ������
set /p c_dd=(Y,�� N,��):

if /i "%c_dd%" == "Y" (
	set c_dd=	
	if not exist "%cd%\public_deploy"  mkdir  "%cd%\public_deploy"
	
	REM �ж��Ƿ���git�ֿ�
	if not exist "%cd%\public_deploy\.git\" (
		echo Ŀ�겻��git�ֿ�,��������git�ֿ�...
		pause
		goto HexoServiceManage_public_d
	)
	
	REM ����ų����Ƶ������ļ�
	echo .git>%_logdir%\uncopy_public.txt
	echo \.git\>>%_logdir%\uncopy_public.txt
	echo ReadMe.re>%_logdir%\uncopy_public_git.txt
	
	REM ���� public Ŀ¼
	if exist public\ (		
		xcopy  public\*  public_deploy /EIY /EXCLUDE:%_logdir%\uncopy_public.txt
	) else  (
		echo public Ŀ�겻���ڣ���������...
		goto HexoServiceManage_public_dd_END
	)
	
	REM ���� public_git Ŀ¼
	if exist public_git\ (
		REM ����[public_git] �� [public] Ŀ¼��
		xcopy  public_git\*  public_deploy /EIY  /EXCLUDE:%_logdir%\uncopy_public_git.txt
	) else (
		REM ����Ŀ¼
		mkdir public_git
		REM ���˵���ĵ�
		echo ��Ŀ¼�µ�Ϊ�̶��ļ�����һ����Զ��>public_git\ReadMe.re
		echo ��Ŀ¼�����ݽ����Զ����Ƶ� [public_deploy] Ŀ¼�£������ļ���>>public_git\ReadMe.re
		echo ���ļ�[ReadMe.re]������>>public_git\ReadMe
	)
	
	REM ���ĺ�������
	if %debug%==1 echo call :GitDeploys   public_git.conf   "%cd%\public_deploy"
	call :GitDeploys  public_git.conf   "%cd%\public_deploy"
	
	REM ɾ������Ŀ¼
	REM Ϊ��Ԥ��Ч���������в����ľ��ļ������Բֿ�ÿ�ζ���1���ύ
	if exist "%cd%\public_deploy\.git\" (
		rd /S /Q "%cd%\public_deploy\"
	)
) else (
	set c_dd=
	echo δִ���κβ���...
)	
:HexoServiceManage_public_dd_END
pause
goto HexoServiceManage
GOTO:EOF


GOTO:EOF
:: Public����
:HexoServiceManage_public_backup
if exist public.bak\ (	
	echo [public.bak] �Ѵ���
	echo ��ɾ���ִ��[public.bak]Ŀ¼���Ƿ������
	set /p isok=^(Y,�� N,��^)��
	
	if /i "%isok%" == "Y" (
		set  isok=
		(		
		rd /s/q  public.bak
		) && (
		echo ɾ��[public.bak]Ŀ¼�ɹ�...
			(	
			ren public  public.bak	
			) && (
			echo ������[public]Ϊ[public.bak]�ɹ�...
			) || (
			echo ������[public]Ϊ[public.bak]ʧ��...
			)
		) || (
		echo ɾ��[public.bak]Ŀ¼ʧ��...
		)
	) else (
		set  isok=
		echo δִ���κβ���...
		goto HexoServiceManage_public_backup_END
	)		
) else (
	(	
	ren public  public.bak	
	) && (
	echo ������[public]Ϊ[public.bak]�ɹ�...
	) || (
	echo ������[public]Ϊ[public.bak]ʧ��...
	)
)

:HexoServiceManage_public_backup_END
pause
goto HexoServiceManage
GOTO:EOF


GOTO:EOF
:: Public�ָ�
:HexoServiceManage_public_recovery
if exist public\ (
	echo [public] �Ѵ���
	echo ��ɾ���ִ��[public]Ŀ¼���Ƿ������
	set /p isok=^(Y,�� N,��^)��
	
	if /i "%isok%" == "Y" (
		set  isok=
		(		
		rd /s/q  public
		) && (
		echo ɾ��[public]Ŀ¼�ɹ�...
			(		
			ren   public.bak  public
			) && (
			echo ������[public.bak]Ϊ[public]�ɹ�...
			) || (
			echo ������[public.bak]Ϊ[public]ʧ��...
			)
		) || (
		echo ɾ��[public]Ŀ¼ʧ��...
		)	
	) else (
		set  isok=
		echo δִ���κβ���...			
		goto HexoServiceManage_public_recovery_END
	)
) else (
	(		
	ren   public.bak  public
	) && (
	echo ������[public.bak]Ϊ[public]�ɹ�...
	) || (
	echo ������[public.bak]Ϊ[public]ʧ��...
	)
)

:HexoServiceManage_public_recovery_END
pause
goto HexoServiceManage
GOTO:EOF
:: ==========[�������]========================================================================= ::





:: ==========[���¹���]========================================================================== ::
GOTO:EOF
:HexoArticleManage
:: cls�� �����Ļ��������
cls

echo.
echo -----------------------------------------------------      
echo   ************ Windows hexo ���� ************
echo.
echo Hexo ^>^> ���¹���
echo.
echo     1.�½�����  
echo     2.�����½�����
echo.
echo     3.�ϼ��˵�      
echo     4.�˳�
echo. 
echo -----------------------------------------------------    
set cho=
set /p cho=��ѡ��
  
if "%cho%" == "1" goto HexoArticleManage_New
if "%cho%" == "2" goto HexoArticleManage_BatchNew
if "%cho%" == "3" goto hexo
if "%cho%" == "4" goto Texit

:: ��������ʱ����ת�ص�ǰ�˵�
echo ��������...
pause
goto HexoArticleManage
GOTO:EOF



GOTO:EOF
:HexoArticleManage_New
:: cls�� �����Ļ��������
cls

echo.
echo -----------------------------------------------------      
echo   ************ Windows hexo ���� ************
echo.
echo Hexo ^>^> ���¹��� ^>^> �½����£�
echo.
echo  ���﷨��
echo title:Title#tags:tag1,tag2,tag3,tag4,tag5#top:1#template:TemplateName#filename:FileName#type:post 
echo.
echo  �����͡�
echo title:���� 
echo 	[����] ���±���,�������ļ�����������׺�� 
echo tags:��ǩ1,��ǩ2,��ǩ3,��ǩ4,��ǩ5 
echo 	[��ѡ] ���5����ǩ 
echo top:1  
echo 	[��ѡ] �ö�ֵ����Χ(0~)��Ĭ��1 
echo template:ģ������ 
echo 	[��ѡ] ���ض�Ŀ¼������  
echo filename:�ļ��� 
echo 	[��ѡ] ָ���ļ�����������׺  
echo type:post 
echo 	[��ѡ] ָ����������(post ^| page ^| draft)  
echo.
echo.
echo     3.�ϼ��˵�      
echo     4.���˵�      
echo     5.�˳�
echo. 
echo -----------------------------------------------------    
set cho=
set /p cho=�����룺
  
if "%cho%" == "3" goto HexoArticleManage
if "%cho%" == "4" goto hexo
if "%cho%" == "5" goto Texit

:: EQU - ����  NEQ - ������
if "%cho%" NEQ ""  (
	if %debug%==1 echo call :out_md  1 "%cho%" 
	set is_open=1
	call :out_md  1 "%cho%" 
	pause
	goto HexoArticleManage_New
)

:: ��������ʱ����ת�ص�ǰ�˵�
echo ��������...
pause
goto HexoArticleManage_New
GOTO:EOF



GOTO:EOF
:HexoArticleManage_BatchNew
:: cls�� �����Ļ��������
cls

echo.
echo -----------------------------------------------------      
echo   ************ Windows hexo ���� ************
echo.
echo Hexo ^>^> ���¹��� ^>^> �����½����£�
echo.
if not exist write_list.conf (
echo     1.���������ļ����
) else (
echo     1.ִ�������½�����
)
echo.
echo     2.�ϼ��˵�  
echo     3.���˵�    
echo     4.�˳�
echo. 
echo -----------------------------------------------------    
set cho=
set /p cho=��ѡ��

if not exist write_list.conf (	
	if "%cho%" == "1" goto HexoArticleManage_BatchNew_outConf
) else (	
	if "%cho%" == "1" goto HexoArticleManage_BatchNew_out	
)
if "%cho%" == "2" goto HexoArticleManage
if "%cho%" == "3" goto hexo
if "%cho%" == "4" goto Texit

:: ��������ʱ����ת�ص�ǰ�˵�
echo ��������...
pause
goto HexoArticleManage_BatchNew
GOTO:EOF


GOTO:EOF
:HexoArticleManage_BatchNew_outConf

if %debug%==1 echo call :out_write_list 
call :out_write_list 

pause
goto HexoArticleManage_BatchNew
GOTO:EOF


GOTO:EOF
:HexoArticleManage_BatchNew_out

set is_open=0
if %debug%==1 echo call :out_md   2  write_list.conf
call :out_md   2  write_list.conf

pause
goto HexoArticleManage
GOTO:EOF
:: ==========[���¹���]========================================================================== ::


:: ***********************************Windows hexo ����******************************************** ::


GOTO:EOF
:: �Զ����˳���
:Texit
if exist %_logdir%\ (
	echo ��⵽��־Ŀ¼���Ƿ�ɾ����
	set /P delok=^(Y,�� N,��^):
	
	if /i "!delok!" == "N" (
		set fg=
		GOTO Texit_END
	) else (
		if /i "!delok!" == "Y" (
			set fg=
			call :DelLogDir
			GOTO Texit_END			
		)
	)
)

:Texit_END
exit
GOTO:EOF

GOTO:EOF
:: ɾ����־Ŀ¼
:DelLogDir
if exist %_logdir%\ (
	(
	rd/s/q %_logdir%\
	) && (
	echo ��־Ŀ¼ɾ���ɹ�...
	) || (
	echo ��־Ŀ¼ɾ��ʧ��...
	)
)
GOTO:EOF




:: ==========[Function]================================================================== ::

::::::::����ʾ��:::::::::::
REM set str1=title:Title1#tags:tag1,tag2,tag3,tag4,tag5#top:1#template:TemplateName#filename:FileName
REM set str2=title:Title2#tags:tag1,tag2,tag3,tag4,tag5#top:1#template:TemplateName#type:page

REM ::call :out_md   2  write_list.conf
REM call :out_md  1 "%str1%" 
REM call :out_md  1 "%str2%" 

GOTO:EOF
:: ================================================== ::
:: �������ƣ�out_md									  ::
:: �������ܣ����md�ļ�								  ::
:: ����������arg1: ģʽ			 		  	  		  ::
:: 			 	   1���½�����		  				  ::
:: 			 	   2�������½�����	  				  ::
:: 			 arg2: �������� 		  	  			  ::
::  		 	   �ַ������ļ���					  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    												  ::
:: ================================================== ::
:out_md

:: ģʽ
set mode=%~1

:: ��������
set _in=%~2

:: ���� �½�����
if "%mode%" == "1" (
	REM ���ñ���
	REM %cd% : E:\...\Hexo
	set OutDir=%cd%
	if "%res%" == "1" (
		if %debug%==1 echo in hexo
		set postDirName=source\_posts\
		set pageDirName=source\
		set draftDirName=source\_drafts\		
	)
	if "%res%" == "0" (
		if %debug%==1 echo not in hexo
		set postDirName=posts\
		set pageDirName=pages\
		set draftDirName=drafts\
	)
	REM ������������
	call :Parser_line  "%_in%"  out_md_cb01
)

:: ���� �����½�����
if "%mode%" == "2" (	
	REM ��ȡ�����ñ���
	call :Parser_conf  "%_in%"  
	REM �����ļ�����
	call :Parser_file  "%_in%"  out_md_cb01
)
echo.
echo �����Ŀ¼: !OutDir!
echo.
echo ��ʷ��¼
echo ����^(post^)  : !postsNum!
echo ҳ��^(page^)  : !pagesNum!
echo �ݸ�^(draft^) : !draftsNum!
echo.
echo ��������
echo ����^(post^)  : !postNum!
echo 	���� !OutDir!\!postDirName!
echo ҳ��^(page^)  : !pageNum!
echo 	���� !OutDir!\!pageDirName!
echo �ݸ�^(draft^) : !draftNum!
echo 	���� !OutDir!\!draftDirName!

:: �ÿձ���
set postNum=0
set pageNum=0
set draftNum=0
GOTO:EOF

GOTO:EOF
:out_md_cb01
if %debug%==1 echo  %~0 --------------------------------------
if %debug%==1 echo --[title: %_title%  ]--
if %debug%==1 echo --[tag1: %tag1%  ]--
if %debug%==1 echo --[tag2: %tag2%  ]--
if %debug%==1 echo --[tag3: %tag3%  ]--
if %debug%==1 echo --[tag4: %tag4%  ]--
if %debug%==1 echo --[tag5: %tag5%  ]--
if %debug%==1 echo --[top: %top%  ]--
if %debug%==1 echo --[template: %template%  ]--
if %debug%==1 echo --[filename: %filename%  ]--
if %debug%==1 echo --[type: %type%  ]--

:: �������Ŀ¼
if "%type%" == "post"  set out_dir=!OutDir!\!postDirName!
if "%type%" == "page"  set out_dir=!OutDir!\!pageDirName!
if "%type%" == "draft"  set out_dir=!OutDir!\!draftDirName!
if %debug%==1 echo  out_dir : %out_dir%

:: is_open ȫ�ֱ��� Ĭ��0
:: ���ú����������
call :out_YAML "%out_dir%"  !is_open!  %type%

:: �ÿձ��������Ӱ��
set _title=
set tag1=
set tag2=
set tag3=
set tag4=
set tag5=
set top=
set template=
set filename=
set type=
if %debug%==1 echo %~0 --------------------------------------
GOTO:EOF




::::::::����ʾ��:::::::::::
::GOTO:EOF
:::cb01
::echo --------------------------------------
::echo --[title: %_title%  ]--
::echo --[tag1: %tag1%  ]--
::echo --[top: %top%  ]--
::echo --[filename: %filename%  ]--

::call :out_YAML "" 1

:: �ÿձ��������Ӱ��
::set _title=
::set tag1=
::set top=
::set filename=
::echo --------------------------------------
::GOTO:EOF


GOTO:EOF
:: ================================================== ::
:: �������ƣ�out_YAML								  ::
:: �������ܣ����YAML��md�ļ���						  ::
:: ����������arg1: �ļ����·��			 		  	  ::
::  		 	   K:\c\		 	 		  		  ::
:: 		   [arg2]: �Ƿ���ļ�		  	  			  ::
::           	   1���򿪣�0������(Ĭ��)	 		  ::
:: 		   [arg3]: ��������	  	  			  		  ::
::           	   post  : ����	 			  		  ::
::           	   draft : �ݸ�	 			  		  ::
::           	   page  : ҳ��	 			  		  ::
:: ����ֵ��          							      ::
::    %filename% �� �ļ���					  		  ::
::        		   	Ĭ�ϣ� %_title% �� title	 	  ::
::      %_title% �� ����				 			  ::
::        		  	Ĭ�ϣ� title		  			  ::
::         %top% �� �ö�					 		  ::
::        		  	Ĭ�ϣ�1(filename=index,0)	 	  ::
::    %destfile% �� Ŀ���ļ�				 		  ::
::        		    c:\doc\FileName.md				  ::
::     %destdir% �� ���Ŀ¼						  ::
::        		    c:\doc\			  				  ::
:: %destfiledir% �� �ļ�ͬ��Ŀ¼					  ::
::        		    c:\doc\FileName					  ::
::   %_datetime% �� ����ʱ��						  ::
::        		    2018-12-10 21:43:58				  ::
::    %type% ��     ��������						  ::
::        		    								  ::
:: ================================================== ::
:out_YAML
:: �ջ� setlocal ... endlocal
setlocal

:: �Ƿ���ļ�
if "%~2" == ""  (
	set opfile=0
) else (
	set opfile=%~2
)

:: ���⴦��
if "%_title%" == ""  (
	echo title ����Ϊ��...
	pause	
	goto out_YAML_END
)

:: ��������(Ĭ�ϣ�%type%=post)
:: EQU - ����  NEQ - ������
set _type=%~3
if "%_type%" == ""  (
	set _type=%type%
)

:: �ļ�������
if "%filename%" == "" (
	set _filename=%_title%
) else (
	set _filename=%filename%
)

:: �ö�����
if "%top%" == "" set top=1
if "%_filename%" == "index" set top=0

:: ���Ŀ¼
if "%~1" == "" (
	set _destdir=%cd%\
) else (
	set _destdir=%~1
)

:: Ŀ���ļ�
set _destfile=%_destdir%%_filename%.md

:: �ļ�ͬ��Ŀ¼
set _destfiledir=%_destdir%%_filename%

if %debug%==1 echo  _type: %_type%
if %debug%==1 echo  _filename: %_filename%
if %debug%==1 echo  _title: %_title%
if %debug%==1 echo  top: %top%
if %debug%==1 echo  _destfile: %_destfile%
if %debug%==1 echo  _destfiledir: %_destfiledir%
if %debug%==1 echo  _destdir: %_destdir%


if "%_type%" == "page" (
	REM Ŀ���ļ�
	set _destfile=%_destdir%%_filename%\index.md
	REM �ļ�ͬ��Ŀ¼
	set _destfiledir=%_destdir%%_filename%\index
)


:: �����ļ�ͬ��Ŀ¼
if exist "%_destfiledir%" (
	echo �ļ�ͬ��Ŀ¼�Ѵ���...
	echo [ %_destfiledir% ]
) else (
	(
		mkdir %_destfiledir% 
	) && (
		echo �ļ�ͬ��Ŀ¼�����ɹ�... 
		echo [ %_destfiledir% ]
	) || (
		echo �ļ�ͬ��Ŀ¼����ʧ��...
		echo [ %_destfiledir% ]
	)
)

:: ����ʱ�亯��
call :_time  

:: Ŀ���ļ����ڣ����˳�
if exist "%_destfile%" (
	echo Ŀ���ļ��Ѵ���...
	echo [ %_destfile% ]	
	goto out_YAML_END
)

:: EQU - ����  NEQ - ������
:: ���YAML
if "%_type%" == "post" (
	echo --->%_destfile%
	echo title: ^%_title%>>%_destfile%
	echo date: %datetime%>>%_destfile%
	echo updated: %datetime%>>%_destfile%
	echo mathjax: false>>%_destfile%
	echo categories:>>%_destfile% 
	echo tags:>>%_destfile%
	if "%tag1%" NEQ "" echo   - ^%tag1%>>%_destfile%
	if "%tag2%" NEQ "" echo   - ^%tag2%>>%_destfile%
	if "%tag3%" NEQ "" echo   - ^%tag3%>>%_destfile%
	if "%tag4%" NEQ "" echo   - ^%tag4%>>%_destfile%
	if "%tag5%" NEQ "" echo   - ^%tag5%>>%_destfile%
	echo typora-root-url: ^%_filename%>>%_destfile%
	echo typora-copy-images-to: ^%_filename%>>%_destfile%
	echo comments: false>>%_destfile%
	echo top: ^%top%>>%_destfile%
	echo --->>%_destfile%
	echo.>>%_destfile%
	echo.>>%_destfile%
)
if "%_type%" == "page" (	
	echo --->%_destfile%
	echo title: ^%_title%>>%_destfile%
	echo date: %datetime%>>%_destfile%
	echo updated: %datetime%>>%_destfile%
	echo typora-root-url: index>>%_destfile%
	echo typora-copy-images-to: index>>%_destfile%
	echo comments: false>>%_destfile%
	echo --->>%_destfile%
	echo.>>%_destfile%
	echo.>>%_destfile%
)
if "%_type%" == "draft" (
	echo --->%_destfile%
	echo title: ^%_title%>>%_destfile%
	echo date: %datetime%>>%_destfile%
	echo updated: %datetime%>>%_destfile%
	echo tags:>>%_destfile%
	if "%tag1%" NEQ "" echo   - ^%tag1%>>%_destfile%
	if "%tag2%" NEQ "" echo   - ^%tag2%>>%_destfile%
	if "%tag3%" NEQ "" echo   - ^%tag3%>>%_destfile%
	if "%tag4%" NEQ "" echo   - ^%tag4%>>%_destfile%
	if "%tag5%" NEQ "" echo   - ^%tag5%>>%_destfile%
	echo typora-root-url: ^%_filename%>>%_destfile%
	echo typora-copy-images-to: ^%_filename%>>%_destfile%
	echo comments: false>>%_destfile%
	echo top: ^%top%>>%_destfile%
	echo --->>%_destfile%
	echo.>>%_destfile%
	echo.>>%_destfile%
)

:: Ŀ���ļ������ɹ�
if exist "%_destfile%" (
	echo Ŀ���ļ������ɹ�...
	echo [ %_destfile% ]	
)

:out_YAML_END
:: EQU - ����  NEQ - ������
if "%_title%" NEQ "" (
	REM �ļ��򿪴���
	if "%opfile%" == "1"  start %_destfile%
)

(
endlocal
REM �������
set filename=%_filename%
set _title=%_title%
set top=%top%
set destfile=%_destfile%
set destdir=%_destdir%
set destfiledir=%_destfiledir%
set _datetime=%datetime%
set type=%_type%
)
GOTO:EOF





::::::::����ʾ��:::::::::::
REM call :out_write_list  


GOTO:EOF
:: ================================================== ::
:: �������ƣ�out_write_list							  ::
:: �������ܣ������½����������ļ����		 		  ::
:: ����������arg1:  			 		  	  		  ::
:: 			 arg2: 		 		  	  				  ::
::  		 	   									  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    												  ::
:: ================================================== ::
:out_write_list
:: �ջ� setlocal ... endlocal
setlocal

:: ����ļ���
set filename=write_list.conf
if exist %filename% (
	echo �ļ� [ %filename% ]�Ѵ��ڣ����ǣ�
	set /P fg=^(Y,�� N,��^):
	if /i "!fg!" == "N" (
		set fg=
		GOTO:EOF
	)
)


:: �������ģ��
echo # �����ű��� %This% >%filename%
echo # ��������Ϣ��>>%filename%
echo # #$��ͷΪ�������� >>%filename%
echo # [��ʽ] >>%filename%
echo # #$key:value >>%filename%
echo # >>%filename%
echo # OutDir : �����Ŀ¼>>%filename%
echo # ����·��������б�ܽ�β>>%filename%
echo # postDirName  : postĿ¼��>>%filename%
echo # pageDirName  : pageĿ¼��>>%filename%
echo # draftDirName : draftĿ¼��>>%filename%
echo #$OutDir:%cd%>>%filename%
if "%res%" == "1" (
	echo #$postDirName:source\_posts\>>%filename%
	echo #$pageDirName:source\>>%filename%
	echo #$draftDirName:source\_drafts\>>%filename%
) else (
	echo #$postDirName:posts\>>%filename%
	echo #$pageDirName:pages\>>%filename%
	echo #$draftDirName:drafts\>>%filename%
)
echo.>>%filename%
echo.>>%filename%
echo # �������½����¡�>>%filename%
echo # >>%filename%
echo # ÿ��һ�����ã����һ��md��׺���ļ� >>%filename%
echo # #�ſ�ͷΪע�� >>%filename%
echo # >>%filename% 
echo # [���õ����ݸ�ʽ] >>%filename%
echo # key:value#key:value#key:value#key:value#key:value >>%filename%
echo # >>%filename%
echo # ���10��key:value  �磬 >>%filename%
echo # title:Title#tags:tag1,tag2,tag3,tag4,tag5#top:1#template:TemplateName#filename:FileName#type:post >>%filename%
echo # >>%filename% 
echo # [���] >>%filename%
echo # title:���� >>%filename%
echo # 			[����] ���±���,�������ļ�����������׺����ȡʱ�ı����� _title >>%filename%
echo # tags:��ǩ1,��ǩ2,��ǩ3,��ǩ4,��ǩ5 >>%filename%
echo #	   		[��ѡ] ���5����ǩ >>%filename%
echo # top:1  >>%filename%
echo #	  		[��ѡ] �ö�ֵ����Χ(0~)��Ĭ��1 >>%filename%
echo # template:ģ������ >>%filename%
echo # 		    [��ѡ] ���ض�Ŀ¼������  >>%filename%
echo # filename:�ļ��� >>%filename%
echo # 			[��ѡ] ָ���ļ�����������׺  >>%filename%
echo # type:post >>%filename%
echo # 			[��ѡ] ָ����������(post ^| page ^| draft)  >>%filename%
echo # >>%filename%
echo.>>%filename%

echo �����½����µ������ļ�[%filename%]������
echo ���ڴ��ļ�������
(
endlocal
REM �������
)
GOTO:EOF




::::::::����ʾ��:::::::::::
::call :out_public_git  


GOTO:EOF
:: ================================================== ::
:: �������ƣ�out_public_git							  ::
:: �������ܣ�public_git	�����ļ����		 		  ::
:: ����������arg1:  			 		  	  		  ::
:: 			 arg2: 		 		  	  				  ::
::  		 	   									  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    												  ::
:: ================================================== ::
:out_public_git
:: �ջ� setlocal ... endlocal
setlocal

:: ����ļ���
set filename=public_git.conf
if exist %filename% (
	echo �ļ� [ %filename% ]�Ѵ��ڣ����ǣ�
	set /P fg=^(Y,�� N,��^):
	if /i "!fg!" == "N" (
		set fg=
		GOTO:EOF
	)
)

:: �������ģ��
echo # �����ű��� %This% >%filename%
echo # ��public���� ������Ϣ��>>%filename%
echo #  >>%filename%
echo # #�ſ�ͷΪע��>>%filename%
echo # ^=�����߲��ܿո�>>%filename%
echo #  >>%filename%
echo # ��⣺>>%filename%
echo # User_Name=�û���>>%filename%
echo # User_Email=����>>%filename%
echo # Fetch_Name=Զ�ֿ̲������>>%filename%
echo #  >>%filename%
echo # remote_name[0]=Զ�ֿ̲������>>%filename%
echo # 			 [0] ����������>>%filename%
echo #  >>%filename%
echo # remote_git[Զ�ֿ̲������]=git��ַ>>%filename%
echo #  >>%filename%
echo # remote_note[Զ�ֿ̲������]=[��ѡ]��ע>>%filename%
echo #  >>%filename%
echo # ʾ����>>%filename%
echo # User_Name=xxx>>%filename%
echo # User_Email=xxx@163.com>>%filename%
echo # Fetch_Name=Name0>>%filename%
echo #  >>%filename%
echo # remote_name[0]=Name0>>%filename%
echo # remote_name[1]=Name1>>%filename%
echo #  >>%filename%
echo # remote_git[Name0]=git0>>%filename%
echo # remote_git[Name1]=git1>>%filename%
echo #  >>%filename%
echo # remote_note[Name0]=Note0>>%filename%
echo # remote_note[Name1]=Note1>>%filename%
echo #  >>%filename%
echo User_Name=xxx>>%filename%
echo User_Email=xxx@163.com>>%filename%
echo Fetch_Name=Name0>>%filename%
echo.>>%filename%
echo remote_name[0]=Name0>>%filename%
echo.>>%filename%
echo remote_git[Name0]=git0>>%filename%
echo.>>%filename%
echo remote_note[Name0]=Note0>>%filename%
echo.>>%filename%

echo publicĿ¼��git�����ļ�[%filename%]������
echo ���ڴ��ļ�������
(
endlocal
REM �������
)
GOTO:EOF



::::::::����ʾ��:::::::::::
::call :outBatConf  


GOTO:EOF
:: ================================================== ::
:: �������ƣ�outBatConf								  ::
:: �������ܣ����ű������ļ����		 				  ::
:: ����������arg1:  			 		  	  		  ::
:: 			 arg2: 		 		  	  				  ::
::  		 	   									  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    												  ::
:: ================================================== ::
:outBatConf
:: �ջ� setlocal ... endlocal
setlocal

:: ����ļ���
set filename=%This%.conf
if exist %filename% (
	echo �ļ� [ %filename% ]�Ѵ��ڣ����ǣ�
	set /P fg=^(Y,�� N,��^):
	if /i "!fg!" == "N" (
		set fg=
		GOTO:EOF
	)
)

:: �������ģ��
echo # �����ű��� %This% >%filename%
echo # ���ű�������Ϣ��>>%filename%
echo #  >>%filename%
echo # #�ſ�ͷΪע��>>%filename%
echo # ^=�����߲��ܿո�>>%filename%
echo #  >>%filename%
echo # ��ʽ��>>%filename%
echo # key=value>>%filename%
echo #  >>%filename%
echo # ʾ����>>%filename%
echo # #�ļ��򿪳���^(����·�������·��^)>>%filename%
echo # exe=xxx.exe>>%filename%
echo # exe=C:\xxx.exe>>%filename%
echo #  >>%filename%
echo exe=D:\EditPlus\editplus.exe>>%filename%
echo.>>%filename%

echo ���ű������ļ�[%filename%]������
echo ���ڴ��ļ�������
(
endlocal
REM �������
)
GOTO:EOF





::::::::����ʾ��:::::::::::
::call :Parser_conf   write_list.conf  
::echo OutDir: %OutDir%
::echo postDirName: %postDirName%
::echo pageDirName: %pageDirName%
::echo draftDirName: %draftDirName%

GOTO:EOF
:: ================================================== ::
:: �������ƣ�Parser_conf							  ::
:: �������ܣ������ļ���������				 		  ::
:: ����������arg1: �ļ�			 		  	  		  ::
::  		 	   K:\c\write_list.conf	 	 		  ::
::  		 	   c\write_list.conf	 	 		  ::
::  		 	   write_list.conf		 	 		  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    												  ::
:: ================================================== ::
:Parser_conf

:: �ļ�
set _conf_file=%~1
if %debug%==1 echo  _conf_file: %_conf_file%

echo ���ر����������ԣ�[ %_conf_file% ]-------------------
:: �����ļ��еı���
for /f "usebackq  tokens=* delims=" %%a in ( "%_conf_file%" ) do (
	if %debug%==1 echo [file_line: %%a ]
	set _str=%%a
	set _kvstr=!_str:~0,2!
	if "!_kvstr!" == "#$" (
		set _confkv=!_str:~2!
		if %debug%==1 echo _confkv: !_confkv!
		for /f "usebackq  tokens=1,* delims=:" %%i in ( '!_confkv!' ) do (
			REM ���ñ���
			set "%%i=%%j"
			set %%i
		)
	)
)
echo ���ر����������ԣ�[ %_conf_file% ]-------------------
:: �ͷű���
set _conf_file=
GOTO:EOF





::::::::����ʾ��:::::::::::
REM call :Parser_file   write_list.conf   cb02
REM echo LineCount : %LineCount% 
REM echo postNum : %postNum%
REM echo pageNum : %pageNum% 
REM echo draftNum : %draftNum%
REM GOTO:EOF
REM :cb02
REM echo --------------------------------------
REM echo --[title: %_title%  ]--
REM echo --[tag1: %tag1%  ]--
REM echo --[tag2: %tag2%  ]--
REM echo --[tag3: %tag3%  ]--
REM echo --[tag4: %tag4%  ]--
REM echo --[tag5: %tag5%  ]--
REM echo --[top: %top%  ]--
REM echo --[template: %template%  ]--
REM echo --[filename: %filename%  ]--
REM echo --[type: %type%  ]--

REM :: �ÿձ��������Ӱ��
REM set _title=
REM set tag1=
REM set tag2=
REM set tag3=
REM set tag4=
REM set tag5=
REM set top=
REM set template=
REM set filename=
REM set type=
REM echo --------------------------------------
REM GOTO:EOF



GOTO:EOF
:: ================================================== ::
:: �������ƣ�Parser_file							  ::
:: �������ܣ������ļ��ض���ʽ����			 		  ::
:: ����������arg1: �ļ�			 		  	  		  ::
::  		 	   K:\c\write_list.conf	 	 		  ::
::  		 	   c\write_list.conf	 	 		  ::
::  		 	   write_list.conf		 	 		  ::
:: 			 arg2: �ص�����		 		  	  		  ::
::  		 	   ����ÿ������ʱ�Ļص�����			  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    %LineCount% �� �����м���				  		  ::
::      %postNum% �� post����					  	  ::
::      %pageNum% �� page����				  		  ::
::     %draftNum% �� draft����				  		  ::
:: ================================================== ::
:Parser_file
:: �ջ� setlocal ... endlocal
setlocal

:: �ļ�
set _file=%~1
if %debug%==1 echo  _file: %_file%

:: �ص�����
set CallBack=%~2

:: �����м���
set _LineCount=0

:: �����ļ�����
for /f "usebackq eol=# tokens=* delims=" %%a in ( "%_file%" ) do (
	if %debug%==1 echo [file_line: %%a ]
	
	REM ���ú�������ÿ������
	call :Parser_line "%%a"  "%CallBack%"
	
	REM ����+1
	set /A  _LineCount+=1
)

(
endlocal
REM �������
set LineCount=%_LineCount%
set postNum=%postNum%
set pageNum=%pageNum%
set draftNum=%draftNum%
set postsNum=%postsNum%
set pagesNum=%pagesNum%
set draftsNum=%draftsNum%
)
GOTO:EOF






::::::::����ʾ��:::::::::::
REM set str1=title:Title#tags:tag1,tag2,tag3,tag4,tag5#top:1#template:TemplateName#filename:FileName
REM set str2=title:Title#tags:tag1,tag2,tag3,tag4,tag5#top:1#template:TemplateName#filename:FileName#type:post

REM REM call :Parser_line  "%str1%"  cb01
REM call :Parser_line  "%str2%"  cb01
REM GOTO:EOF
REM :cb01
REM echo --------------------------------------
REM echo --[title: %_title%  ]--
REM echo --[tag1: %tag1%  ]--
REM echo --[tag2: %tag2%  ]--
REM echo --[tag3: %tag3%  ]--
REM echo --[tag4: %tag4%  ]--
REM echo --[tag5: %tag5%  ]--
REM echo --[top: %top%  ]--
REM echo --[template: %template%  ]--
REM echo --[filename: %filename%  ]--
REM echo --[type: %type%  ]--
REM echo --------------------------------------
REM GOTO:EOF


GOTO:EOF
:: ================================================== ::
:: �������ƣ�Parser_line							  ::
:: �������ܣ�������������					 		  ::
:: ����������arg1: ��������			 		  	  	  ::
::  		 	   ���10��key:value������	 		  ::
::  		 	   key:value#key:value	 	 		  ::
:: 			 arg2: �ص�����		 		  	  		  ::
::  		 	   ����������ʱ�Ļص�����			  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    												  ::
:: ================================================== ::
:Parser_line

:: ��������
set _line=%~1
if %debug%==1 echo  _line: %_line%

:: �ص�����
set CallBack=%~2


:: ������������
for /f "usebackq  tokens=1-10 delims=#" %%a in ( '%_line%' ) do (
	if %debug%==1 echo [a: %%a ]
	if %debug%==1 echo [b: %%b ]
	if %debug%==1 echo [c: %%c ]
	if %debug%==1 echo [d: %%d ]
	if %debug%==1 echo [e: %%e ]
	if %debug%==1 echo [f: %%f ]
	if %debug%==1 echo [g: %%g ]
	if %debug%==1 echo [h: %%h ]
	if %debug%==1 echo [i: %%i ]
	if %debug%==1 echo [j: %%j ]
	
	REM EQU - ����  NEQ - ������
	REM ���ú������� key:value	
	if "%%a" NEQ ""  call :Parser_kv  "%%a" 
	if "%%b" NEQ ""  call :Parser_kv  "%%b" 
	if "%%c" NEQ ""  call :Parser_kv  "%%c" 
	if "%%d" NEQ ""  call :Parser_kv  "%%d" 
	if "%%e" NEQ ""  call :Parser_kv  "%%e" 
	if "%%f" NEQ ""  call :Parser_kv  "%%f" 
	if "%%g" NEQ ""  call :Parser_kv  "%%g" 
	if "%%h" NEQ ""  call :Parser_kv  "%%h" 
	if "%%i" NEQ ""  call :Parser_kv  "%%i" 
	if "%%j" NEQ ""  call :Parser_kv  "%%j" 
	
	REM ͳ��------------------------------------------------------------	
	REM �������Ŀ¼
	if "!type!" == "post"  set Parser_line_out_dir=!OutDir!\!postDirName!
	if "!type!" == "page"  set Parser_line_out_dir=!OutDir!\!pageDirName!
	if "!type!" == "draft"  set Parser_line_out_dir=!OutDir!\!draftDirName!
	if %debug%==1 echo  Parser_line_out_dir : !Parser_line_out_dir!

	REM ���Ŀ¼
	if "!Parser_line_out_dir!" == "" (
		set Parser_line_destdir=%cd%\
	) else (
		set Parser_line_destdir=!Parser_line_out_dir!
	)
	
	REM �ļ�������
	if "!filename!" == "" (
		set Parser_line_filename=!_title!
	) else (
		set Parser_line_filename=!filename!
	)
	
	REM Ŀ���ļ�	
	if "!type!" == "page" (
		set Parser_line_destfile=!Parser_line_destdir!!Parser_line_filename!\index.md
	) else (
		set Parser_line_destfile=!Parser_line_destdir!!Parser_line_filename!.md
	)
	
	REM EQU - ����  NEQ - ������
	if "!_title!" NEQ "" (
		if %debug%==1 echo --- "!Parser_line_destfile!"
		if not exist "!Parser_line_destfile!" (	
			if %debug%==0 echo not exist--- "!Parser_line_destfile!"
			if "!type!" == "post" set /A postNum+=1
			if "!type!" == "page" set /A pageNum+=1
			if "!type!" == "draft" set /A draftNum+=1
			if "!type!" == "post" set /A postsNum+=1
			if "!type!" == "page" set /A pagesNum+=1
			if "!type!" == "draft" set /A draftsNum+=1
		)
	)
	REM ͳ��------------------------------------------------------------
	
	REM ���ûص�����
	call :%CallBack%	
) 

GOTO:EOF



::::::::����ʾ��:::::::::::
REM set str1=title:Title1
REM set str2=title2:Title2

REM call :Parser_kv  "%str1%" 
REM call :Parser_kv  "%str2%" 
REM echo --[title: %_title%  ]--
REM echo --[title2: %title2%  ]--


GOTO:EOF
:: ================================================== ::
:: �������ƣ�Parser_kv								  ::
:: �������ܣ�����key:value����					      ::
:: ����������arg1: key:value����			 		  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    												  ::
:: ================================================== ::
:Parser_kv

:: key:value ����
set _kv=%~1
:: title �滻Ϊ _title
set _kv=%_kv:title:=_title:%
if %debug%==1 echo  _kv: %_kv%


:: ����key:value ����
for /f "usebackq  tokens=1,* delims=:" %%a in ( '%_kv%' ) do (
	REM EQU - ����  NEQ - ������
	if "%%a" EQU "tags" (
		for /f "usebackq  tokens=1-5 delims= " %%i in ( '%%b' ) do (
			if %debug%==1 echo [_tag1: %%i ]
			if %debug%==1 echo [_tag2: %%j ]
			if %debug%==1 echo [_tag3: %%k ]
			if %debug%==1 echo [_tag4: %%l ]
			if %debug%==1 echo [_tag5: %%m ]
			
			REM ���ñ���
			set tag1=%%i
			set tag2=%%j
			set tag3=%%k
			set tag4=%%l
			set tag5=%%m
		)
	) else (
		REM ���ñ���
		set %%a=%%b
	)
)
:: type��������(Ĭ��post)
if "%type%" == "" set  type=post
GOTO:EOF




::::::::����ʾ��:::::::::::
::call :GitSets public_git.conf  %cd%\re 


GOTO:EOF
:: ================================================== ::
:: �������ƣ�GitSets								  ::
:: �������ܣ�����git�ֿ����������ļ�				  ::
:: ����������arg1: �����ļ�		 		  	  	  	  ::
::  		 	   K:\c\public_git.conf	 	 		  ::
::  		 	   c\public_git.conf	 	 		  ::
::  		 	   public_git.conf		 	 		  ::
::  		 	   ��ȡ����������Ϣ		 	 		  ::
:: 			 arg2: gitĿ¼ 		  	  		  	  	  ::
:: 		   [arg3]: ������ǰ׺	  	  		  	  	  ::
::           	   ����for����,Ĭ��(remote_name)	  ::
:: ����ֵ��          							      ::
::    												  ::
:: ================================================== ::
:GitSets
:: �ջ� setlocal ... endlocal
setlocal

:: ��־·������
set _logpath=%_logdir%\repo.log
if not exist %_logdir%\  mkdir  %_logdir%

:: �ļ�
set GitSets_conf_file=%~1

:: Ŀ��Ŀ¼
set GitSets_DestDir=%~2

:: ������ǰ׺
if "%~3" == "" (
	set GitSets_VarPrefix=remote_name
) else (
	set GitSets_VarPrefix=%~3
)

if %debug%==1 echo  GitSets_conf_file: %GitSets_conf_file%
if %debug%==1 echo  GitSets_DestDir: %GitSets_DestDir%
if %debug%==1 echo  GitSets_VarPrefix: %GitSets_VarPrefix%


:: ���ñ���
call :Parser_SetVar   %GitSets_conf_file%


:: Զ����Ϣ
set remote_info=

:: ��������װԶ����Ϣ
for /f "usebackq  tokens=* delims=" %%a in ( `set %GitSets_VarPrefix%` ) do (
	REM  [a: aaa1=aaaa ]
	if %debug%==1 echo  [a: %%a ]
	
	for /f "usebackq tokens=1,* delims==" %%i in ('%%a') do (
		REM  [i: aaa1 ] [j: aaaa ]
		if %debug%==1 echo  [i: %%i ] [j: %%j ]
		REM ��װԶ����Ϣ
		set remote_info=!remote_info!%%j:remote_git[%%j]#
	)
)
:: ȥ���ұ����һ���ַ�(#)
set "remote_info=%remote_info:~0,-1%"
if %debug%==1  echo  remote_info: "%remote_info%"

:: ���ú�������git�ֿ���Ϣ
call :GitSet %GitSets_DestDir%   %User_Name%  %User_Email%  "%remote_info%"  "%Fetch_Name%"

(
endlocal
REM �������
)
GOTO:EOF




::::::::����ʾ��:::::::::::

REM set ShortName1=t1
REM set ShortName2=t2
REM set gitVar1=https://github.com/KumaDocCenter/t1.git
REM set gitVar2=https://github.com/KumaDocCenter/t2.git

REM call :GitSet %cd%\re  kuma8866  kuma8866@163.com  "%ShortName1%:gitVar1#%ShortName2%:gitVar2"



GOTO:EOF
:: ================================================== ::
:: �������ƣ�GitSet									  ::
:: �������ܣ�����git�ֿ�					 		  ::
:: ����������arg1:  gitĿ¼		 		  	  		  ::
:: 			 arg2: 	�û��� 		  	  				  ::
:: 			 arg3: 	���� 		  	  				  ::
:: 			 arg4: 	Զ�ֿ̲���Ϣ  	  				  ::
:: 			 		��ʽ 		  	  				  ::
:: 			 		ShortName:gitVar#ShortName:gitVar ::
::  		 	   	���10��key:value				  ::
::           		ShortName,ʵ��ֵ				  ::
::           		gitVar,������					  ::
:: 		   [arg5]: 	Զ�ֿ̲������ 	  				  ::
::           		ץȡ(fetch)��Զ�ֿ̲�git���ݿ�	  ::
::           		��Ҫ��arg4�д��ڵ�				  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    												  ::
:: ================================================== ::
:GitSet
:: �ջ� setlocal ... endlocal
setlocal

if "%_logpath%" == "" (
	REM ��־·������
	set _logpath=%_logdir%\repo.log
)
if not exist %_logdir%\  mkdir  %_logdir%

:: Ŀ��Ŀ¼
set DestDir=%~1
:: �û���
set User_Name=%~2
:: ����
set User_Email=%~3
:: Զ�ֿ̲���Ϣ
set RepoInfo=%~4
:: fetch����(ShortName)
set fetch_name=%~5

if "%DestDir%" == "" (
	echo Ŀ��Ŀ¼����Ϊ��...
	GOTO:EOF
)

:: ��ת��Ŀ��Ŀ¼
cd  %DestDir%

if %debug%==1  echo DestDir: %DestDir%
if %debug%==1  echo User_Name: %User_Name%
if %debug%==1  echo User_Email: %User_Email%
if %debug%==1  echo RepoInfo: %RepoInfo%
if %debug%==1  echo cd: %cd%

echo ------------------------ �ֿ�����  ------------------------ 
echo ------------------------ �ֿ�����  ------------------------ >%_logpath%

:: �ֿ��ʼ������
if not exist .git\ (
	REM ������.gitĿ¼
	if not exist .git (
		REM ������.git�ļ�
		(
		echo �ֿ��ʼ��...
		echo �ֿ��ʼ��...>>%_logpath%
		git init
		) && (
		echo �ֿ��ʼ���ɹ�...
		echo �ֿ��ʼ���ɹ�...>>%_logpath%
		) || (
		echo �ֿ��ʼ��ʧ��...
		echo �ֿ��ʼ��ʧ��...>>%_logpath%
		)
	) else (
		REM ����.git�ļ�
		echo ����.git�ļ�
		echo ����.git�ļ�>>%_logpath%
	)
) else (
	echo ����.gitĿ¼
	echo ����.gitĿ¼>>%_logpath%
)


:: EQU - ����  NEQ - ������
if "%User_Name%" NEQ "" (
	(
	echo �����û���...
	echo �����û���...>>%_logpath%
	git config user.name "%User_Name%"
	) && (
	echo �����û����ɹ�...	
	echo �����û����ɹ�...>>%_logpath%	
	) || (
	echo �����û���ʧ��...
	echo �����û���ʧ��...>>%_logpath%
	)
) else (
	echo �û���Ϊ��...
	echo �û���Ϊ��...>>%_logpath% 
)

:: EQU - ����  NEQ - ������
if "%User_Email%" NEQ "" (
	(
	echo ��������... 
	echo ��������...>>%_logpath% 
	git config user.email "%User_Email%" 
	) && (
	echo ��������ɹ�...
	echo ��������ɹ�...>>%_logpath%	
	) || (
	echo ��������ʧ��...
	echo ��������ʧ��...>>%_logpath%
	)
) else (
	echo ����Ϊ��...
	echo ����Ϊ��...>>%_logpath% 
)

:: EQU - ����  NEQ - ������
if "%RepoInfo%" NEQ "" (
	REM ������������
	for /f "usebackq  tokens=1-10 delims=#" %%a in ( '%RepoInfo%' ) do (
		if %debug%==1 echo [a: %%a ]
		if %debug%==1 echo [b: %%b ]
		if %debug%==1 echo [c: %%c ]
		if %debug%==1 echo [d: %%d ]
		if %debug%==1 echo [e: %%e ]
		if %debug%==1 echo [f: %%f ]
		if %debug%==1 echo [g: %%g ]
		if %debug%==1 echo [h: %%h ]
		if %debug%==1 echo [i: %%i ]
		if %debug%==1 echo [j: %%j ]
		
		REM EQU - ����  NEQ - ������
		REM ���ú������� key:value	
		if "%%a" NEQ ""  call :GitSet_cb01  "%%a"
		if "%%b" NEQ ""  call :GitSet_cb01  "%%b" 
		if "%%c" NEQ ""  call :GitSet_cb01  "%%c" 
		if "%%d" NEQ ""  call :GitSet_cb01  "%%d" 
		if "%%e" NEQ ""  call :GitSet_cb01  "%%e" 
		if "%%f" NEQ ""  call :GitSet_cb01  "%%f" 
		if "%%g" NEQ ""  call :GitSet_cb01  "%%g" 
		if "%%h" NEQ ""  call :GitSet_cb01  "%%h" 
		if "%%i" NEQ ""  call :GitSet_cb01  "%%i" 
		if "%%j" NEQ ""  call :GitSet_cb01  "%%j" 
	) 
) else (
	echo Զ�ֿ̲���Ϣ Ϊ��...
	echo Զ�ֿ̲���Ϣ Ϊ��...>>%_logpath% 
)

(
echo �����ύ����...
echo �����ύ����...>>%_logpath%
git config http.postBuffer  524288000 
) && (
echo �����ύ����ɹ�...
echo �����ύ����ɹ�...>>%_logpath%	
) || (
echo �����ύ����ʧ��...
echo �����ύ����ʧ��...>>%_logpath%
)

:: EQU - ����  NEQ - ������
:: ץȡ(fetch)Զ�ֿ̲�git���ݿ�
if "%fetch_name%"  NEQ "" (
	(
	echo ץȡ^(fetch^)Զ�ֿ̲�[%fetch_name%]git����...
	echo ץȡ^(fetch^)Զ�ֿ̲�[%fetch_name%]git����...>>%_logpath%
	git fetch -q -f --depth 50 %fetch_name%
	) && (
	echo ץȡ^(fetch^)Զ�ֿ̲�[%fetch_name%]git���ݳɹ�...
	echo ץȡ^(fetch^)Զ�ֿ̲�[%fetch_name%]git���ݳɹ�...>>%_logpath%	
	) || (
	echo ץȡ^(fetch^)Զ�ֿ̲�[%fetch_name%]git����ʧ��...
	echo ץȡ^(fetch^)Զ�ֿ̲�[%fetch_name%]git����ʧ��...>>%_logpath%
	)
)

echo ------------------------ �ֿ�����  ------------------------ 
echo ------------------------ �ֿ�����  ------------------------ >>%_logpath%

(
endlocal
REM �������
)
GOTO:EOF

GOTO:EOF
:: ================================================== ::
:: �������ƣ�GitSet_cb01							  ::
:: �������ܣ�����key:value���ݲ����Զ�ֿ̲�	      ::
:: ����������arg1: key:value����			 		  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    												  ::
:: ================================================== ::
:GitSet_cb01

if "%_logpath%" == "" (
	REM ��־·������
	set _logpath=%_logdir%\repo.log
)
if not exist %_logdir%\  mkdir  %_logdir%

:: key:value ����
set GitSet_cb01_kv=%~1
if %debug%==1 echo  GitSet_cb01_kv: %GitSet_cb01_kv%

REM EQU - ����  NEQ - ������
:: ���� key:value ����
for /f "usebackq  tokens=1,* delims=:" %%a in ( '%GitSet_cb01_kv%' ) do (
	REM ���ñ���
	set %%a=%%b
	if "%%b"  NEQ "" (
		echo ------------------------------------
		echo ------------------------------------>>%_logpath%
		(
		echo ���Զ�ֿ̲���Ϣ[ %%a ]...
		echo ���Զ�ֿ̲���Ϣ[ %%a ]...>>%_logpath%
		git remote remove %%a        2>>%_logpath%
		git remote add %%a   !%%b!	  2>>%_logpath%
		) && (
		echo ���Զ�ֿ̲���Ϣ[ %%a ]�ɹ�...
		echo ���Զ�ֿ̲���Ϣ[ %%a ]�ɹ�...>>%_logpath%
		) || (
		echo ���Զ�ֿ̲���Ϣ[ %%a ]ʧ��...
		echo ���Զ�ֿ̲���Ϣ[ %%a ]ʧ��...>>%_logpath%
		)
		echo ------------------------------------
		echo ------------------------------------>>%_logpath%
	)
)
GOTO:EOF




::::::::����ʾ��:::::::::::
::call :GitDeploys public_git.conf  %cd%\re 


GOTO:EOF
:: ================================================== ::
:: �������ƣ�GitDeploys								  ::
:: �������ܣ���������(����)git�ֿ�				 	  ::
:: ����������arg1: �����ļ�		 		  	  	  	  ::
::  		 	   K:\c\public_git.conf	 	 		  ::
::  		 	   c\public_git.conf	 	 		  ::
::  		 	   public_git.conf		 	 		  ::
::  		 	   ��ȡԶ�˲ֿ������	 	 		  ::
:: 			 arg2: gitĿ¼ 		  	  		  	  	  ::
:: 		   [arg3]: ������ǰ׺	  	  		  	  	  ::
::           	   ����for����,Ĭ��(remote_name)	  ::
:: ����ֵ��          							      ::
::    												  ::
:: ================================================== ::
:GitDeploys
:: �ջ� setlocal ... endlocal
setlocal

:: ��־·������
set _logpath=%_logdir%\repo.push.log
if not exist %_logdir%\  mkdir  %_logdir%

:: �ļ�
set GitDeploys_conf_file=%~1

:: Ŀ��Ŀ¼
set GitDeploys_DestDir=%~2

:: ������ǰ׺
if "%~3" == "" (
	set GitDeploys_VarPrefix=remote_name
) else (
	set GitDeploys_VarPrefix=%~3
)

if %debug%==1 echo  GitDeploys_conf_file: %GitDeploys_conf_file%
if %debug%==1 echo  GitDeploys_DestDir: %GitDeploys_DestDir%
if %debug%==1 echo  GitDeploys_VarPrefix: %GitDeploys_VarPrefix%


:: ���ñ���
call :Parser_SetVar   %GitDeploys_conf_file%

:: �ֿ�����
echo ------------------------ �ֿ�����  ------------------------ 
echo ------------------------ �ֿ�����  ------------------------ >%_logpath%

:: ����ʱ�亯��
call :_time  

:: ��ǰcd
set Tcd=%cd%
:: ��ת��Ŀ��Ŀ¼
cd %GitDeploys_DestDir%

if not exist .git\ (
	if not exist .git (
		echo Ŀ�겻��git�ֿ�,��������git�ֿ�...
		echo Ŀ�겻��git�ֿ�,��������git�ֿ�...>>%_logpath%
		GOTO GitDeploys_END
	)
)

if  exist .git (
	echo ��������ļ�...
	echo ��������ļ�...>>%_logpath%
	git add .

	echo git�ύ...
	echo git�ύ...>>%_logpath%
	git commit -m "�����Զ������� %datetime%" 
)

:: ��ת����ǰcd
cd %Tcd%


for /f "usebackq  tokens=* delims=" %%a in ( `set %GitDeploys_VarPrefix%` ) do (
	REM  [a: aaa1=aaaa ]
	if %debug%==1 echo  [a: %%a ]
	
	for /f "usebackq tokens=1,* delims==" %%i in ('%%a') do (
		REM  [i: aaa1 ] [j: aaaa ]
		if %debug%==1 echo  [i: %%i ] [j: %%j ]
		REM ���ú������͵���Զ��
		call :GitDeploy  "%GitDeploys_DestDir%"  "%%j"
	)
)
:GitDeploys_END
echo ------------------------ �ֿ�����  ------------------------ 
echo ------------------------ �ֿ�����  ------------------------ >>%_logpath%

(
endlocal
REM �������
)
GOTO:EOF




::::::::����ʾ��:::::::::::
::call :GitDeploy %cd%\re  t1 


GOTO:EOF
:: ================================================== ::
:: �������ƣ�GitDeploy								  ::
:: �������ܣ�����(����)git�ֿ�				 		  ::
:: ����������arg1:  gitĿ¼		 		  	  		  ::
:: 			 arg2: 	Զ�ֿ̲������ 		  	  		  ::
:: 		   [arg3]: 	��֧		  	  				  ::
:: 			 		�����ͷ�֧����,Ĭ�� master	 	  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    												  ::
:: ================================================== ::
:GitDeploy
:: �ջ� setlocal ... endlocal
setlocal

if "%_logpath%" == "" (
	REM ��־·������
	set _logpath=%_logdir%\repo.push.log
)
if not exist %_logdir%\  mkdir  %_logdir%

:: Ŀ��Ŀ¼
set DestDir=%~1
:: Զ�ֿ̲������
set ShortName=%~2
:: ��֧
if "%~3" == "" (
	set branch=master
) else (
	set branch=%~3
)


if "%DestDir%" == "" (
	echo Ŀ��Ŀ¼ ����Ϊ��...
	echo Ŀ��Ŀ¼ ����Ϊ��...>>%_logpath%
	GOTO:EOF
)
if "%ShortName%" == "" (
	echo Զ�ֿ̲������ ����Ϊ��...
	echo Զ�ֿ̲������ ����Ϊ��...>>%_logpath%
	GOTO:EOF
)

:: ��ת��Ŀ��Ŀ¼
cd  %DestDir%

if not exist .git\ (
	if not exist .git (
		echo Ŀ�겻��git�ֿ�...
		echo Ŀ�겻��git�ֿ�...>>%_logpath%
		GOTO:EOF
	)
)

if %debug%==1  echo DestDir: %DestDir%
if %debug%==1  echo ShortName: %ShortName%
if %debug%==1  echo branch: %branch%
if %debug%==1  echo _logpath: %_logpath%
if %debug%==1  echo cd: %cd%

echo ------------------------------------
echo ------------------------------------>>%_logpath%
(
echo ��ʼ����[%branch%]��֧��[%ShortName%]...
echo ��ʼ����[%branch%]��֧��[%ShortName%]...>>%_logpath%
git push -f -q  %ShortName%  %branch%
) && (
echo ����[%branch%]��֧��[%ShortName%]�ɹ�...	
echo ����[%branch%]��֧��[%ShortName%]�ɹ�...>>%_logpath%	
) || (
echo ����[%branch%]��֧��[%ShortName%]ʧ��...	
echo ����[%branch%]��֧��[%ShortName%]ʧ��...>>%_logpath%	
)
echo ------------------------------------
echo ------------------------------------>>%_logpath%

(
endlocal
REM �������
)
GOTO:EOF





:: ==========[Function]================================================================== ::

::::::::����ʾ��:::::::::::
::call :Parser_SetVar   public_git.conf  
::echo User_Name: "%User_Name%"
::set remote


GOTO:EOF
:: ================================================== ::
:: �������ƣ�Parser_SetVar							  ::
:: �������ܣ����������ñ���				 			  ::
:: ����������arg1: �����ļ�			 		  	  	  ::
::  		 	   K:\c\public_git.conf	 	 		  ::
::  		 	   c\public_git.conf	 	 		  ::
::  		 	   public_git.conf		 	 		  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    												  ::
:: ================================================== ::
:Parser_SetVar

:: �ļ�
set _conf_file=%~1
if %debug%==1 echo  _conf_file: %_conf_file%

echo ���ر����������ԣ�[ %_conf_file% ]-------------------
:: �����ļ��еı���
for /f "usebackq eol=# tokens=* delims=" %%a in ( "%_conf_file%" ) do (
	if %debug%==1 echo [file_line: %%a ]
	
	REM ���ñ���
	set %%a
	
	REM ��ʾ����
	for /f "usebackq tokens=1,* delims==" %%i in ( '%%a' ) do (
		set %%i
	)
)
echo ���ر����������ԣ�[ %_conf_file% ]-------------------
:: �ͷű���
set _conf_file=
GOTO:EOF




::::::::����ʾ��:::::::::::
REM call :is_DestDir  cd1###cd2  a.txt:dir  1  VarName1  VarName2

::call :is_DestDir  %ThisDir%###%ThisDir%  node_modules:source  1  res  rescd
::echo res: %res%
::echo rescd: %rescd%

GOTO:EOF
:: ================================================== ::
:: �������ƣ�is_DestDir							 	  ::
:: �������ܣ��Ƿ�����ȷ��Ŀ¼			 			  ::
:: ����������arg1: cd					 		  	  ::
::  		 	   ��ʽ �� Ŀ��cd###��λcd		 	  ::
::  		 arg2: ����(�ļ���Ŀ¼�������2��)		  ::
::  		 	   ��ʽ �� aaa:bbb				 	  ::
::  		 arg3: �Ƿ�ݹ����			 			  ::
::  		 	   1���ǣ�0����(Ĭ��)				  ::
::  		 arg4: ������				 			  ::
::  		 	   �洢���				 			  ::
::  		 arg5: ������				 			  ::
::  		 	   �洢�����cd·��		 			  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    %<arg4>%  �� ���							      ::
::        		   1������ȷĿ¼		  			  ::
::        		   0��������ȷĿ¼		  			  ::
::    %<arg5>%  �� cd·��						      ::
::        		   E:\...\Script\sh					  ::
:: ================================================== ::
:is_DestDir
:: �ջ� setlocal ... endlocal
setlocal

:: ����������cd
for /f "usebackq tokens=1,2 delims=###" %%a in ( '%~1' ) do (
	set "cd1=%%a"
	set "cd2=%%b"
)

:: ��������������
for /f "usebackq tokens=1,2 delims=:" %%a in ( '%~2' ) do (
	set condition1=%%a
	set condition2=%%b
)


:: �Ƿ�ݹ���� 
if "%~3" == "" (
	set is_recursion=0
) else (
	set is_recursion=%~3
)

:: �������
set res=0

:: ��ת��ָ��·��
cd %cd1%


:is_DestDir_Loop
:: �����ж�
if  "%res%" == "1"  (	
	GOTO is_DestDir_END
) 
:: �ж��Ƿ��������ָ�����ļ���Ŀ¼
if exist %condition1% (
	if exist %condition2% (
		set res=1
	)
)
:: �����ж�
if  "%is_recursion%" == "0"  (
	GOTO is_DestDir_END
)
:: ��ת���ϼ�Ŀ¼
cd..
:: ѭ��
GOTO is_DestDir_Loop


:is_DestDir_END
:: ������ȷ���ʱ��cd
set _cd=!cd!
:: cd��λ
cd %cd2%

if %debug%==1 echo res: %res% 
if %debug%==1 echo cd: %_cd% 
(
endlocal
REM �������
set %~4=%res%
set %~5=%_cd%
)
GOTO:EOF






::::::::����ʾ��:::::::::::
REM call :_time  -

::call :_time  
::echo datetime: %datetime%
::echo timestamp: %timestamp%

GOTO:EOF
:: ================================================== ::
:: �������ƣ�_time								 	  ::
:: �������ܣ���ȡʱ�������Ϣ			 			  ::
:: ����������[arg1]: ���ڷָ���			 		  	  ::
::  		 	     Ĭ�� -						 	  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    %datetime%  �� ʱ��							  ::
::        		     2018-12-10 21:43:58  			  ::
::    %timestamp%  ��ʱ���						      ::
::        		     20181210214358 			 	  ::
:: ================================================== ::
:_time
:: �ջ� setlocal ... endlocal
setlocal

if %debug%==1 echo ------------------------ ��������ʱ���ʱ���  ----------------------

:: ���ڷָ���
if "%~1" == "" (
	set delim=-
) else (
	set delim=%~1
)


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

:: ����ʱ�� ��( 20181210214358 )
set deti=%de%%ti%
:::: ȥ�����пո�
set timestamp=%deti: =%
if %debug%==1 echo ʱ�����"%timestamp%"

if %debug%==1 echo ------------------------ ��������ʱ���ʱ���  ----------------------

(
endlocal
REM �������
set datetime=%datetime%
set timestamp=%timestamp%
)
GOTO:EOF



::::::::����ʾ��:::::::::::
::set "str=echo --aaa--"

::call :Parser_cmd  "%str%" 0  1
::call :Parser_cmd  "%str%" 1


GOTO:EOF
:: ================================================== ::
:: �������ƣ�Parser_cmd								  ::
:: �������ܣ��������								  ::
:: ����������arg1: �����ַ���	 		  	  		  ::
:: 			 	   "echo aaa"		  				  ::
:: 		   [arg2]: �Ƿ������������  	  			  ::
::  		 	   1,��								  ::
::  		 	   0,��(Ĭ��)						  ::
:: 		   [arg3]: �Ƿ������´���	  	  			  ::
::  		 	   1,��								  ::
::  		 	   0,��(Ĭ��)						  ::
::           							 			  ::
:: ����ֵ��          							      ::
::    												  ::
:: ================================================== ::
:Parser_cmd

:: �����ַ���
set "_cmdstr=%~1"
set "_cmdstr0=%_cmdstr%"
if "%_cmdstr%" == "" (
	echo [%~0]: ���벻��Ϊ��
	GOTO:EOF
)
if %debug%==1  echo  _cmdstr: "%_cmdstr%" 

:: �Ƿ������������
if "%~2" == "" (
	set _nomsg=0
) else (
	set _nomsg=%~2
)
if %debug%==1  echo  _nomsg: "%_nomsg%"

:: �Ƿ������´���
if "%~3" == "" (
	set is_newWindow=0
) else (
	set is_newWindow=%~3
)
if %debug%==1  echo  is_newWindow: "%is_newWindow%"

:: �����´���
if "%is_newWindow%" == "1"  set "_cmdstr=start %_cmdstr%"

:: ִ������
echo ����ִ����...
(
	if "%_nomsg%" == "0"  %_cmdstr% 
	if "%_nomsg%" == "1"  %_cmdstr% 1>nul 2>nul
) && (
	echo.
	echo [ %_cmdstr0% ]
	echo ����ִ�гɹ�...
) || (
	echo.
	echo [ %_cmdstr0% ]
	echo ����ִ��ʧ��...
)

:: �ͷű���
set _cmdstr=
set _nomsg=
GOTO:EOF


:: ==========[Function]================================================================== ::






