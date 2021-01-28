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

REM https://142vod-adaptive.akamaized.net/exp=1611691240~acl=%2Ff25405b8-dc57-4d14-a735-a00b56a0a415%2F%2A~hmac=de85fa4e12a707075aab6d32b8df4a25d1621a6f14449d962eed14c33242845d/f25405b8-dc57-4d14-a735-a00b56a0a415/sep/video/e72f8d52/chop/segment-22.m4s
set dirnameV=%url:~0,-14%
set dirnameA=%dirnameV:video~audio%
set dirnameV=%dirnameV:audio~video%

REM https://embedwistia-a.akamaihd.net/deliveries/ac06146f286fcdd47ce9a1b9ed5c83685abc11f6.m3u8/seg-11-v1-a1.ts
REM set dirname=%url:~0,-15%
REM for /F "delims=" %%i in (%url%) do set dirname="%%~dpi"

echo.
echo [INFO] - dirname = %dirname%
echo.

cd C:\Users\doria\Downloads\

mkdir temp_m4s_audio
mkdir temp_m4s_video


:: --------------------- VIDEO ------------------------


cd temp_m4s_video

REM https://www.linuxquestions.org/questions/programming-9/any-ideas-to-pass-the-error-400-bad-request-of-wget-720215/
REM Need to use --user-agent Mozilla/4.0 to avoid ERROR 400: Bad Request.

FOR /L %%p IN (0, 1, 2000) DO (
	set p2=00000%%p
    set p2=!p2:~-5!
	wget --user-agent Mozilla/4.0 "%dirnameV%/segment-%%p.m4s" -O "!p2!.m4s" -o log
	for /f "delims==" %%a in (log) do set lastline=%%a
	if /I "!lastline:ERROR=!" neq "!lastline!" (
		goto :next
	)
	
)

:next
for %%i in (*.m4s) do (
	cat %%i >> all.m4s
)
ffmpeg -i all.m4s -c copy video.mp4
REM DOES not work with m4s : https://stackoverflow.com/questions/52705023/ffmpeg-converting-m4s-to-mp4
REM (for %%i in (*.ts) do @echo file '%%i') > list.txt
REM ffmpeg -f concat -i list.txt -c copy "C:\Users\doria\Downloads\%name%.mp4"


:: --------------------- AUDIO ------------------------

cd temp_m4s_audio

FOR /L %%p IN (0, 1, 2000) DO (
	set p2=00000%%p
    set p2=!p2:~-5!
	wget --user-agent Mozilla/4.0 "%dirnameA%/segment-%%p.m4s" -O "!p2!.m4s" -o log
	for /f "delims==" %%a in (log) do set lastline=%%a
	if /I "!lastline:ERROR=!" neq "!lastline!" (
		goto :next
	)
	
)

:next
for %%i in (*.m4s) do (
	cat %%i >> all.m4s
)
ffmpeg -i all.m4s -acodec copy output.aac

:: --------------------- MERGE ------------------------

cd C:\Users\doria\Downloads\
ffmpeg -stats -loglevel error -i C:\Users\doria\Downloads\temp_m4s_video\video.mp4 -i C:\Users\doria\Downloads\temp_m4s_audio\output.aac -acodec copy -vcodec copy -map 0:v:0 -map 1:a:0 %name%_audio.mp4

echo.
echo [INFO] - 'temp' directory will be remove, quit if you do not want, type enter if ok
REM pause 
::rmdir temp /s /q





