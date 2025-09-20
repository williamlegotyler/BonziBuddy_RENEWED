@echo off

:home
echo Welcome to the bonzibuddy renewed dependencies installation setup!
echo.
echo Select the actions below:
echo.
echo (1) install dependencies 
echo.
echo (2) uninstall dependencies
echo.
echo DEPENCENCIES THAT THIS WILL INSTALL: "MSagent 2.0" and "Bonzi.acs". (also take note that it will launch an external installer)
echo.

set /p option=Enter option number:
if "%option%"=="1" goto 1
if "%option%"=="2" goto 2

:1
cls
mkdir "%appdata%\bonzibuddy renewed"
echo yes > "%appdata%\bonzibuddy renewed\firstrun.txt"
"C:\Program Files\Bonzibuddy renewed\install dependencies\MSagent.exe"
set /p pause1=When you installed the previous dependency press enter...
copy "C:\Program Files\bonzibuddy renewed\install dependencies\Bonzi.acs" "C:\Windows\msagent\chars\"
pause
exit

:2
del "C:\Windows\msagent\chars\Bonzi.acs"
rd /s /q "%appdata%\bonzibuddy renewed"
echo The setup has been able to remove the "Bonzi.acs" and its "appdata" folder dependencies.
echo all the dependencies have been removed with success.
pause > nul
exit