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
"C:\Program Files\Bonzibuddy renewed\install dependencies\spchapi.exe"
pause
exit

:2
del "C:\Windows\msagent\chars\Bonzi.acs"
echo The setup has been able to remove the "Bonzi.acs" and its "appdata" folder dependencies.
echo all the dependencies have been removed with success.
pause > nul
exit