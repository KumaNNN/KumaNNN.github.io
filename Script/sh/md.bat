:: =================================================================== ::
::  ����source/* md�ļ�
:: ����һЩYAML����
:: 
:: ���Ŀ¼�� ./Script/sh 
:: ����Ŀ¼�� ./
::
:: =================================================================== ::
:: �رջ���
@echo off
:: ���Կ���
set debug=1
:: ���������ӳ�
setlocal EnableDelayedExpansion
:: ��ǰ�ļ���
set this=%0

:: cd��ת����Ŀ¼
cd %~dp0
cd..
cd..

:: ���ø�Ŀ¼·��
set root=%cd%

REM Ŀ������򱸷�
if exist public (
	if exist public.bak (
		REM ɾ��Ŀ¼
		rd /S/Q public
	) else (
		REM ������Ŀ¼
		ren public  public.bak
	)
)

(
	REM hexo ���
	hexo clean
	REM hexo ����
	hexo g
) && (
	echo cd: %cd%
	REM ɾ��Ŀ¼
	rd /S/Q %cd%\public
	REM �ָ�Ŀ¼ 
	ren  %cd%\public.bak  public
)

exit



