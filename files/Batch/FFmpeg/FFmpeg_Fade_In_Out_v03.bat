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

WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffmpeg command is unknown, please add it to the PATH
)
WHERE ffprobe
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffprobe command is unknown, please add it to the PATH
)
	
echo.
echo -------------------------------------------------
echo INFO - Start Fade in and out, need re-encoding
echo.

if "%~1"=="" (
	set /p file="Give me the path of your file or a folder path (will do all): "
) else (
	set file=%~1
)
set out=%file:.mp4=%

if "%~2"=="" (
	set /p what="Do you want fade in our fade out [in/out/both]: "
) else (
	set what=%~2
)

if "%~3"=="" (
	set /p sec="How long should be the fade: "
) else (
	set sec=%~3
)
set /a sec2=%sec%


if "%file:~-3%"=="mp4" GOTO singlefile





cd "%file%"

for %%a in (*.mp4) do (
	ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 %%a> tempfile2
	set /p lengthvideo=<tempfile2
	set /a lengthvideo2=!lengthvideo!
	set /a lengthvideo3=!lengthvideo2!-%sec2%
	::del tempfile2
	echo lengthvideo2=!lengthvideo2!
	echo lengthvideo3=!lengthvideo3!
	

	if %sec2% lss !lengthvideo2! (
		if "%what%"=="in" (
			ffmpeg -stats -loglevel error -i %%a -vf "fade=t=in:st=0:d=%sec%" -c:a copy %%~na_fade%what%%sec%.mp4
		)
		if "%what%"=="out" (
			ffmpeg -stats -loglevel error -i %%a -vf "fade=t=out:st=!lengthvideo3!:d=%sec%" -c:a copy %%~na_fade%what%%sec%.mp4
		)
		if "%what%"=="both" (
			echo ffmpeg -stats -loglevel error -i %%a -vf "fade=t=in:st=0:d=%sec%,fade=t=out:st=!lengthvideo3!:d=%sec%" -c:a copy %%~na_fade%what%%sec%.mp4
			ffmpeg -stats -loglevel error -i %%a -vf "fade=t=in:st=0:d=%sec%,fade=t=out:st=!lengthvideo3!:d=%sec%" -c:a copy %%~na_fade%what%%sec%.mp4
		)
	) else (
		echo [DEBUG] - Your video is too short to have a fade of %sec2%sec
		pause
	)
)







:singlefile

ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 %file% > tempfile2
set /p lengthvideo=<tempfile2
set /a lengthvideo2=%lengthvideo%
set /a lengthvideo3=%lengthvideo2%-%sec2%
del tempfile2

if %sec2% lss %lengthvideo2% (
	if "%what%"=="in" (
		ffmpeg -stats -loglevel error -i %file% -vf "fade=t=in:st=0:d=%sec%" -c:a copy %out%_fade%what%%sec%.mp4
	)
	if "%what%"=="out" (
		ffmpeg -stats -loglevel error -i %file% -vf "fade=t=out:st=!lengthvideo3!:d=%sec%" -c:a copy %out%_fade%what%%sec%.mp4
	)
	if "%what%"=="both" (
		ffmpeg -stats -loglevel error -i %file% -vf "fade=t=in:st=0:d=%sec%,fade=t=out:st=!lengthvideo3!:d=%sec%" -c:a copy %out%_fade%what%%sec%.mp4
	)
) else (
	echo [DEBUG] - Your video is too short to have a fade of %sec2%sec
	pause
)
