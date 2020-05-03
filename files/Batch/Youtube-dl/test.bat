@echo on
SETLOCAL EnableDelayedExpansion

echo.
set /p newfolder="Do you want to dowload it in a new folder ? [y/n]  " 
echo.

echo %newfolder%

if "%newfolder%"=="y" (
	set TIMESTAMP=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%-%TIME:~0,2%%TIME:~3,2%
	:: Create a new directory
	mkdir !TIMESTAMP!
	cd !TIMESTAMP!
)

echo %TIMESTAMP%

pause