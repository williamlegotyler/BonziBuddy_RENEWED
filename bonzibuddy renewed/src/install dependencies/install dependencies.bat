@echo off

:home
echo Welcome to the bonzibuddy renewed dependencies installation setup!
echo.
echo Select the actions below:
echo.
echo (1) install dependencies 
echo.

set /p option=Enter option number:
if "%option%"=="1" goto 1
if "%option%"=="2" goto 2

:1
cls
".\tv_enua.exe"
pause
exit