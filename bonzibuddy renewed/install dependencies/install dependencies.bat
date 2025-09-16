@echo off

echo Welcome to the bonzibuddy renewed dependencies installation setup!
echo.
echo Select the actions below:
echo.
echo (1) install dependencies 
echo.
echo (2) uninstall dependencies
echo.
echo DEPENDENCIES TO INSALL: Bonzi.acs
echo.

set /p option=Enter option number:
if "%option%"=="1" goto 1
if "%option%"=="2" goto 2

:1
IF NOT EXIST "C:\Windows\msagent\chars" (
    mkdir "C:\Windows\msagent\chars"
)
copy "C:\Program Files\bonzibuddy renewed\install dependencies\Bonzi.acs" "C:\Windows\msagent\chars\"
pause
exit

:2
del "C:\Windows\msagent\chars\Bonzi.acs"
pause
exit