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

if "%~1"=="" (
	set /p kfi="Keyframe interval in frame (24 for 1s if 24fps): "
) else (
	set kfi=%~2
)

for %%a in (%wd%) do (
	set pathh=%%~dpa
	set filename=%%~nxa
	set filenamenoext=%%~na
	set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  
echo pathh=%pathh%
echo filename=%filename%
echo filenamenoext=%filenamenoext%
echo filepathnoext=%filepathnoext%
echo drive=%drive%
echo wd=%wd%
%drive%
cd %pathh%



rename %wd% %filenamenoext%_temp
ffmpeg -i %filenamenoext%_temp -vcodec libx264 -x264-params keyint=%kfi%:scenecut=0 -acodec copy %wd%
del %filenamenoext%_temp
