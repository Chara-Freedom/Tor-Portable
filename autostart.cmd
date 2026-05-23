@echo off & cd /d "%~dp0"
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\AntiTor.lnk" (
FOR /F "tokens=2*" %%B IN ('tasklist ^| findstr tor.exe') DO taskkill /PID %%B >nul 2>&1
del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\AntiTor.lnk"
echo Windows autostart removed.
pause
exit
)
powershell -Command "$s=(New-Object -ComObject WScript.Shell).CreateShortcut('%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\AntiTor.lnk'); $s.TargetPath='%CD%\AntiTor.exe'; $s.Save()"
start "" "%CD%\AntiTor.exe"
Echo Windows autostart created.
pause
