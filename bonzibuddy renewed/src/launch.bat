@echo off
findstr /i "yes" "%appdata%\bonzibuddy renewed\firstrun.txt" >nul && goto yes
findstr /i "no" "%appdata%\bonzibuddy renewed\firstrun.txt" >nul && goto no

:yes
IF EXIST "C:\Windows\SysWOW64\wscript.exe" (
start "" "C:\Windows\SysWOW64\wscript.exe" introduction.vbs
) ELSE (
start "" introduction.vbs
)
echo no > "%appdata%\bonzibuddy renewed\firstrun.txt"
exit

:no
IF EXIST "C:\Windows\SysWOW64\wscript.exe" (
start "" "C:\Windows\SysWOW64\wscript.exe" main.vbs
) ELSE (
start "" main.vbs
)
exit