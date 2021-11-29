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

echo Can also be used with parameter : yourbatchfile.bat url-from-the-video "your title for the video"
echo you can then create a bat or a text file with the list and run it afterwards.
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

if "%~1"=="" (
	set /p url="Give me the path of one .ts segment, you segment should be named like this 'seg-%%p-v1-a1.ts' with %%p from 1 to 9 :   "
) else (
	set url=%~1
)

if "%~2"=="" (
	set /p name="Which name to give: "
) else (
	set name=%~2
)


set name=%name::=-%
set name=%name:'=%
set name=%name: – =___%
set name=%name: =_%
set name=%name:"=%
set name=%name:_[ANMTN]=%
set name=%name:_[VIDEO]=%

REM set st=!name:~0,4!
REM set en1=!name:~3,1!
REM set en2=!name:~4,1!
REM if !en1!==_ (
 REM set name=!name:~0,2!0!name:~2,100!
REM )
REM if !en2!==_ (
 REM set name=!name:~0,3!0!name:~3,100!
REM )

echo.
echo --------- DEBUG ----------
echo name: %name%
echo.
echo.

REM goto end

set dirname=%url:~0,-12%
REM for /F "delims=" %%i in (%url%) do set dirname="%%~dpi"

echo.
echo [INFO] - dirname = %dirname%
echo.

cd C:\Users\doria\Downloads\

set namenewdir=temp_ts
mkdir %namenewdir%
cd %namenewdir%

REM https://www.linuxquestions.org/questions/programming-9/any-ideas-to-pass-the-error-400-bad-request-of-wget-720215/
REM Need to use --user-agent Mozilla/4.0 to avoid ERROR 400: Bad Request.

FOR /L %%p IN (1, 1, 2000) DO (
	set p2=00000%%p
    set p2=!p2:~-5!
	SET id=000%%p
	SET id=!id:~-3!
	echo curl "%dirname%/480p_!id!.ts" --output "!p2!.ts"
	curl "%dirname%/480p_!id!.ts" --output "!p2!.ts"
	FOR /F %%A IN ("!p2!.ts") DO set size=%%~zA
	if !size! LSS 2100 (
		del "!p2!.ts"
		goto :next
	) 
	REM for /f "delims==" %%a in (log) do set lastline=%%a
	REM if /I "!lastline:ERROR=!" neq "!lastline!" (
		REM goto :next
	REM )
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
echo [INFO] - '%namenewdir%' directory will be remove, quit if you do not want, type enter if ok
REM pause 
rmdir %namenewdir% /s /q


:end
quit

