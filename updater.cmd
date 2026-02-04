@echo off & cd /d "%~dp0"
ping ipfs.io -n 1
if %errorlevel% NEQ 0 (
echo I need ipfs.io connectivity to update. Please check your Internet connection.
pause
exit
)
set countfile=0 & for %%f in (*) do set /a countfile+=1
set countfolder=0 & for /D %%a in ("%CD%\*") do set /a countfolder+=1
if %countfile% lss 9 if %countfolder% lss 8 goto Skip
choice /m "There are too many files to update. You don't want to run the updater in a folder with your personal files. Continue update anyway"
if %errorlevel% EQU 2 exit
:Skip
if "%CD:~-1%" == "\" (set "WAY=%CD:~0,-1%") else set "WAY=%CD%"
FOR /F "tokens=2*" %%B IN ('tasklist ^| findstr tor.exe') DO taskkill /PID %%B >nul 2>&1
sc query "Tor Win32 Service" >nul
if %errorlevel% EQU 0 (
call service-manager.cmd
timeout /t 3 /nobreak >nul
)
(
echo @echo off
echo powershell -Command "(New-Object Net.WebClient).DownloadFile('https://ipfs.io/ipns/k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4/AntiTor_win8+_current.zip', '%WAY%\AntiTor_win8+_current.zip')"
echo cscript "%temp%\extractor.vbs"
)>"%temp%\updater.cmd"
(
cmd /u /c echo CreateObject("Shell.Application"^).NameSpace("%CD%"^).CopyHere(CreateObject("Shell.Application"^).NameSpace("%WAY%\AntiTor_win8+_current.zip"^).items^)
cmd /u /c echo CreateObject("WScript.Shell"^).Run "%temp%\cleaner.cmd"
)>"%temp%\extractor.vbs"
(
echo @echo off
echo del "%WAY%\AntiTor_win8+_current.zip"
echo xcopy "%temp%\data" "%CD%\data" /i /e /y
echo rmdir "%temp%\data" /s /q
echo xcopy "%temp%\change-mode\custom" "%CD%\change-mode\custom" /i /e /y
echo findstr /c:"The mode is exit-1" "%CD%\data\torrc.txt"
echo if %%errorlevel%% EQU 0 copy "%CD%\change-mode\exit-1\torrc.txt" "%CD%\torrc.txt"
echo findstr /c:"The mode is exit-2" "%CD%\data\torrc.txt"
echo if %%errorlevel%% EQU 0 copy "%CD%\change-mode\exit-2\torrc.txt" "%CD%\torrc.txt"
echo findstr /c:"#MiddleNodes" "%CD%\data\torrc.txt"
echo if %%errorlevel%% EQU 0 powershell -Command " (gc """%CD%\torrc.txt""") -replace 'MiddleNodes', '#MiddleNodes' | Out-File """%CD%\torrc.txt""" -encoding default
echo del "%CD%\data\torrc.txt"
echo findstr /c:"The mode is custom" "%temp%\change-mode\custom\torrc.txt"
echo if %%errorlevel%% EQU 0 copy "%CD%\change-mode\custom\torrc.txt" "%CD%\torrc.txt"
echo rmdir "%temp%\change-mode" /s /q
echo del "%temp%\updater.cmd"
echo del "%temp%\extractor.vbs"
echo del "%temp%\cleaner.cmd"
)>"%temp%\cleaner.cmd"
findstr /c:"The mode is custom" "%CD%\torrc.txt"
if %errorlevel% EQU 0 copy "%CD%\torrc.txt" "%CD%\change-mode\custom\torrc.txt"
xcopy "%CD%\change-mode\custom" "%temp%\change-mode\custom" /i /e /y
copy "%CD%\torrc.txt" "%CD%\data\torrc.txt"
xcopy "%CD%\data" "%temp%\data" /i /e /y
start "" cmd /c "%temp%\updater.cmd"
rmdir "%CD%" /s /q
