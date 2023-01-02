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
	set /p wd="Give me the path of your file: "
) else (
	set wd=%~1
)

for %%a in (%wd%) do (
	set pathh=%%~dpa
	set filename=%%~nxa
	set filenamenoext=%%~na
	set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  
echo drive=%drive%
echo wd=%wd%
%drive%
cd %wd%

for %%i in (*.mp4) do (

	ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 %%i > tempfile2
	set /p lengthvideo=<tempfile2
	set /a lengthvideo2=!lengthvideo!
	set /a lengthvideo3=!lengthvideo2!-1
	del tempfile2
	
	rename %%i %%~ni_temp

	if 1 LSS !lengthvideo2! (
		ffmpeg -stats -loglevel error -i %%~ni_temp -af "afade=t=in:st=0:d=1,afade=t=out:st=!lengthvideo3!:d=1" -c:v copy %%i
	) else (
		echo [DEBUG] - Your video is too short to have a fade of 1sec
	)
	del %%~ni_temp
)
