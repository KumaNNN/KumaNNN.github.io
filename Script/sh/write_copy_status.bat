:: =================================================================== ::
::  д��״̬���ݵ��ض��ļ�
:: 
:: ���Ŀ¼�� ./Script/sh 
:: ����Ŀ¼�� ./
::
:: [ע��]
:: �����git���ӵ��ô˽ű����乤��Ŀ¼���ǲֿ��Ŀ¼��
:: ���ԣ�����Ҫ cd �ı�Ŀ¼��
::
:: ��git�����п���ͨ�����·�ʽ���˽ű����Ƶ���Ŀ¼ִ��
:: [�����]
:: # ���ƽű�
:: cp ./Script/sh/write_copy_status.bat  ./write_copy_status.bat
:: 
:: # �������
:: echo   >>./write_copy_status.bat
:: echo :: ɾ���ű�����>>./write_copy_status.bat
:: echo "del %0">>./write_copy_status.bat
:: 
:: # ִ�нű�
:: ./write_copy_status.bat  $@
:: [/�����]
:: =================================================================== ::
@echo off

:: �ƶ�����Ŀ¼ 
::cd ..

::����ļ��в����ڣ������ļ���
if not exist ".git/myconf/"  mkdir ".git/myconf"

::д��״̬����
for %%i in ("%~dp0\.") do (
  ::echo ��������ĸ��ļ�����: %%~ni  
  echo status=^1>.git/myconf/copy.conf
  echo dirname=^%%~ni>>.git/myconf/copy.conf
)


