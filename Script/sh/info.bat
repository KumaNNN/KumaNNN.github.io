:: ============================================================================= ::
:: �ֿ�������Ϣ
::
:: ���˽ű���ScriptĿ¼һ���Ƶ��Ӳֿ��Ŀ¼��
:: ע�� ͨ��������˽ű�������ϻ�ɾ������
::
:: ���Ŀ¼�� ./Script/sh 
:: ����Ŀ¼�� ./ 
:: 
:: ============================================================================= ::

:: �رջ���
@echo off

:: ����ת���ű�Ŀ¼
cd %~dp0

:: ��ȡĿ¼��  EQU - ����
:: �����ǰ�ű�Ŀ¼��public����Ŀ¼��Ϊ�Զ���
:: �����ǰ�ű�Ŀ¼�ǲ���public����2��cd��Ŀ¼��Ϊcd����
:::: cd��ת����Ŀ¼(��Ϊ��ǰ���Ŀ¼��./Script/sh��������Ҫ����)
for %%a in ("%~dp0\.") do ( 
	if "%%~na" EQU "public" (
		set dirname=KumaNNN.github.io
		set dd=1
	) else (
		cd..
		cd..
		for %%i in ("%cd%\.") do (
		  set dirname=%%~ni
		)
	) 
)
echo Ŀ¼��: %dirname% 


:: ���ø�Ŀ¼·��
set root=%cd%
:: ���õ�ǰ�ű�·��
set thispath=%~dp0


echo ------------------------ �ֿ�����  ------------------------ 


echo �����û���...
git config user.name "kuma8866"

echo ��������... 
git config user.email "kuma8866@163.com" 

echo �����ύ����...
git config http.postBuffer  524288000   

echo ���Զ�ֿ̲�...
git remote add origin https://github.com/KumaDocCenter/%dirname%.git


echo ------------------------ �ֿ�����  ------------------------ 

:: ɾ���ű�����
if "%dd%" EQU "1"  del %0 