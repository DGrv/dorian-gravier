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
echo.
	

if "%~1"=="" (
	set /p filepath="Give me the path of your file: "
) else (
	set filepath=%~1
)

for /f %%j in ('ffprobe -v error -select_streams v:0 -show_entries stream^=time_base -of default^=noprint_wrappers^=1:nokey^=1 "%filepath%"') do set RVdt=%%j
set RV=%RVdt:1/=%

if "%~2"=="" (
	set /p kfi="Keyframe interval in frame (24 for 1s if 24fps) (if nothing it will be 24) your video is %RVdt%: "
) else (
	set kfi=%~2
)

if "%kfi%"=="" (
	set kfi=24
)


for %%a in ("%filepath%") do (
	set pathh=%%~dpa
	set filename=%%~nxa
	set filenamenoext=%%~na
	set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  

set renamefile=%filenamenoext%_temp%ext%
set renamepathfile=%pathh%%renamefile%


echo [95m[DEBUG] - pathh = %pathh%
echo [DEBUG] - filename = %filename%
echo [DEBUG] - filenamenoext = %filenamenoext%
echo [DEBUG] - filepathnoext = %filepathnoext%
echo [DEBUG] - drive = %drive%
echo [DEBUG] - ext = %ext%
echo. 
echo [DEBUG] - filepath=%filepath%
echo renamefile = %renamefile%
echo renamepathfile = %renamepathfile% [0m
%drive%
cd %pathh%

rename "%filepath%" "%renamefile%"
ffmpeg -stats -loglevel error -i "%renamepathfile%" -vcodec libx264 -x264-params keyint=%kfi%:scenecut=0 -video_track_timescale %RV% -acodec copy "%filepath%"
del "%renamepathfile%"
