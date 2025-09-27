@echo off

@echo off
setlocal

findstr /i "yes" "%appdata%\bonzibuddy renewed\firstrun.txt" >nul && goto yes
findstr /i "no" "%appdata%\bonzibuddy renewed\firstrun.txt" >nul && goto no

:yes

start name.vbs
goto exit

:no
start main.exe

:exit
echo no > "%appdata%\bonzibuddy renewed\firstrun.txt"
exit