@echo off & cd /d "%~dp0"
setlocal EnableDelayedExpansion
FOR /F "tokens=2*" %%B IN ('tasklist ^| findstr tor.exe') DO taskkill /PID %%B >nul 2>&1
sc query "Tor Win32 Service" >nul
if %errorlevel% EQU 0 (
call service-manager.cmd
timeout /t 3 /nobreak
)
choice /c 123 /n /m "Welcome to the mode control panel. Do you want to set the mode to pro (1), set the mode to default (2), or remove middle nodes (3)?"
if %errorlevel% EQU 1 (
copy "%CD%\change-mode\pro\torrc.txt" "%CD%\torrc.txt"
echo The mode was changed to pro.
pause
)
if %errorlevel% EQU 2 (
copy "%CD%\change-mode\default\torrc.txt" "%CD%\torrc.txt"
echo The mode was changed to default.
pause
)
if %errorlevel% EQU 3 (
findstr /c:"#MiddleNodes" torrc.txt
if !errorlevel! EQU 0 (
echo Middle nodes are already not in use.
pause
exit
)
powershell -Command " (gc """%CD%\torrc.txt""") -replace 'MiddleNodes', '#MiddleNodes' | Out-File """%CD%\torrc.txt""" -encoding default
echo Middle nodes were removed.
pause
)
