@echo off
SetLocal EnableDelayedExpansion


echo "--------------------------------------------------------------------------------"
echo "   _____             _                _____                 _                   "
echo "  |  __ \           (_)              / ____|               (_)                  "
echo "  | |  | | ___  _ __ _  __ _ _ __   | |  __ _ __ __ ___   ___  ___ _ __         "
echo "  | |  | |/ _ \| '__| |/ _` | '_ \  | | |_ | '__/ _` \ \ / / |/ _ \ '__|        "
echo "  | |__| | (_) | |  | | (_| | | | | | |__| | | | (_| |\ V /| |  __/ |           "
echo "  |_____/ \___/|_|  |_|\__,_|_| |_|  \_____|_|  \__,_| \_/ |_|\___|_|           "
echo "                                                                                "
echo "--------------------------------------------------------------------------------"
REM http://www.network-science.de/ascii/
echo.


where wget
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - wget is unknown, please add it to the PATH
)

WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffmpeg command is unknown, please add it to the PATH
)
echo.
echo.

set /p url="Give me the path of one .ts segment, you segment should be named like this 'seg-%%p-v1-a1.ts' with %%p from 1 to 9 :   "
set /p name="Which name to give: "
set name=%name::=-%
set name=%name:'=%

echo.

set dirname=%url:~0,-15%
REM for /F "delims=" %%i in (%url%) do set dirname="%%~dpi"

echo.
echo [INFO] - dirname = %dirname%
echo.

cd C:\Users\doria\Downloads\
mkdir temp
cd temp

REM https://www.linuxquestions.org/questions/programming-9/any-ideas-to-pass-the-error-400-bad-request-of-wget-720215/
REM Need to use --user-agent Mozilla/4.0 to avoid ERROR 400: Bad Request.

FOR /L %%p IN (1, 1, 2000) DO (
	set p2=00000%%p
    set p2=!p2:~-5!
	wget --user-agent Mozilla/4.0 "%dirname%/seg-%%p-v1-a1.ts" -O "!p2!.ts" -o log
	for /f "delims==" %%a in (log) do set lastline=%%a
	if /I "!lastline:ERROR=!" neq "!lastline!" (
		goto :next
	)
	
)

:next
REM :: create timestamp depending on timeformat (language time settings) English will print Mon 09/03/2020 and FR 03/09/2020
REM set /a check=%DATE:~0,1%
REM set check2=%DATE:~0,1%
REM if "%check%"=="%check2%" (
	REM set TIMESTAMP=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%-%TIME:~0,2%%TIME:~3,2%
REM ) else (
	REM set TIMESTAMP=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%-%TIME:~0,2%%TIME:~3,2%
REM )



(for %%i in (*.ts) do @echo file '%%i') > list.txt
ffmpeg -f concat -i list.txt -c copy "C:\Users\doria\Downloads\%name%.mp4"
REM (for %i in (*.ts) do @echo file '%i') > list.txt
REM ffmpeg -f concat -i list.txt -c copy C:\Users\doria\Downloads\new2.mp4

cd C:\Users\doria\Downloads\

echo.
echo [INFO] - 'temp' directory will be remove, quit if you do not want, type enter if ok
REM pause 
::rmdir temp /s /q





