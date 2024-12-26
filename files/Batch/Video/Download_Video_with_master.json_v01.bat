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

where youtube-dl
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - youtube-dl, please add it to the PATH
)

WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffmpeg command is unknown, please add it to the PATH
)

if "%~1"=="" (
	set /p name="Which name to give: "
) else (
	set name=%~1
)

if "%~2"=="" (
	set /p url="Give me the path of the master.json :   "
) else (
	set url=%~2
)


echo.
echo.

set name=%name::=-%
set name=%name:'=%
set name=%name: =_%
set name=%name: – =___%
:: remove =1 because not easy to replace equal sign, so hopefully they are at the end
set url2=%url:~0,-2%
:: remove json?base64_init=1 by mpd to get master.mpd
set urlnew=%url2:json?base64_init=mpd%

echo.

echo url: %url%
echo url2: %url2%
echo name: %name%
echo urlnew: %urlnew%
echo.

D:
cd D:\Download_video_script

yt-dlp --write-auto-sub -o %name% %urlnew%






