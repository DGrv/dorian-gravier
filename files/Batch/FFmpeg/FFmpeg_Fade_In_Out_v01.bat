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

	
echo.
echo -------------------------------------------------
echo INFO - Start Fade in and out, need re-encoding
echo.

set /p file="Give me the path of your file: "
set out=%file:.mp4=%
set /p what="Do you want fade in our fade out [in/out]: "
set /p sec="How long should be the fade: "
set /a sec2=%sec%


if !lengthvideo2! lss %sec2% (
	ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 %file% > tempfile2
	set /p lengthvideo=<tempfile2
	set /a lengthvideo2=!lengthvideo!
	set /a lengthvideo3=!lengthvideo2!-%sec2%
	del tempfile2

	if "%what%"=="in" (
		ffmpeg -stats -loglevel error -i %file% -vf "fade=t=in:st=0:d=%sec%" -c:a copy %out%_fade%what%%sec%.mp4
	)
	if "%what%"=="out" (
		ffmpeg -stats -loglevel error -i %file% -vf "fade=t=out:st=!lengthvideo3!:d=%sec%" -c:a copy %out%_fade%what%%sec%.mp4
	)
) else (
	echo [DEBUG] - Your video is too short to have a fade of %sec2%sec
	pause
)
