@echo off 

:: ����caddy
set EXIT_CODE=0

::::::::::::::::::::::::::::::::::::::::::::::
:: @echo off 


:: ����caddy
set EXIT_CODE=0

::C:\Users\Administrator\Desktop\mapletr4j-portable-win64-1.0\lib\mapletr4j-1.0.0.0-client\caddy.exe run --config C:\Users\Administrator\Desktop\mapletr4j-portable-win64-1.0\lib\mapletr4j-1.0.0.0-client\Caddyfile --envfile C:\Users\Administrator\Desktop\mapletr4j-portable-win64-1.0\lib\mapletr4j-1.0.0.0-client\caddyenv --pidfile C:\Users\Administrator\Desktop\mapletr4j-portable-win64-1.0\lib\mapletr4j-1.0.0.0-client\caddy.pid
::::::::::::::::::::::::::::::::::::::::::::::
set DIRNAME=%~dp0
if "%DIRNAME%"=="" set DIRNAME=.

set SCRPIT_BASE_NAME=%~f0

set SCRPIT_HOME=%DIRNAME%
for %%i in ("%SCRPIT_HOME%") do set SCRPIT_HOME=%%~fi

set CADDY_HOME=%SCRPIT_HOME%
set CADDY_EXE=%CADDY_HOME%caddy.exe

"%CADDY_EXE%" version >NUL 2>&1
if %ERRORLEVEL% equ 0 goto validation
echo [����]��ǰ�ű�"%SCRPIT_BASE_NAME%"�ƺ���һ�������λ��
goto fail

:validation
:: a simple validation 
if exist "%CADDY_HOME%\Caddyfile" goto readServerPort
echo [����]"%CADDY_HOME%"�²�����Caddyfile�����ļ�
goto fail

:readServerPort
set port=%1
if not "%port%" == "" goto parsePort
echo [����]��ͨ�������в���ָ����˷���˿�, ����: caddy_start.cmd 2000
goto fail

:parsePort
echo %port%| findstr /r "^[1-9][0-9]*$">nul
if %errorlevel% equ 0 goto start
echo [����]�����в�������[%port%]������һ����ȷ�ķ���˿�
goto fail

:start
set SERVER_HOST=127.0.0.1:%port%
set WEB_ROOT=%CADDY_HOME%

set Caddyfile=%CADDY_HOME%Caddyfile
::set caddyenv=%CADDY_HOME%caddyenv
set pidfile=%CADDY_HOME%caddy.pid

rundll32 url.dll,FileProtocolHandler http://127.0.0.1/caddy.html

cmd /s /c ""%CADDY_EXE%" run --config "%Caddyfile%" --pidfile "%pidfile%"

if %ERRORLEVEL% equ 1 goto fail
goto end

:fail
set EXIT_CODE=%ERRORLEVEL%
echo [����]���������, ����ִ�в���
pause

:end
exit /b %EXIT_CODE%