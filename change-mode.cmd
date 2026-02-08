@echo off & cd /d "%~dp0"
setlocal EnableDelayedExpansion
FOR /F "tokens=2*" %%B IN ('tasklist ^| findstr tor.exe') DO taskkill /PID %%B >nul 2>&1
sc query "Tor Win32 Service" >nul
if %errorlevel% EQU 0 (
call service-manager.cmd
timeout /t 3 /nobreak
)
Echo Welcome to the mode control panel.
Echo.
Echo Do you want to set the mode to random-exit (0, default), set the mode to exit-1 (1), set the mode to exit-2 (2), set the mode to custom (3), or remove middle nodes (4, applies to any other mode)?
:Choice
choice /c 01234 /n
if %errorlevel% EQU 1 (
copy "%CD%\change-mode\random-exit\torrc.txt" "%CD%\torrc.txt"
echo The mode was changed to random-exit.
)
if %errorlevel% EQU 2 (
copy "%CD%\change-mode\exit-1\torrc.txt" "%CD%\torrc.txt"
echo The mode was changed to exit-1.
)
if %errorlevel% EQU 3 (
copy "%CD%\change-mode\exit-2\torrc.txt" "%CD%\torrc.txt"
echo The mode was changed to exit-2.
)
if %errorlevel% EQU 4 (
copy "%CD%\change-mode\custom\torrc.txt" "%CD%\torrc.txt"
type nul > "%CD%\change-mode\custom\trace"
echo The mode was changed to custom.
)
if %errorlevel% EQU 5 (
findstr /c:"#MiddleNodes" torrc.txt
if !errorlevel! EQU 0 (
echo Middle nodes are already not in use.
GOTO Choice
)
powershell -Command " (gc """%CD%\torrc.txt""") -replace 'MiddleNodes', '#MiddleNodes' | Out-File """%CD%\torrc.txt""" -encoding default
echo Middle nodes were removed.
)
GOTO Choice
