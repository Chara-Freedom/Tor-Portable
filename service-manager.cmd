@echo off & cd /d "%~dp0"
REM :::::::::::::::::::::::::::::::::::::::::
REM Elevate.cmd - Freedom edition
REM Automatically check & get admin rights
REM See "https://stackoverflow.com/a/79585058" for description
REM :::::::::::::::::::::::::::::::::::::::::
 
 ECHO/
 ECHO =============================
 ECHO Running Admin shell
 ECHO =============================
 ECHO/

 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"

:checkPrivileges
  %SystemRoot%\System32\whoami.exe /groups /nh | %SystemRoot%\System32\find.exe "S-1-16-12288" >nul
  if errorlevel 1 goto getPrivileges
  %SystemRoot%\System32\net.exe session >nul 2>&1
  if not errorlevel 1 goto gotPrivileges

:getPrivileges
  ECHO **************************************
  ECHO Invoking UAC for Privilege Escalation
  ECHO **************************************
 
  %SystemRoot%\System32\cmd.exe /u /c ECHO CreateObject("Shell.Application").ShellExecute "%SystemRoot%\System32\cmd.exe", "/c""%~f0""", "", "runas", 1 >"%vbsGetPrivileges%"
  %SystemRoot%\System32\cmd.exe /u /c ECHO CreateObject("Scripting.FileSystemObject").DeleteFile "%vbsGetPrivileges%">>"%vbsGetPrivileges%"

 "%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%"
 exit /B

:gotPrivileges
REM :::::::::::::::::::::::::
REM START
REM :::::::::::::::::::::::::
REM Run shell as admin - put your code below as you like
setlocal EnableDelayedExpansion
for %%I in (VERSION*) do set "UPD=%%~nxI"
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4.ipns.dweb.link/%UPD%', '%temp%\%UPD%')" >nul
if %errorlevel% NEQ 0 (
sc query "Tor Win32 Service" >nul
if !errorlevel! EQU 0 set "CHECK=0" & goto Service
:Loop
choice /c 123 /n /m "The local version does not match the latest version. Do you want to update and start service (1), update without starting service (2), or skip update (3)?"
if !errorlevel! EQU 1 set "UPDATE=0"
if !errorlevel! EQU 3 GOTO Service
echo @echo off>"%temp%\autoupdater.cmd"
echo call "%CD%\updater.cmd">>"%temp%\autoupdater.cmd"
echo cls>>"%temp%\autoupdater.cmd"
echo :Wait>>"%temp%\autoupdater.cmd"
echo if not exist "%CD%\torrc.txt" GOTO Wait>>"%temp%\autoupdater.cmd"
echo timeout /t 1 /nobreak>>"%temp%\autoupdater.cmd"
echo if "!UPDATE!" EQU "0" call "%CD%\%~nx0">>"%temp%\autoupdater.cmd"
echo del "%temp%\autoupdater.cmd">>"%temp%\autoupdater.cmd"
start "" cmd /c "%temp%\autoupdater.cmd"
exit
)
del "%temp%\%UPD%"
:Service
if "%CHECK%" EQU "1" if "!UPDATE!" NEQ "0" exit
if not exist "C:\Windows\System32\acryptprimitives.dll" copy "%CD%\oldwin\acryptprimitives.dll" "C:\Windows\System32\acryptprimitives.dll" >nul 2>&1
FOR /F "tokens=2*" %%B IN ('tasklist ^| findstr tor.exe') DO taskkill /PID %%B >nul 2>&1
sc query "Tor Win32 Service" >nul

if %errorlevel% EQU 0 (
   sc stop "Tor Win32 Service"
   sc delete "Tor Win32 Service"
   powershell -Command "(gc '%CD%\torrc.txt') "^
  "-replace '^DataDirectory.*$', ('DataDirectory ../data') "^
  "-replace '^GeoIPFile.*$', ('GeoIPFile geoip') "^
  "-replace '^GeoIPv6File.*$', ('GeoIPv6File geoip6') "^
  "| Out-File -encoding default '%CD%\torrc.txt'"
) else (
    powershell -Command "(gc '%CD%\torrc.txt') "^
      "-replace '^DataDirectory.*$', ('DataDirectory \"%CD%\data\"' -replace '\\','\\') "^
      "-replace '^GeoIPFile.*$', ('GeoIPFile \"%CD%\tor\geoip\"' -replace '\\','\\') "^
      "-replace '^GeoIPv6File.*$', ('GeoIPv6File \"%CD%\tor\geoip6\"' -replace '\\','\\') "^
      "| Out-File -encoding default '%CD%\torrc.txt'"
    sc create "Tor Win32 Service" binPath= "\"%CD%\tor\tor.exe\" --nt-service -f \"%CD%\torrc.txt\"" start= "auto"
    sc description "Tor Win32 Service" "Provides an anonymous Internet communication system"
    sc start "Tor Win32 Service"
)

Echo/
Echo Please don't close this window, I will finish the work and check version...
timeout /t 3 /nobreak
Echo/

if "%CHECK%" EQU "0" set "CHECK=1" & goto Loop
