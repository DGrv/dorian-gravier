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

echo BECAREFUL !!!!!!
echo if you use parameters in a batch file (pathbat para1 para2) be sure that you have double percentage %% instead of only 1 %.




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
	set /p url="Give me the path of one .m4s segment, you segment should be named like this 'segment-%%p.m4s' :   "
) else (
	set url=%~1
)

if "%~2"=="" (
	set /p aud="Give me the path of the audio without the range (.../audio/a5144baf.mp4?range=96328-188324 --> .../audio/a5144baf.mp4) :   "
) else (
	set aud=%~2
)

if "%~3"=="" (
	set /p name="Which name to give: "
) else (
	set name=%~3
)


set name=%name::=-%
set name=%name:'=%
set name=%name:é=e%
set name=%name:è=e%
set name=%name:à=a%
set name=%name:́ =%
set name=%name:́^=%
set name=%name:?=%
set name=%name:(=%
set name=%name:)=%
set name=%name: =_%
set name=%name: – =___%

echo.

REM https://142vod-adaptive.akamaized.net/exp=1611691240~acl=%2Ff25405b8-dc57-4d14-a735-a00b56a0a415%2F%2A~hmac=de85fa4e12a707075aab6d32b8df4a25d1621a6f14449d962eed14c33242845d/f25405b8-dc57-4d14-a735-a00b56a0a415/sep/video/e72f8d52/chop/segment-22.m4s
set dirnameV=%url:~0,-14%

echo [DEBUG]
echo url: %url%
echo name: %name%
echo url:~0,-14: %url:~0,-14%
echo dirnameV: %dirnameV%
echo.

REM https://embedwistia-a.akamaihd.net/deliveries/ac06146f286fcdd47ce9a1b9ed5c83685abc11f6.m3u8/seg-11-v1-a1.ts
REM set dirname=%url:~0,-15%
REM for /F "delims=" %%i in (%url%) do set dirname="%%~dpi"

echo.
echo.

cd C:\Users\doria\Downloads\

rmdir temp_m4s_video /s /q
mkdir temp_m4s_video


:: --------------------- VIDEO ------------------------


cd temp_m4s_video

REM https://www.linuxquestions.org/questions/programming-9/any-ideas-to-pass-the-error-400-bad-request-of-wget-720215/
REM Need to use --user-agent Mozilla/4.0 to avoid ERROR 400: Bad Request.
REM Need to use NUL to avoid print of SYSTEM_WGETRC = c:/progra~1/wget/etc/wgetrc

REM goto :audio
REM goto :merge


FOR /L %%p IN (0, 1, 2000) DO (
	set p2=00000%%p
    set p2=!p2:~-5!
	echo [DEBUG]
	REM echo url loop: "%dirnameV%/segment-%%p.m4s"
	REM echo output loop: "!p2!.m4s"
	REM wget --no-check-certificate --user-agent Mozilla/4.0 "%dirnameV%/segment-%%p.m4s" -O "!p2!.m4s" -o log
	echo curl "%dirnameV%/segment-%%p.m4s" --output "!p2!.m4s"
	curl "%dirnameV%/segment-%%p.m4s" --output "!p2!.m4s"
	FOR /F %%A IN ("!p2!.m4s") DO set size=%%~zA
	if !size! LSS 200 (
		del "!p2!.m4s"
		goto :next
	) 
	
)




:next
for %%i in (*.m4s) do (
	cat %%i >> video.m4s
)



REM ffmpeg -i all.m4s -c copy video.mp4
REM DOES not work with m4s : https://stackoverflow.com/questions/52705023/ffmpeg-converting-m4s-to-mp4
REM (for %%i in (*.ts) do @echo file '%%i') > list.txt
REM ffmpeg -f concat -i list.txt -c copy "C:\Users\doria\Downloads\%name%.mp4"



:: --------------------- AUDIO ------------------------
:AUDIO

REM wget --no-check-certificate --user-agent Mozilla/4.0 "%aud%" -O "audio.mp3" -o log
echo curl "%aud%" --output "audio.mp3"
curl "%aud%" --output "audio.mp3"

:: --------------------- MERGE ------------------------

:MERGE
cd C:\Users\doria\Downloads\
ffmpeg -stats -loglevel error -i C:\Users\doria\Downloads\temp_m4s_video\video.m4s -i C:\Users\doria\Downloads\temp_m4s_video\audio.mp3 -acodec copy -vcodec copy -map 0:v:0 -map 1:a:0 all.mp4

rename all.mp4 %name%.mp4

echo.
echo [INFO] - 'temp' directory will be remove, quit if you do not want, type enter if ok
REM pause 
::rmdir temp /s /q





