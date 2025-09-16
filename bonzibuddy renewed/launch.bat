@echo off

@echo off
setlocal

findstr /i "yes" "firstrun.txt" >nul && goto yes
findstr /i "no" "firstrun.txt" >nul && goto no

:yes

start name.vbs
goto exit

:no
start main.exe

:exit
echo no > firstrun.txt
exit