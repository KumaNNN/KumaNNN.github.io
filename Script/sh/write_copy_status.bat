:: =================================================================== ::
::  写入状态数据到特定文件
:: 
:: 存放目录： ./Script/sh 
:: 运行目录： ./
::
:: [注意]
:: 如果是git钩子调用此脚本，其工作目录还是仓库根目录，
:: 所以，不需要 cd 改变目录。
::
:: 在git钩子中可以通过如下方式将此脚本复制到根目录执行
:: [代码块]
:: # 复制脚本
:: cp ./Script/sh/write_copy_status.bat  ./write_copy_status.bat
:: 
:: # 添加内容
:: echo   >>./write_copy_status.bat
:: echo :: 删除脚本自身>>./write_copy_status.bat
:: echo "del %0">>./write_copy_status.bat
:: 
:: # 执行脚本
:: ./write_copy_status.bat  $@
:: [/代码块]
:: =================================================================== ::
@echo off

:: 移动到根目录 
::cd ..

::如果文件夹不存在，创建文件夹
if not exist ".git/myconf/"  mkdir ".git/myconf"

::写入状态数据
for %%i in ("%~dp0\.") do (
  ::echo 该批处理的父文件夹是: %%~ni  
  echo status=^1>.git/myconf/copy.conf
  echo dirname=^%%~ni>>.git/myconf/copy.conf
)


