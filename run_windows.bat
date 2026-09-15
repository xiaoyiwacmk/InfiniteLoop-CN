@echo off
setlocal EnableExtensions

set "ROOT=%~dp0"
set "PROXY_DIR=%ROOT%Proxy"
set "PROXY_TARGET=http://127.0.0.1:8080"
set "PROXY_URL=http://127.0.0.1:8081"

if not exist "%ROOT%PGR.exe" (
    echo [ERROR] 未找到 "%ROOT%PGR.exe"
    pause
    exit /b 1
)

if not exist "%PROXY_DIR%\mitmdump.exe" (
    echo [ERROR] 未找到 "%PROXY_DIR%\mitmdump.exe"
    pause
    exit /b 1
)

if not exist "%PROXY_DIR%\proxy.py" (
    echo [ERROR] 未找到 "%PROXY_DIR%\proxy.py"
    pause
    exit /b 1
)

set "ASCNET_PROXY_TARGET=%PROXY_TARGET%"
set "HTTP_PROXY=%PROXY_URL%"
set "HTTPS_PROXY=%PROXY_URL%"
set "ALL_PROXY=%PROXY_URL%"
set "http_proxy=%PROXY_URL%"
set "https_proxy=%PROXY_URL%"
set "all_proxy=%PROXY_URL%"
set "NO_PROXY=127.0.0.1,localhost,192.168.100.100"
set "no_proxy=%NO_PROXY%"

start "PGR Local Proxy" /D "%PROXY_DIR%" "%ComSpec%" /k ""%PROXY_DIR%\mitmdump.exe" --listen-host 127.0.0.1 --listen-port 8081 --set confdir="%PROXY_DIR%\proxy_config" -s "%PROXY_DIR%\proxy.py""

timeout /t 2 /nobreak >nul

start "Punishing Gray Raven" /D "%ROOT%" "%ROOT%PGR.exe"
