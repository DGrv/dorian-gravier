@echo off
setlocal EnableDelayedExpansion

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

echo Will stabilize your video with vidstab (python

echo.
echo Your ffmpeg is here:
WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo [DEBUG] - ffmpeg command is unknown, please add it to the PATH
)
echo.

if "%1"=="" (
	set /p pathfile="Give me the Video path: "
) else (
	set pathfile=%1
) 
 
for %%a in (%pathfile%) do (
	set pathh=%%~dpa
	set filename=%%~nxa
	set filenamenoext=%%~na
	set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  
%drive%
cd "%pathh%"


FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET time=%%A
set TIMESTAMP=%time:~0,8%-%time:~8,6%

set filenamenew=%filenamenoext%_old_%TIMESTAMP%.mp4

echo.
echo.

echo [95m[DEBUG] ---------------------
echo 1 = %1
echo set cd=%cd%
echo set pathfile=%pathfile%
echo set pathh=%pathh%
echo set filename=%filename%
echo set filenamenew=%filenamenew%
echo set rename "%filename%" "%filenamenew%"
echo ----------------------[37m

rename "%filename%" "%filenamenew%"

REM source https://adamspannbauer.github.io/python_video_stab/html/index.html
python3 -m vidstab --input "%filenamenew%" --borderType reflect --output "%filename%"

