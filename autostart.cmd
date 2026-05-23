@echo off & cd /d "%~dp0"
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\AntiTor.lnk" (
del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\AntiTor.lnk"
echo Windows autostart removed.
pause
exit
)
powershell -Command "$s=(New-Object -ComObject WScript.Shell).CreateShortcut('%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\AntiTor.lnk'); $s.TargetPath='%CD%\AntiTor.exe'; $s.Save()"
start /min "" "%CD%\AntiTor.exe"
Echo Windows autostart created.
pause
