:: =================================================================== ::
::  
:: 
:: REM 为达预期效果，不能有残留的旧文件，所以仓库每次都是1个提交
:: 存放目录：  
:: 运行目录： 
:: 
:: =================================================================== ::
:: Parser  解析器

:::::::::::::::: 预置变量 ::::::::::::::::
:: 关闭回显
@echo off
:: 设置颜色
color 0A
:: 调试开关
set debug=0
:: 开启变量延迟
setlocal EnableDelayedExpansion
:: 跳转到脚本目录 
cd %~dp0

:: 当前文件名(xxx.bat)
set This=%~nx0
:: 当前文件名全路径(E:\...\xxx.bat)
set ThisFull=%~dpnx0
:: 当前文件目录(E:\...\Script\sh)
set ThisDir=%cd%

:: EQU - 等于  NEQ - 不等于
if  "%debug%" == "1"  echo This: %This%
if  "%debug%" == "1"  echo ThisFull: %ThisFull%
if  "%debug%" == "1"  echo ThisDir: %ThisDir%

:::::::::::::::: 预置变量 ::::::::::::::::

:::::::::::::::: 全局变量 ::::::::::::::::

:: posts数量
set postsNum=0
:: pages数量
set pagesNum=0
:: drafts数量
set draftsNum=0

:: post数量
set postNum=0
:: page数量
set pageNum=0
:: draft数量
set draftNum=0

call :is_DestDir  %ThisDir%###%ThisDir%  node_modules:source  0  res  rescd
:: if "%res%" == "1" echo in hexo
:: if "%res%" == "0" echo not in hexo

:: 日志目录
set _logdir=%ThisDir%\%This%.log
if not exist %_logdir%\  mkdir  %_logdir%

:: 是否打开文件(1,是 0,否)
set is_open=0

:::::::::::::::: 全局变量 ::::::::::::::::

:: 跳转调度
if "%res%" == "1" goto hexo
if "%res%" == "0" goto Other


:: ***********************************Other 管理******************************************** ::

:: ==========[文章管理]========================================================================== ::
GOTO:EOF
:Other
:OtherArticleManage
:: cls： 清除屏幕上面的输出
cls

echo.
echo -----------------------------------------------------      
echo   ************ 文章管理 ************
echo.
echo.
echo     1.新建文章  
echo     2.批量新建文章
if exist %_logdir%\ (
	echo     4.删除日志目录
)
echo.  
echo     3.退出
echo. 
echo -----------------------------------------------------    
set cho=
set /p cho=请选择：
  
if "%cho%" == "1" goto OtherArticleManage_New
if "%cho%" == "2" goto OtherArticleManage_BatchNew
if "%cho%" == "3" goto Texit
if exist %_logdir%\ (
	if "%cho%" == "4" goto OtherDelLogDir
)

:: 意外输入时，跳转回当前菜单
echo 输入有误...
pause
goto OtherArticleManage
GOTO:EOF

GOTO:EOF
:: 删除日志目录
:OtherDelLogDir

if %debug%==1 echo call :DelLogDir
call :DelLogDir

pause
goto OtherArticleManage
GOTO:EOF



GOTO:EOF
:OtherArticleManage_New
:: cls： 清除屏幕上面的输出
cls

echo.
echo -----------------------------------------------------      
echo   ************ 文章管理 ************
echo.
echo  新建文章：
echo.
echo  【语法】
echo title:Title#tags:tag1,tag2,tag3,tag4,tag5#top:1#template:TemplateName#filename:FileName#type:post 
echo.
echo  【解释】
echo title:标题 
echo 	[必需] 文章标题,可用于文件名，不含后缀。 
echo tags:标签1,标签2,标签3,标签4,标签5 
echo 	[可选] 最多5个标签 
echo top:1  
echo 	[可选] 置顶值，范围(0~)，默认1 
echo template:模版名称 
echo 	[可选] 在特定目录才适用  
echo filename:文件名 
echo 	[可选] 指定文件名，不含后缀  
echo type:post 
echo 	[可选] 指定文章类型(post ^| page ^| draft)  
echo.
echo.
echo     2.上级菜单   
echo     3.退出
echo. 
echo -----------------------------------------------------    
set cho=
set /p cho=请输入：
  
if "%cho%" == "2" goto OtherArticleManage
if "%cho%" == "3" goto Texit

:: EQU - 等于  NEQ - 不等于
if "%cho%" NEQ ""  (
	if %debug%==1 echo call :out_md  1 "%cho%" 
	set is_open=1
	call :out_md  1 "%cho%" 
	pause
	goto OtherArticleManage_New
)

:: 意外输入时，跳转回当前菜单
echo 输入有误...
pause
goto OtherArticleManage_New
GOTO:EOF



GOTO:EOF
:OtherArticleManage_BatchNew
:: cls： 清除屏幕上面的输出
cls

echo.
echo -----------------------------------------------------      
echo   ************ 文章管理 ************
echo.
echo  批量新建文章：
echo.
if not exist write_list.conf (
echo     1.批量配置文件输出
) else (
echo     1.执行批量新建文章
)
echo.
echo     2.上级菜单   
echo     3.退出
echo. 
echo -----------------------------------------------------    
set cho=
set /p cho=请选择：

if not exist write_list.conf (	
	if "%cho%" == "1" goto OtherArticleManage_BatchNew_outConf
) else (	
	if "%cho%" == "1" goto OtherArticleManage_BatchNew_out	
)
if "%cho%" == "2" goto OtherArticleManage
if "%cho%" == "3" goto Texit

:: 意外输入时，跳转回当前菜单
echo 输入有误...
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
:: ==========[文章管理]========================================================================== ::

:: ***********************************Other 管理******************************************** ::




:: ***********************************Windows hexo 管理******************************************** ::

GOTO:EOF
:hexo
:: cls： 清除屏幕上面的输出
cls

echo.
echo -----------------------------------------------------      
echo   ************ Windows hexo 管理 ************
echo.
echo 请选择管理类型：
echo.
echo     1.文章管理
echo     2.服务管理
echo     3.配置管理
if exist %_logdir%\ (
	echo     5.删除日志目录
)
echo.      
echo     4.退出
echo. 
echo -----------------------------------------------------    
set cho=
set /p cho=请选择：

if "%cho%" == "1" goto HexoArticleManage
if "%cho%" == "2" goto HexoServiceManage
if "%cho%" == "3" goto HexoConfManage
if exist %_logdir%\ (
	if "%cho%" == "5" goto HexoDelLogDir
)
if "%cho%" == "4" goto Texit

:: 意外输入时，跳转回当前菜单
echo 输入有误...
pause
goto hexo
GOTO:EOF

GOTO:EOF
:: 删除日志目录
:HexoDelLogDir

if %debug%==1 echo call :DelLogDir
call :DelLogDir

pause
goto hexo
GOTO:EOF




:: ==========[配置管理]========================================================================= ::
GOTO:EOF
:HexoConfManage
:: cls： 清除屏幕上面的输出
cls

echo.
echo -----------------------------------------------------      
echo   ************ Windows hexo 管理 ************
echo.
echo Hexo ^>^> 配置管理：
echo.
echo     1.打开根目录
echo     2.打开主题根目录
if not exist %This%.conf (
	echo     3.输出脚本配置文件
) else (
	echo     3.打开站点配置
)
echo.
echo     4.上级菜单      
echo     5.退出
echo. 
echo -----------------------------------------------------
set cho=
set /p cho=请选择：

if "%cho%" == "1" goto HexoConfManage_OpenRoot
if "%cho%" == "2" goto HexoConfManage_OpenThemesRoot
if not exist %This%.conf (
	if "%cho%" == "3" goto HexoConfManage_outBatConf
) else (
	if "%cho%" == "3" goto HexoConfManage_OpenSiteConf
)
if "%cho%" == "4" goto hexo
if "%cho%" == "5" goto Texit


:: 意外输入时，跳转回当前菜单
echo 输入有误...
pause
goto HexoConfManage
GOTO:EOF


GOTO:EOF
:: 打开根目录
:HexoConfManage_OpenRoot

if %debug%==1 echo start %cd%
start %cd%

pause
goto HexoConfManage
GOTO:EOF


GOTO:EOF
:: 打开主题根目录
:HexoConfManage_OpenThemesRoot

if %debug%==1 echo  start %cd%\themes\
start %cd%\themes\

pause
goto HexoConfManage
GOTO:EOF


GOTO:EOF
:: 输出脚本配置文件
:HexoConfManage_outBatConf

if %debug%==1 echo call :outBatConf 
call :outBatConf 

pause
goto HexoConfManage
GOTO:EOF


GOTO:EOF
:: 打开站点配置
:HexoConfManage_OpenSiteConf

if %debug%==1 echo call :Parser_SetVar   %This%.conf  
if %debug%==1 echo start %exe%  _config.yml
call :Parser_SetVar   %This%.conf  
start %exe%  _config.yml

pause
goto HexoConfManage
GOTO:EOF

:: ==========[配置管理]========================================================================= ::




:: ==========[服务管理]========================================================================= ::
GOTO:EOF
:HexoServiceManage
:: cls： 清除屏幕上面的输出
cls

echo.
echo -----------------------------------------------------      
echo   ************ Windows hexo 管理 ************
echo.
echo Hexo ^>^> 服务管理：
echo.
echo     1.清除^(hexo clean^)
echo     2.生成^(hexo g^)
echo     3.部署^(hexo d^)
echo     4.启用本地服务器^(hexo s^)
if not exist public.bak (
echo     5.Public备份
) else (
echo     5.Public恢复
)
echo     6.Public部署^(支持多线部署^)
echo.
echo     7.上级菜单      
echo     8.退出
echo. 
echo -----------------------------------------------------
set cho=
set /p cho=请选择：
  
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

:: 意外输入时，跳转回当前菜单
echo 输入有误...
pause
goto HexoServiceManage
GOTO:EOF

GOTO:EOF
:HexoServiceManage_public_d
:: cls： 清除屏幕上面的输出
cls

echo.
echo -----------------------------------------------------      
echo   ************ Windows hexo 管理 ************
echo.
echo Hexo ^>^> 服务管理 ^>^> Public部署：
echo.
if not exist public_git.conf (
	echo     1.配置输出
) else (
	echo     1.配置git仓库
	echo     2.执行Public部署	
)
echo.
echo     3.上级菜单      
echo     4.主菜单      
echo     5.退出
echo. 
echo -----------------------------------------------------
set cho=
set /p cho=请选择：

if not exist public_git.conf (
	if "%cho%" == "1" goto HexoServiceManage_public_outconf
) else (	
	if "%cho%" == "1" goto HexoServiceManage_public_conf
	if "%cho%" == "2" goto HexoServiceManage_public_dd
)
if "%cho%" == "3" goto HexoServiceManage
if "%cho%" == "4" goto hexo
if "%cho%" == "5" goto Texit

:: 意外输入时，跳转回当前菜单
echo 输入有误...
pause
goto HexoServiceManage
GOTO:EOF



GOTO:EOF
:: 配置输出
:HexoServiceManage_public_outconf

if %debug%==1 echo call :out_public_git
call :out_public_git

pause
goto HexoServiceManage_public_d
GOTO:EOF


GOTO:EOF
:: 配置git仓库
:HexoServiceManage_public_conf

if not exist "%cd%\public_deploy"  mkdir  "%cd%\public_deploy"
REM 核心函数调用
if %debug%==1 echo call :GitSets public_git.conf  "%cd%\public_deploy"
call :GitSets public_git.conf  "%cd%\public_deploy"

pause
goto HexoServiceManage_public_d
GOTO:EOF


GOTO:EOF
:: 执行Public部署
:HexoServiceManage_public_dd

echo.
echo 警告！
echo 远端存在本地不存在的文件，不会自动检出
echo 如果没有检出，将会删除远端的这些文件
echo.
echo 若有固定的文件，请放置在 [public_git] 目录下
echo 此目录下内容将会自动复制到 [public_deploy] 目录下，覆盖文件。
echo.
echo 是否继续？
set /p c_dd=(Y,是 N,否):

if /i "%c_dd%" == "Y" (
	set c_dd=	
	if not exist "%cd%\public_deploy"  mkdir  "%cd%\public_deploy"
	
	REM 判断是否是git仓库
	if not exist "%cd%\public_deploy\.git\" (
		echo 目标不是git仓库,请先配置git仓库...
		pause
		goto HexoServiceManage_public_d
	)
	
	REM 输出排除复制的配置文件
	echo .git>%_logdir%\uncopy_public.txt
	echo \.git\>>%_logdir%\uncopy_public.txt
	echo ReadMe.re>%_logdir%\uncopy_public_git.txt
	
	REM 处理 public 目录
	if exist public\ (		
		xcopy  public\*  public_deploy /EIY /EXCLUDE:%_logdir%\uncopy_public.txt
	) else  (
		echo public 目标不存在，请生成它...
		goto HexoServiceManage_public_dd_END
	)
	
	REM 处理 public_git 目录
	if exist public_git\ (
		REM 复制[public_git] 到 [public] 目录下
		xcopy  public_git\*  public_deploy /EIY  /EXCLUDE:%_logdir%\uncopy_public_git.txt
	) else (
		REM 创建目录
		mkdir public_git
		REM 输出说明文档
		echo 此目录下的为固定文件，将一起部署到远端>public_git\ReadMe.re
		echo 此目录下内容将会自动复制到 [public_deploy] 目录下，覆盖文件。>>public_git\ReadMe.re
		echo 此文件[ReadMe.re]不复制>>public_git\ReadMe
	)
	
	REM 核心函数调用
	if %debug%==1 echo call :GitDeploys   public_git.conf   "%cd%\public_deploy"
	call :GitDeploys  public_git.conf   "%cd%\public_deploy"
	
	REM 删除部署目录
	REM 为达预期效果，不能有残留的旧文件，所以仓库每次都是1个提交
	if exist "%cd%\public_deploy\.git\" (
		rd /S /Q "%cd%\public_deploy\"
	)
) else (
	set c_dd=
	echo 未执行任何操作...
)	
:HexoServiceManage_public_dd_END
pause
goto HexoServiceManage
GOTO:EOF


GOTO:EOF
:: Public备份
:HexoServiceManage_public_backup
if exist public.bak\ (	
	echo [public.bak] 已存在
	echo 将删除现存的[public.bak]目录，是否继续？
	set /p isok=^(Y,是 N,否^)：
	
	if /i "%isok%" == "Y" (
		set  isok=
		(		
		rd /s/q  public.bak
		) && (
		echo 删除[public.bak]目录成功...
			(	
			ren public  public.bak	
			) && (
			echo 重命名[public]为[public.bak]成功...
			) || (
			echo 重命名[public]为[public.bak]失败...
			)
		) || (
		echo 删除[public.bak]目录失败...
		)
	) else (
		set  isok=
		echo 未执行任何操作...
		goto HexoServiceManage_public_backup_END
	)		
) else (
	(	
	ren public  public.bak	
	) && (
	echo 重命名[public]为[public.bak]成功...
	) || (
	echo 重命名[public]为[public.bak]失败...
	)
)

:HexoServiceManage_public_backup_END
pause
goto HexoServiceManage
GOTO:EOF


GOTO:EOF
:: Public恢复
:HexoServiceManage_public_recovery
if exist public\ (
	echo [public] 已存在
	echo 将删除现存的[public]目录，是否继续？
	set /p isok=^(Y,是 N,否^)：
	
	if /i "%isok%" == "Y" (
		set  isok=
		(		
		rd /s/q  public
		) && (
		echo 删除[public]目录成功...
			(		
			ren   public.bak  public
			) && (
			echo 重命名[public.bak]为[public]成功...
			) || (
			echo 重命名[public.bak]为[public]失败...
			)
		) || (
		echo 删除[public]目录失败...
		)	
	) else (
		set  isok=
		echo 未执行任何操作...			
		goto HexoServiceManage_public_recovery_END
	)
) else (
	(		
	ren   public.bak  public
	) && (
	echo 重命名[public.bak]为[public]成功...
	) || (
	echo 重命名[public.bak]为[public]失败...
	)
)

:HexoServiceManage_public_recovery_END
pause
goto HexoServiceManage
GOTO:EOF
:: ==========[服务管理]========================================================================= ::





:: ==========[文章管理]========================================================================== ::
GOTO:EOF
:HexoArticleManage
:: cls： 清除屏幕上面的输出
cls

echo.
echo -----------------------------------------------------      
echo   ************ Windows hexo 管理 ************
echo.
echo Hexo ^>^> 文章管理：
echo.
echo     1.新建文章  
echo     2.批量新建文章
echo.
echo     3.上级菜单      
echo     4.退出
echo. 
echo -----------------------------------------------------    
set cho=
set /p cho=请选择：
  
if "%cho%" == "1" goto HexoArticleManage_New
if "%cho%" == "2" goto HexoArticleManage_BatchNew
if "%cho%" == "3" goto hexo
if "%cho%" == "4" goto Texit

:: 意外输入时，跳转回当前菜单
echo 输入有误...
pause
goto HexoArticleManage
GOTO:EOF



GOTO:EOF
:HexoArticleManage_New
:: cls： 清除屏幕上面的输出
cls

echo.
echo -----------------------------------------------------      
echo   ************ Windows hexo 管理 ************
echo.
echo Hexo ^>^> 文章管理 ^>^> 新建文章：
echo.
echo  【语法】
echo title:Title#tags:tag1,tag2,tag3,tag4,tag5#top:1#template:TemplateName#filename:FileName#type:post 
echo.
echo  【解释】
echo title:标题 
echo 	[必需] 文章标题,可用于文件名，不含后缀。 
echo tags:标签1,标签2,标签3,标签4,标签5 
echo 	[可选] 最多5个标签 
echo top:1  
echo 	[可选] 置顶值，范围(0~)，默认1 
echo template:模版名称 
echo 	[可选] 在特定目录才适用  
echo filename:文件名 
echo 	[可选] 指定文件名，不含后缀  
echo type:post 
echo 	[可选] 指定文章类型(post ^| page ^| draft)  
echo.
echo.
echo     3.上级菜单      
echo     4.主菜单      
echo     5.退出
echo. 
echo -----------------------------------------------------    
set cho=
set /p cho=请输入：
  
if "%cho%" == "3" goto HexoArticleManage
if "%cho%" == "4" goto hexo
if "%cho%" == "5" goto Texit

:: EQU - 等于  NEQ - 不等于
if "%cho%" NEQ ""  (
	if %debug%==1 echo call :out_md  1 "%cho%" 
	set is_open=1
	call :out_md  1 "%cho%" 
	pause
	goto HexoArticleManage_New
)

:: 意外输入时，跳转回当前菜单
echo 输入有误...
pause
goto HexoArticleManage_New
GOTO:EOF



GOTO:EOF
:HexoArticleManage_BatchNew
:: cls： 清除屏幕上面的输出
cls

echo.
echo -----------------------------------------------------      
echo   ************ Windows hexo 管理 ************
echo.
echo Hexo ^>^> 文章管理 ^>^> 批量新建文章：
echo.
if not exist write_list.conf (
echo     1.批量配置文件输出
) else (
echo     1.执行批量新建文章
)
echo.
echo     2.上级菜单  
echo     3.主菜单    
echo     4.退出
echo. 
echo -----------------------------------------------------    
set cho=
set /p cho=请选择：

if not exist write_list.conf (	
	if "%cho%" == "1" goto HexoArticleManage_BatchNew_outConf
) else (	
	if "%cho%" == "1" goto HexoArticleManage_BatchNew_out	
)
if "%cho%" == "2" goto HexoArticleManage
if "%cho%" == "3" goto hexo
if "%cho%" == "4" goto Texit

:: 意外输入时，跳转回当前菜单
echo 输入有误...
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
:: ==========[文章管理]========================================================================== ::


:: ***********************************Windows hexo 管理******************************************** ::


GOTO:EOF
:: 自定义退出块
:Texit
if exist %_logdir%\ (
	echo 检测到日志目录，是否删除？
	set /P delok=^(Y,是 N,否^):
	
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
:: 删除日志目录
:DelLogDir
if exist %_logdir%\ (
	(
	rd/s/q %_logdir%\
	) && (
	echo 日志目录删除成功...
	) || (
	echo 日志目录删除失败...
	)
)
GOTO:EOF




:: ==========[Function]================================================================== ::

::::::::调用示例:::::::::::
REM set str1=title:Title1#tags:tag1,tag2,tag3,tag4,tag5#top:1#template:TemplateName#filename:FileName
REM set str2=title:Title2#tags:tag1,tag2,tag3,tag4,tag5#top:1#template:TemplateName#type:page

REM ::call :out_md   2  write_list.conf
REM call :out_md  1 "%str1%" 
REM call :out_md  1 "%str2%" 

GOTO:EOF
:: ================================================== ::
:: 函数名称：out_md									  ::
:: 函数功能：输出md文件								  ::
:: 函数参数：arg1: 模式			 		  	  		  ::
:: 			 	   1，新建文章		  				  ::
:: 			 	   2，批量新建文章	  				  ::
:: 			 arg2: 输入内容 		  	  			  ::
::  		 	   字符串或文件名					  ::
::           							 			  ::
:: 返回值：          							      ::
::    												  ::
:: ================================================== ::
:out_md

:: 模式
set mode=%~1

:: 输入内容
set _in=%~2

:: 处理 新建文章
if "%mode%" == "1" (
	REM 设置变量
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
	REM 解析单行数据
	call :Parser_line  "%_in%"  out_md_cb01
)

:: 处理 批量新建文章
if "%mode%" == "2" (	
	REM 读取并设置变量
	call :Parser_conf  "%_in%"  
	REM 解析文件数据
	call :Parser_file  "%_in%"  out_md_cb01
)
echo.
echo 输出根目录: !OutDir!
echo.
echo 历史记录
echo 文章^(post^)  : !postsNum!
echo 页面^(page^)  : !pagesNum!
echo 草稿^(draft^) : !draftsNum!
echo.
echo 生成数量
echo 文章^(post^)  : !postNum!
echo 	└─ !OutDir!\!postDirName!
echo 页面^(page^)  : !pageNum!
echo 	└─ !OutDir!\!pageDirName!
echo 草稿^(draft^) : !draftNum!
echo 	└─ !OutDir!\!draftDirName!

:: 置空变量
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

:: 配置输出目录
if "%type%" == "post"  set out_dir=!OutDir!\!postDirName!
if "%type%" == "page"  set out_dir=!OutDir!\!pageDirName!
if "%type%" == "draft"  set out_dir=!OutDir!\!draftDirName!
if %debug%==1 echo  out_dir : %out_dir%

:: is_open 全局变量 默认0
:: 调用函数输出内容
call :out_YAML "%out_dir%"  !is_open!  %type%

:: 置空避免后续受影响
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




::::::::调用示例:::::::::::
::GOTO:EOF
:::cb01
::echo --------------------------------------
::echo --[title: %_title%  ]--
::echo --[tag1: %tag1%  ]--
::echo --[top: %top%  ]--
::echo --[filename: %filename%  ]--

::call :out_YAML "" 1

:: 置空避免后续受影响
::set _title=
::set tag1=
::set top=
::set filename=
::echo --------------------------------------
::GOTO:EOF


GOTO:EOF
:: ================================================== ::
:: 函数名称：out_YAML								  ::
:: 函数功能：输出YAML到md文件中						  ::
:: 函数参数：arg1: 文件输出路径			 		  	  ::
::  		 	   K:\c\		 	 		  		  ::
:: 		   [arg2]: 是否打开文件		  	  			  ::
::           	   1，打开；0，不打开(默认)	 		  ::
:: 		   [arg3]: 文章类型	  	  			  		  ::
::           	   post  : 文章	 			  		  ::
::           	   draft : 草稿	 			  		  ::
::           	   page  : 页面	 			  		  ::
:: 返回值：          							      ::
::    %filename% ： 文件名					  		  ::
::        		   	默认： %_title% 或 title	 	  ::
::      %_title% ： 标题				 			  ::
::        		  	默认： title		  			  ::
::         %top% ： 置顶					 		  ::
::        		  	默认：1(filename=index,0)	 	  ::
::    %destfile% ： 目标文件				 		  ::
::        		    c:\doc\FileName.md				  ::
::     %destdir% ： 输出目录						  ::
::        		    c:\doc\			  				  ::
:: %destfiledir% ： 文件同名目录					  ::
::        		    c:\doc\FileName					  ::
::   %_datetime% ： 创建时间						  ::
::        		    2018-12-10 21:43:58				  ::
::    %type% ：     文章类型						  ::
::        		    								  ::
:: ================================================== ::
:out_YAML
:: 闭环 setlocal ... endlocal
setlocal

:: 是否打开文件
if "%~2" == ""  (
	set opfile=0
) else (
	set opfile=%~2
)

:: 标题处理
if "%_title%" == ""  (
	echo title 不能为空...
	pause	
	goto out_YAML_END
)

:: 文章类型(默认：%type%=post)
:: EQU - 等于  NEQ - 不等于
set _type=%~3
if "%_type%" == ""  (
	set _type=%type%
)

:: 文件名处理
if "%filename%" == "" (
	set _filename=%_title%
) else (
	set _filename=%filename%
)

:: 置顶处理
if "%top%" == "" set top=1
if "%_filename%" == "index" set top=0

:: 输出目录
if "%~1" == "" (
	set _destdir=%cd%\
) else (
	set _destdir=%~1
)

:: 目标文件
set _destfile=%_destdir%%_filename%.md

:: 文件同名目录
set _destfiledir=%_destdir%%_filename%

if %debug%==1 echo  _type: %_type%
if %debug%==1 echo  _filename: %_filename%
if %debug%==1 echo  _title: %_title%
if %debug%==1 echo  top: %top%
if %debug%==1 echo  _destfile: %_destfile%
if %debug%==1 echo  _destfiledir: %_destfiledir%
if %debug%==1 echo  _destdir: %_destdir%


if "%_type%" == "page" (
	REM 目标文件
	set _destfile=%_destdir%%_filename%\index.md
	REM 文件同名目录
	set _destfiledir=%_destdir%%_filename%\index
)


:: 创建文件同名目录
if exist "%_destfiledir%" (
	echo 文件同名目录已存在...
	echo [ %_destfiledir% ]
) else (
	(
		mkdir %_destfiledir% 
	) && (
		echo 文件同名目录创建成功... 
		echo [ %_destfiledir% ]
	) || (
		echo 文件同名目录创建失败...
		echo [ %_destfiledir% ]
	)
)

:: 调用时间函数
call :_time  

:: 目标文件存在，则退出
if exist "%_destfile%" (
	echo 目标文件已存在...
	echo [ %_destfile% ]	
	goto out_YAML_END
)

:: EQU - 等于  NEQ - 不等于
:: 输出YAML
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

:: 目标文件创建成功
if exist "%_destfile%" (
	echo 目标文件创建成功...
	echo [ %_destfile% ]	
)

:out_YAML_END
:: EQU - 等于  NEQ - 不等于
if "%_title%" NEQ "" (
	REM 文件打开处理
	if "%opfile%" == "1"  start %_destfile%
)

(
endlocal
REM 输出变量
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





::::::::调用示例:::::::::::
REM call :out_write_list  


GOTO:EOF
:: ================================================== ::
:: 函数名称：out_write_list							  ::
:: 函数功能：批量新建文章配置文件输出		 		  ::
:: 函数参数：arg1:  			 		  	  		  ::
:: 			 arg2: 		 		  	  				  ::
::  		 	   									  ::
::           							 			  ::
:: 返回值：          							      ::
::    												  ::
:: ================================================== ::
:out_write_list
:: 闭环 setlocal ... endlocal
setlocal

:: 输出文件名
set filename=write_list.conf
if exist %filename% (
	echo 文件 [ %filename% ]已存在，覆盖？
	set /P fg=^(Y,是 N,否^):
	if /i "!fg!" == "N" (
		set fg=
		GOTO:EOF
	)
)


:: 输出配置模版
echo # 关联脚本： %This% >%filename%
echo # 【配置信息】>>%filename%
echo # #$开头为变量配置 >>%filename%
echo # [格式] >>%filename%
echo # #$key:value >>%filename%
echo # >>%filename%
echo # OutDir : 输出根目录>>%filename%
echo # 以下路径变量以斜杠结尾>>%filename%
echo # postDirName  : post目录名>>%filename%
echo # pageDirName  : page目录名>>%filename%
echo # draftDirName : draft目录名>>%filename%
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
echo # 【批量新建文章】>>%filename%
echo # >>%filename%
echo # 每行一个配置，输出一个md后缀的文件 >>%filename%
echo # #号开头为注释 >>%filename%
echo # >>%filename% 
echo # [可用的数据格式] >>%filename%
echo # key:value#key:value#key:value#key:value#key:value >>%filename%
echo # >>%filename%
echo # 最多10对key:value  如， >>%filename%
echo # title:Title#tags:tag1,tag2,tag3,tag4,tag5#top:1#template:TemplateName#filename:FileName#type:post >>%filename%
echo # >>%filename% 
echo # [详解] >>%filename%
echo # title:标题 >>%filename%
echo # 			[必需] 文章标题,可用于文件名，不含后缀。获取时的变量名 _title >>%filename%
echo # tags:标签1,标签2,标签3,标签4,标签5 >>%filename%
echo #	   		[可选] 最多5个标签 >>%filename%
echo # top:1  >>%filename%
echo #	  		[可选] 置顶值，范围(0~)，默认1 >>%filename%
echo # template:模版名称 >>%filename%
echo # 		    [可选] 在特定目录才适用  >>%filename%
echo # filename:文件名 >>%filename%
echo # 			[可选] 指定文件名，不含后缀  >>%filename%
echo # type:post >>%filename%
echo # 			[可选] 指定文章类型(post ^| page ^| draft)  >>%filename%
echo # >>%filename%
echo.>>%filename%

echo 批量新建文章的配置文件[%filename%]已生成
echo 请在此文件中配置
(
endlocal
REM 输出变量
)
GOTO:EOF




::::::::调用示例:::::::::::
::call :out_public_git  


GOTO:EOF
:: ================================================== ::
:: 函数名称：out_public_git							  ::
:: 函数功能：public_git	配置文件输出		 		  ::
:: 函数参数：arg1:  			 		  	  		  ::
:: 			 arg2: 		 		  	  				  ::
::  		 	   									  ::
::           							 			  ::
:: 返回值：          							      ::
::    												  ::
:: ================================================== ::
:out_public_git
:: 闭环 setlocal ... endlocal
setlocal

:: 输出文件名
set filename=public_git.conf
if exist %filename% (
	echo 文件 [ %filename% ]已存在，覆盖？
	set /P fg=^(Y,是 N,否^):
	if /i "!fg!" == "N" (
		set fg=
		GOTO:EOF
	)
)

:: 输出配置模版
echo # 关联脚本： %This% >%filename%
echo # 【public部署 配置信息】>>%filename%
echo #  >>%filename%
echo # #号开头为注释>>%filename%
echo # ^=号两边不能空格>>%filename%
echo #  >>%filename%
echo # 详解：>>%filename%
echo # User_Name=用户名>>%filename%
echo # User_Email=邮箱>>%filename%
echo # Fetch_Name=远程仓库短名称>>%filename%
echo #  >>%filename%
echo # remote_name[0]=远程仓库短名称>>%filename%
echo # 			 [0] ：递增数字>>%filename%
echo #  >>%filename%
echo # remote_git[远程仓库短名称]=git地址>>%filename%
echo #  >>%filename%
echo # remote_note[远程仓库短名称]=[可选]备注>>%filename%
echo #  >>%filename%
echo # 示例：>>%filename%
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

echo public目录的git配置文件[%filename%]已生成
echo 请在此文件中配置
(
endlocal
REM 输出变量
)
GOTO:EOF



::::::::调用示例:::::::::::
::call :outBatConf  


GOTO:EOF
:: ================================================== ::
:: 函数名称：outBatConf								  ::
:: 函数功能：本脚本配置文件输出		 				  ::
:: 函数参数：arg1:  			 		  	  		  ::
:: 			 arg2: 		 		  	  				  ::
::  		 	   									  ::
::           							 			  ::
:: 返回值：          							      ::
::    												  ::
:: ================================================== ::
:outBatConf
:: 闭环 setlocal ... endlocal
setlocal

:: 输出文件名
set filename=%This%.conf
if exist %filename% (
	echo 文件 [ %filename% ]已存在，覆盖？
	set /P fg=^(Y,是 N,否^):
	if /i "!fg!" == "N" (
		set fg=
		GOTO:EOF
	)
)

:: 输出配置模版
echo # 关联脚本： %This% >%filename%
echo # 【脚本配置信息】>>%filename%
echo #  >>%filename%
echo # #号开头为注释>>%filename%
echo # ^=号两边不能空格>>%filename%
echo #  >>%filename%
echo # 格式：>>%filename%
echo # key=value>>%filename%
echo #  >>%filename%
echo # 示例：>>%filename%
echo # #文件打开程序^(绝对路径或相对路径^)>>%filename%
echo # exe=xxx.exe>>%filename%
echo # exe=C:\xxx.exe>>%filename%
echo #  >>%filename%
echo exe=D:\EditPlus\editplus.exe>>%filename%
echo.>>%filename%

echo 本脚本配置文件[%filename%]已生成
echo 请在此文件中配置
(
endlocal
REM 输出变量
)
GOTO:EOF





::::::::调用示例:::::::::::
::call :Parser_conf   write_list.conf  
::echo OutDir: %OutDir%
::echo postDirName: %postDirName%
::echo pageDirName: %pageDirName%
::echo draftDirName: %draftDirName%

GOTO:EOF
:: ================================================== ::
:: 函数名称：Parser_conf							  ::
:: 函数功能：解析文件变量配置				 		  ::
:: 函数参数：arg1: 文件			 		  	  		  ::
::  		 	   K:\c\write_list.conf	 	 		  ::
::  		 	   c\write_list.conf	 	 		  ::
::  		 	   write_list.conf		 	 		  ::
::           							 			  ::
:: 返回值：          							      ::
::    												  ::
:: ================================================== ::
:Parser_conf

:: 文件
set _conf_file=%~1
if %debug%==1 echo  _conf_file: %_conf_file%

echo 加载变量配置来自：[ %_conf_file% ]-------------------
:: 解析文件中的变量
for /f "usebackq  tokens=* delims=" %%a in ( "%_conf_file%" ) do (
	if %debug%==1 echo [file_line: %%a ]
	set _str=%%a
	set _kvstr=!_str:~0,2!
	if "!_kvstr!" == "#$" (
		set _confkv=!_str:~2!
		if %debug%==1 echo _confkv: !_confkv!
		for /f "usebackq  tokens=1,* delims=:" %%i in ( '!_confkv!' ) do (
			REM 设置变量
			set "%%i=%%j"
			set %%i
		)
	)
)
echo 加载变量配置来自：[ %_conf_file% ]-------------------
:: 释放变量
set _conf_file=
GOTO:EOF





::::::::调用示例:::::::::::
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

REM :: 置空避免后续受影响
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
:: 函数名称：Parser_file							  ::
:: 函数功能：解析文件特定格式数据			 		  ::
:: 函数参数：arg1: 文件			 		  	  		  ::
::  		 	   K:\c\write_list.conf	 	 		  ::
::  		 	   c\write_list.conf	 	 		  ::
::  		 	   write_list.conf		 	 		  ::
:: 			 arg2: 回调函数		 		  	  		  ::
::  		 	   处理每行数据时的回调函数			  ::
::           							 			  ::
:: 返回值：          							      ::
::    %LineCount% ： 数据行计数				  		  ::
::      %postNum% ： post数量					  	  ::
::      %pageNum% ： page数量				  		  ::
::     %draftNum% ： draft数量				  		  ::
:: ================================================== ::
:Parser_file
:: 闭环 setlocal ... endlocal
setlocal

:: 文件
set _file=%~1
if %debug%==1 echo  _file: %_file%

:: 回调函数
set CallBack=%~2

:: 数据行计数
set _LineCount=0

:: 解析文件数据
for /f "usebackq eol=# tokens=* delims=" %%a in ( "%_file%" ) do (
	if %debug%==1 echo [file_line: %%a ]
	
	REM 调用函数处理每行数据
	call :Parser_line "%%a"  "%CallBack%"
	
	REM 计数+1
	set /A  _LineCount+=1
)

(
endlocal
REM 输出变量
set LineCount=%_LineCount%
set postNum=%postNum%
set pageNum=%pageNum%
set draftNum=%draftNum%
set postsNum=%postsNum%
set pagesNum=%pagesNum%
set draftsNum=%draftsNum%
)
GOTO:EOF






::::::::调用示例:::::::::::
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
:: 函数名称：Parser_line							  ::
:: 函数功能：解析单行数据					 		  ::
:: 函数参数：arg1: 单行数据			 		  	  	  ::
::  		 	   最多10对key:value的数据	 		  ::
::  		 	   key:value#key:value	 	 		  ::
:: 			 arg2: 回调函数		 		  	  		  ::
::  		 	   处理单行数据时的回调函数			  ::
::           							 			  ::
:: 返回值：          							      ::
::    												  ::
:: ================================================== ::
:Parser_line

:: 单行数据
set _line=%~1
if %debug%==1 echo  _line: %_line%

:: 回调函数
set CallBack=%~2


:: 解析单行数据
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
	
	REM EQU - 等于  NEQ - 不等于
	REM 调用函数处理 key:value	
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
	
	REM 统计------------------------------------------------------------	
	REM 配置输出目录
	if "!type!" == "post"  set Parser_line_out_dir=!OutDir!\!postDirName!
	if "!type!" == "page"  set Parser_line_out_dir=!OutDir!\!pageDirName!
	if "!type!" == "draft"  set Parser_line_out_dir=!OutDir!\!draftDirName!
	if %debug%==1 echo  Parser_line_out_dir : !Parser_line_out_dir!

	REM 输出目录
	if "!Parser_line_out_dir!" == "" (
		set Parser_line_destdir=%cd%\
	) else (
		set Parser_line_destdir=!Parser_line_out_dir!
	)
	
	REM 文件名处理
	if "!filename!" == "" (
		set Parser_line_filename=!_title!
	) else (
		set Parser_line_filename=!filename!
	)
	
	REM 目标文件	
	if "!type!" == "page" (
		set Parser_line_destfile=!Parser_line_destdir!!Parser_line_filename!\index.md
	) else (
		set Parser_line_destfile=!Parser_line_destdir!!Parser_line_filename!.md
	)
	
	REM EQU - 等于  NEQ - 不等于
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
	REM 统计------------------------------------------------------------
	
	REM 调用回调函数
	call :%CallBack%	
) 

GOTO:EOF



::::::::调用示例:::::::::::
REM set str1=title:Title1
REM set str2=title2:Title2

REM call :Parser_kv  "%str1%" 
REM call :Parser_kv  "%str2%" 
REM echo --[title: %_title%  ]--
REM echo --[title2: %title2%  ]--


GOTO:EOF
:: ================================================== ::
:: 函数名称：Parser_kv								  ::
:: 函数功能：解析key:value数据					      ::
:: 函数参数：arg1: key:value数据			 		  ::
::           							 			  ::
:: 返回值：          							      ::
::    												  ::
:: ================================================== ::
:Parser_kv

:: key:value 数据
set _kv=%~1
:: title 替换为 _title
set _kv=%_kv:title:=_title:%
if %debug%==1 echo  _kv: %_kv%


:: 解析key:value 数据
for /f "usebackq  tokens=1,* delims=:" %%a in ( '%_kv%' ) do (
	REM EQU - 等于  NEQ - 不等于
	if "%%a" EQU "tags" (
		for /f "usebackq  tokens=1-5 delims= " %%i in ( '%%b' ) do (
			if %debug%==1 echo [_tag1: %%i ]
			if %debug%==1 echo [_tag2: %%j ]
			if %debug%==1 echo [_tag3: %%k ]
			if %debug%==1 echo [_tag4: %%l ]
			if %debug%==1 echo [_tag5: %%m ]
			
			REM 设置变量
			set tag1=%%i
			set tag2=%%j
			set tag3=%%k
			set tag4=%%l
			set tag5=%%m
		)
	) else (
		REM 设置变量
		set %%a=%%b
	)
)
:: type变量处理(默认post)
if "%type%" == "" set  type=post
GOTO:EOF




::::::::调用示例:::::::::::
::call :GitSets public_git.conf  %cd%\re 


GOTO:EOF
:: ================================================== ::
:: 函数名称：GitSets								  ::
:: 函数功能：设置git仓库来自配置文件				  ::
:: 函数参数：arg1: 配置文件		 		  	  	  	  ::
::  		 	   K:\c\public_git.conf	 	 		  ::
::  		 	   c\public_git.conf	 	 		  ::
::  		 	   public_git.conf		 	 		  ::
::  		 	   读取所有配置信息		 	 		  ::
:: 			 arg2: git目录 		  	  		  	  	  ::
:: 		   [arg3]: 变量名前缀	  	  		  	  	  ::
::           	   用于for遍历,默认(remote_name)	  ::
:: 返回值：          							      ::
::    												  ::
:: ================================================== ::
:GitSets
:: 闭环 setlocal ... endlocal
setlocal

:: 日志路径变量
set _logpath=%_logdir%\repo.log
if not exist %_logdir%\  mkdir  %_logdir%

:: 文件
set GitSets_conf_file=%~1

:: 目标目录
set GitSets_DestDir=%~2

:: 变量名前缀
if "%~3" == "" (
	set GitSets_VarPrefix=remote_name
) else (
	set GitSets_VarPrefix=%~3
)

if %debug%==1 echo  GitSets_conf_file: %GitSets_conf_file%
if %debug%==1 echo  GitSets_DestDir: %GitSets_DestDir%
if %debug%==1 echo  GitSets_VarPrefix: %GitSets_VarPrefix%


:: 设置变量
call :Parser_SetVar   %GitSets_conf_file%


:: 远端信息
set remote_info=

:: 遍历并组装远端信息
for /f "usebackq  tokens=* delims=" %%a in ( `set %GitSets_VarPrefix%` ) do (
	REM  [a: aaa1=aaaa ]
	if %debug%==1 echo  [a: %%a ]
	
	for /f "usebackq tokens=1,* delims==" %%i in ('%%a') do (
		REM  [i: aaa1 ] [j: aaaa ]
		if %debug%==1 echo  [i: %%i ] [j: %%j ]
		REM 组装远端信息
		set remote_info=!remote_info!%%j:remote_git[%%j]#
	)
)
:: 去除右边最后一个字符(#)
set "remote_info=%remote_info:~0,-1%"
if %debug%==1  echo  remote_info: "%remote_info%"

:: 调用函数设置git仓库信息
call :GitSet %GitSets_DestDir%   %User_Name%  %User_Email%  "%remote_info%"  "%Fetch_Name%"

(
endlocal
REM 输出变量
)
GOTO:EOF




::::::::调用示例:::::::::::

REM set ShortName1=t1
REM set ShortName2=t2
REM set gitVar1=https://github.com/KumaDocCenter/t1.git
REM set gitVar2=https://github.com/KumaDocCenter/t2.git

REM call :GitSet %cd%\re  kuma8866  kuma8866@163.com  "%ShortName1%:gitVar1#%ShortName2%:gitVar2"



GOTO:EOF
:: ================================================== ::
:: 函数名称：GitSet									  ::
:: 函数功能：设置git仓库					 		  ::
:: 函数参数：arg1:  git目录		 		  	  		  ::
:: 			 arg2: 	用户名 		  	  				  ::
:: 			 arg3: 	邮箱 		  	  				  ::
:: 			 arg4: 	远程仓库信息  	  				  ::
:: 			 		格式 		  	  				  ::
:: 			 		ShortName:gitVar#ShortName:gitVar ::
::  		 	   	最多10对key:value				  ::
::           		ShortName,实际值				  ::
::           		gitVar,变量名					  ::
:: 		   [arg5]: 	远程仓库短名称 	  				  ::
::           		抓取(fetch)此远程仓库git数据库	  ::
::           		需要在arg4中存在的				  ::
::           							 			  ::
:: 返回值：          							      ::
::    												  ::
:: ================================================== ::
:GitSet
:: 闭环 setlocal ... endlocal
setlocal

if "%_logpath%" == "" (
	REM 日志路径变量
	set _logpath=%_logdir%\repo.log
)
if not exist %_logdir%\  mkdir  %_logdir%

:: 目标目录
set DestDir=%~1
:: 用户名
set User_Name=%~2
:: 邮箱
set User_Email=%~3
:: 远程仓库信息
set RepoInfo=%~4
:: fetch名称(ShortName)
set fetch_name=%~5

if "%DestDir%" == "" (
	echo 目标目录不能为空...
	GOTO:EOF
)

:: 跳转到目标目录
cd  %DestDir%

if %debug%==1  echo DestDir: %DestDir%
if %debug%==1  echo User_Name: %User_Name%
if %debug%==1  echo User_Email: %User_Email%
if %debug%==1  echo RepoInfo: %RepoInfo%
if %debug%==1  echo cd: %cd%

echo ------------------------ 仓库配置  ------------------------ 
echo ------------------------ 仓库配置  ------------------------ >%_logpath%

:: 仓库初始化处理
if not exist .git\ (
	REM 不存在.git目录
	if not exist .git (
		REM 不存在.git文件
		(
		echo 仓库初始化...
		echo 仓库初始化...>>%_logpath%
		git init
		) && (
		echo 仓库初始化成功...
		echo 仓库初始化成功...>>%_logpath%
		) || (
		echo 仓库初始化失败...
		echo 仓库初始化失败...>>%_logpath%
		)
	) else (
		REM 存在.git文件
		echo 存在.git文件
		echo 存在.git文件>>%_logpath%
	)
) else (
	echo 存在.git目录
	echo 存在.git目录>>%_logpath%
)


:: EQU - 等于  NEQ - 不等于
if "%User_Name%" NEQ "" (
	(
	echo 配置用户名...
	echo 配置用户名...>>%_logpath%
	git config user.name "%User_Name%"
	) && (
	echo 配置用户名成功...	
	echo 配置用户名成功...>>%_logpath%	
	) || (
	echo 配置用户名失败...
	echo 配置用户名失败...>>%_logpath%
	)
) else (
	echo 用户名为空...
	echo 用户名为空...>>%_logpath% 
)

:: EQU - 等于  NEQ - 不等于
if "%User_Email%" NEQ "" (
	(
	echo 配置邮箱... 
	echo 配置邮箱...>>%_logpath% 
	git config user.email "%User_Email%" 
	) && (
	echo 配置邮箱成功...
	echo 配置邮箱成功...>>%_logpath%	
	) || (
	echo 配置邮箱失败...
	echo 配置邮箱失败...>>%_logpath%
	)
) else (
	echo 邮箱为空...
	echo 邮箱为空...>>%_logpath% 
)

:: EQU - 等于  NEQ - 不等于
if "%RepoInfo%" NEQ "" (
	REM 解析单行数据
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
		
		REM EQU - 等于  NEQ - 不等于
		REM 调用函数处理 key:value	
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
	echo 远程仓库信息 为空...
	echo 远程仓库信息 为空...>>%_logpath% 
)

(
echo 配置提交缓存...
echo 配置提交缓存...>>%_logpath%
git config http.postBuffer  524288000 
) && (
echo 配置提交缓存成功...
echo 配置提交缓存成功...>>%_logpath%	
) || (
echo 配置提交缓存失败...
echo 配置提交缓存失败...>>%_logpath%
)

:: EQU - 等于  NEQ - 不等于
:: 抓取(fetch)远程仓库git数据库
if "%fetch_name%"  NEQ "" (
	(
	echo 抓取^(fetch^)远程仓库[%fetch_name%]git数据...
	echo 抓取^(fetch^)远程仓库[%fetch_name%]git数据...>>%_logpath%
	git fetch -q -f --depth 50 %fetch_name%
	) && (
	echo 抓取^(fetch^)远程仓库[%fetch_name%]git数据成功...
	echo 抓取^(fetch^)远程仓库[%fetch_name%]git数据成功...>>%_logpath%	
	) || (
	echo 抓取^(fetch^)远程仓库[%fetch_name%]git数据失败...
	echo 抓取^(fetch^)远程仓库[%fetch_name%]git数据失败...>>%_logpath%
	)
)

echo ------------------------ 仓库配置  ------------------------ 
echo ------------------------ 仓库配置  ------------------------ >>%_logpath%

(
endlocal
REM 输出变量
)
GOTO:EOF

GOTO:EOF
:: ================================================== ::
:: 函数名称：GitSet_cb01							  ::
:: 函数功能：解析key:value数据并添加远程仓库	      ::
:: 函数参数：arg1: key:value数据			 		  ::
::           							 			  ::
:: 返回值：          							      ::
::    												  ::
:: ================================================== ::
:GitSet_cb01

if "%_logpath%" == "" (
	REM 日志路径变量
	set _logpath=%_logdir%\repo.log
)
if not exist %_logdir%\  mkdir  %_logdir%

:: key:value 数据
set GitSet_cb01_kv=%~1
if %debug%==1 echo  GitSet_cb01_kv: %GitSet_cb01_kv%

REM EQU - 等于  NEQ - 不等于
:: 解析 key:value 数据
for /f "usebackq  tokens=1,* delims=:" %%a in ( '%GitSet_cb01_kv%' ) do (
	REM 设置变量
	set %%a=%%b
	if "%%b"  NEQ "" (
		echo ------------------------------------
		echo ------------------------------------>>%_logpath%
		(
		echo 添加远程仓库信息[ %%a ]...
		echo 添加远程仓库信息[ %%a ]...>>%_logpath%
		git remote remove %%a        2>>%_logpath%
		git remote add %%a   !%%b!	  2>>%_logpath%
		) && (
		echo 添加远程仓库信息[ %%a ]成功...
		echo 添加远程仓库信息[ %%a ]成功...>>%_logpath%
		) || (
		echo 添加远程仓库信息[ %%a ]失败...
		echo 添加远程仓库信息[ %%a ]失败...>>%_logpath%
		)
		echo ------------------------------------
		echo ------------------------------------>>%_logpath%
	)
)
GOTO:EOF




::::::::调用示例:::::::::::
::call :GitDeploys public_git.conf  %cd%\re 


GOTO:EOF
:: ================================================== ::
:: 函数名称：GitDeploys								  ::
:: 函数功能：批量部署(推送)git仓库				 	  ::
:: 函数参数：arg1: 配置文件		 		  	  	  	  ::
::  		 	   K:\c\public_git.conf	 	 		  ::
::  		 	   c\public_git.conf	 	 		  ::
::  		 	   public_git.conf		 	 		  ::
::  		 	   读取远端仓库短名称	 	 		  ::
:: 			 arg2: git目录 		  	  		  	  	  ::
:: 		   [arg3]: 变量名前缀	  	  		  	  	  ::
::           	   用于for遍历,默认(remote_name)	  ::
:: 返回值：          							      ::
::    												  ::
:: ================================================== ::
:GitDeploys
:: 闭环 setlocal ... endlocal
setlocal

:: 日志路径变量
set _logpath=%_logdir%\repo.push.log
if not exist %_logdir%\  mkdir  %_logdir%

:: 文件
set GitDeploys_conf_file=%~1

:: 目标目录
set GitDeploys_DestDir=%~2

:: 变量名前缀
if "%~3" == "" (
	set GitDeploys_VarPrefix=remote_name
) else (
	set GitDeploys_VarPrefix=%~3
)

if %debug%==1 echo  GitDeploys_conf_file: %GitDeploys_conf_file%
if %debug%==1 echo  GitDeploys_DestDir: %GitDeploys_DestDir%
if %debug%==1 echo  GitDeploys_VarPrefix: %GitDeploys_VarPrefix%


:: 设置变量
call :Parser_SetVar   %GitDeploys_conf_file%

:: 仓库推送
echo ------------------------ 仓库推送  ------------------------ 
echo ------------------------ 仓库推送  ------------------------ >%_logpath%

:: 调用时间函数
call :_time  

:: 当前cd
set Tcd=%cd%
:: 跳转到目标目录
cd %GitDeploys_DestDir%

if not exist .git\ (
	if not exist .git (
		echo 目标不是git仓库,请先配置git仓库...
		echo 目标不是git仓库,请先配置git仓库...>>%_logpath%
		GOTO GitDeploys_END
	)
)

if  exist .git (
	echo 添加所有文件...
	echo 添加所有文件...>>%_logpath%
	git add .

	echo git提交...
	echo git提交...>>%_logpath%
	git commit -m "本地自动构建在 %datetime%" 
)

:: 跳转到当前cd
cd %Tcd%


for /f "usebackq  tokens=* delims=" %%a in ( `set %GitDeploys_VarPrefix%` ) do (
	REM  [a: aaa1=aaaa ]
	if %debug%==1 echo  [a: %%a ]
	
	for /f "usebackq tokens=1,* delims==" %%i in ('%%a') do (
		REM  [i: aaa1 ] [j: aaaa ]
		if %debug%==1 echo  [i: %%i ] [j: %%j ]
		REM 调用函数推送单个远端
		call :GitDeploy  "%GitDeploys_DestDir%"  "%%j"
	)
)
:GitDeploys_END
echo ------------------------ 仓库推送  ------------------------ 
echo ------------------------ 仓库推送  ------------------------ >>%_logpath%

(
endlocal
REM 输出变量
)
GOTO:EOF




::::::::调用示例:::::::::::
::call :GitDeploy %cd%\re  t1 


GOTO:EOF
:: ================================================== ::
:: 函数名称：GitDeploy								  ::
:: 函数功能：部署(推送)git仓库				 		  ::
:: 函数参数：arg1:  git目录		 		  	  		  ::
:: 			 arg2: 	远程仓库短名称 		  	  		  ::
:: 		   [arg3]: 	分支		  	  				  ::
:: 			 		待推送分支名称,默认 master	 	  ::
::           							 			  ::
:: 返回值：          							      ::
::    												  ::
:: ================================================== ::
:GitDeploy
:: 闭环 setlocal ... endlocal
setlocal

if "%_logpath%" == "" (
	REM 日志路径变量
	set _logpath=%_logdir%\repo.push.log
)
if not exist %_logdir%\  mkdir  %_logdir%

:: 目标目录
set DestDir=%~1
:: 远程仓库短名称
set ShortName=%~2
:: 分支
if "%~3" == "" (
	set branch=master
) else (
	set branch=%~3
)


if "%DestDir%" == "" (
	echo 目标目录 不能为空...
	echo 目标目录 不能为空...>>%_logpath%
	GOTO:EOF
)
if "%ShortName%" == "" (
	echo 远程仓库短名称 不能为空...
	echo 远程仓库短名称 不能为空...>>%_logpath%
	GOTO:EOF
)

:: 跳转到目标目录
cd  %DestDir%

if not exist .git\ (
	if not exist .git (
		echo 目标不是git仓库...
		echo 目标不是git仓库...>>%_logpath%
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
echo 开始推送[%branch%]分支到[%ShortName%]...
echo 开始推送[%branch%]分支到[%ShortName%]...>>%_logpath%
git push -f -q  %ShortName%  %branch%
) && (
echo 推送[%branch%]分支到[%ShortName%]成功...	
echo 推送[%branch%]分支到[%ShortName%]成功...>>%_logpath%	
) || (
echo 推送[%branch%]分支到[%ShortName%]失败...	
echo 推送[%branch%]分支到[%ShortName%]失败...>>%_logpath%	
)
echo ------------------------------------
echo ------------------------------------>>%_logpath%

(
endlocal
REM 输出变量
)
GOTO:EOF





:: ==========[Function]================================================================== ::

::::::::调用示例:::::::::::
::call :Parser_SetVar   public_git.conf  
::echo User_Name: "%User_Name%"
::set remote


GOTO:EOF
:: ================================================== ::
:: 函数名称：Parser_SetVar							  ::
:: 函数功能：解析并设置变量				 			  ::
:: 函数参数：arg1: 配置文件			 		  	  	  ::
::  		 	   K:\c\public_git.conf	 	 		  ::
::  		 	   c\public_git.conf	 	 		  ::
::  		 	   public_git.conf		 	 		  ::
::           							 			  ::
:: 返回值：          							      ::
::    												  ::
:: ================================================== ::
:Parser_SetVar

:: 文件
set _conf_file=%~1
if %debug%==1 echo  _conf_file: %_conf_file%

echo 加载变量配置来自：[ %_conf_file% ]-------------------
:: 解析文件中的变量
for /f "usebackq eol=# tokens=* delims=" %%a in ( "%_conf_file%" ) do (
	if %debug%==1 echo [file_line: %%a ]
	
	REM 设置变量
	set %%a
	
	REM 显示变量
	for /f "usebackq tokens=1,* delims==" %%i in ( '%%a' ) do (
		set %%i
	)
)
echo 加载变量配置来自：[ %_conf_file% ]-------------------
:: 释放变量
set _conf_file=
GOTO:EOF




::::::::调用示例:::::::::::
REM call :is_DestDir  cd1###cd2  a.txt:dir  1  VarName1  VarName2

::call :is_DestDir  %ThisDir%###%ThisDir%  node_modules:source  1  res  rescd
::echo res: %res%
::echo rescd: %rescd%

GOTO:EOF
:: ================================================== ::
:: 函数名称：is_DestDir							 	  ::
:: 函数功能：是否在正确的目录			 			  ::
:: 函数参数：arg1: cd					 		  	  ::
::  		 	   格式 ： 目标cd###复位cd		 	  ::
::  		 arg2: 条件(文件或目录名，最多2个)		  ::
::  		 	   格式 ： aaa:bbb				 	  ::
::  		 arg3: 是否递归查找			 			  ::
::  		 	   1，是；0，否(默认)				  ::
::  		 arg4: 变量名				 			  ::
::  		 	   存储结果				 			  ::
::  		 arg5: 变量名				 			  ::
::  		 	   存储结果的cd路径		 			  ::
::           							 			  ::
:: 返回值：          							      ::
::    %<arg4>%  ： 结果							      ::
::        		   1，在正确目录		  			  ::
::        		   0，不在正确目录		  			  ::
::    %<arg5>%  ： cd路径						      ::
::        		   E:\...\Script\sh					  ::
:: ================================================== ::
:is_DestDir
:: 闭环 setlocal ... endlocal
setlocal

:: 解析并设置cd
for /f "usebackq tokens=1,2 delims=###" %%a in ( '%~1' ) do (
	set "cd1=%%a"
	set "cd2=%%b"
)

:: 解析并设置条件
for /f "usebackq tokens=1,2 delims=:" %%a in ( '%~2' ) do (
	set condition1=%%a
	set condition2=%%b
)


:: 是否递归查找 
if "%~3" == "" (
	set is_recursion=0
) else (
	set is_recursion=%~3
)

:: 结果变量
set res=0

:: 跳转到指定路径
cd %cd1%


:is_DestDir_Loop
:: 结束判断
if  "%res%" == "1"  (	
	GOTO is_DestDir_END
) 
:: 判断是否存在条件指定的文件或目录
if exist %condition1% (
	if exist %condition2% (
		set res=1
	)
)
:: 结束判断
if  "%is_recursion%" == "0"  (
	GOTO is_DestDir_END
)
:: 跳转到上级目录
cd..
:: 循环
GOTO is_DestDir_Loop


:is_DestDir_END
:: 设置正确结果时的cd
set _cd=!cd!
:: cd复位
cd %cd2%

if %debug%==1 echo res: %res% 
if %debug%==1 echo cd: %_cd% 
(
endlocal
REM 输出变量
set %~4=%res%
set %~5=%_cd%
)
GOTO:EOF






::::::::调用示例:::::::::::
REM call :_time  -

::call :_time  
::echo datetime: %datetime%
::echo timestamp: %timestamp%

GOTO:EOF
:: ================================================== ::
:: 函数名称：_time								 	  ::
:: 函数功能：获取时间相关信息			 			  ::
:: 函数参数：[arg1]: 日期分隔符			 		  	  ::
::  		 	     默认 -						 	  ::
::           							 			  ::
:: 返回值：          							      ::
::    %datetime%  ： 时间							  ::
::        		     2018-12-10 21:43:58  			  ::
::    %timestamp%  ：时间戳						      ::
::        		     20181210214358 			 	  ::
:: ================================================== ::
:_time
:: 闭环 setlocal ... endlocal
setlocal

if %debug%==1 echo ------------------------ 简易日期时间和时间戳  ----------------------

:: 日期分隔符
if "%~1" == "" (
	set delim=-
) else (
	set delim=%~1
)


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

:: 日期时间 戳( 20181210214358 )
set deti=%de%%ti%
:::: 去除所有空格
set timestamp=%deti: =%
if %debug%==1 echo 时间戳："%timestamp%"

if %debug%==1 echo ------------------------ 简易日期时间和时间戳  ----------------------

(
endlocal
REM 输出变量
set datetime=%datetime%
set timestamp=%timestamp%
)
GOTO:EOF



::::::::调用示例:::::::::::
::set "str=echo --aaa--"

::call :Parser_cmd  "%str%" 0  1
::call :Parser_cmd  "%str%" 1


GOTO:EOF
:: ================================================== ::
:: 函数名称：Parser_cmd								  ::
:: 函数功能：命令解析								  ::
:: 函数参数：arg1: 命令字符串	 		  	  		  ::
:: 			 	   "echo aaa"		  				  ::
:: 		   [arg2]: 是否屏蔽命令输出  	  			  ::
::  		 	   1,是								  ::
::  		 	   0,否(默认)						  ::
:: 		   [arg3]: 是否启用新窗口	  	  			  ::
::  		 	   1,是								  ::
::  		 	   0,否(默认)						  ::
::           							 			  ::
:: 返回值：          							      ::
::    												  ::
:: ================================================== ::
:Parser_cmd

:: 命令字符串
set "_cmdstr=%~1"
set "_cmdstr0=%_cmdstr%"
if "%_cmdstr%" == "" (
	echo [%~0]: 输入不能为空
	GOTO:EOF
)
if %debug%==1  echo  _cmdstr: "%_cmdstr%" 

:: 是否屏蔽命令输出
if "%~2" == "" (
	set _nomsg=0
) else (
	set _nomsg=%~2
)
if %debug%==1  echo  _nomsg: "%_nomsg%"

:: 是否启用新窗口
if "%~3" == "" (
	set is_newWindow=0
) else (
	set is_newWindow=%~3
)
if %debug%==1  echo  is_newWindow: "%is_newWindow%"

:: 处理新窗口
if "%is_newWindow%" == "1"  set "_cmdstr=start %_cmdstr%"

:: 执行命令
echo 命令执行中...
(
	if "%_nomsg%" == "0"  %_cmdstr% 
	if "%_nomsg%" == "1"  %_cmdstr% 1>nul 2>nul
) && (
	echo.
	echo [ %_cmdstr0% ]
	echo 命令执行成功...
) || (
	echo.
	echo [ %_cmdstr0% ]
	echo 命令执行失败...
)

:: 释放变量
set _cmdstr=
set _nomsg=
GOTO:EOF


:: ==========[Function]================================================================== ::






