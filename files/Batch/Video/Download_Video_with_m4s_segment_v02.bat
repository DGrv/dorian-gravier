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

if "%~1"=="" (
	set /p url="Give me the path of one .ts segment, you segment should be named like this 'segment-%%p.m4s' :   "
) else (
	set url=%~1
)

if "%~2"=="" (
	set /p name="Which name to give: "
) else (
	set name=%~2
)

echo.
echo.

set name=%name::=-%
set name=%name:'=%
set name=%name: =_%
set name=%name: – =___%
set namefolder=%name%__temp

echo.

REM https://142vod-adaptive.akamaized.net/exp=1611691240~acl=%2Ff25405b8-dc57-4d14-a735-a00b56a0a415%2F%2A~hmac=de85fa4e12a707075aab6d32b8df4a25d1621a6f14449d962eed14c33242845d/f25405b8-dc57-4d14-a735-a00b56a0a415/sep/video/e72f8d52/chop/segment-22.m4s
set dirnameV=%url:~0,-14%
set dirnameA=%dirnameV:video=audio%
set dirnameV=%dirnameV:audio=video%

echo [DEBUG]
echo url: %url%
echo name: %name%
echo namefolder: %namefolder%
echo url:~0,-14: %url:~0,-14%
echo dirnameV: %dirnameV%
echo dirnameA: %dirnameA%
echo.

REM https://embedwistia-a.akamaihd.net/deliveries/ac06146f286fcdd47ce9a1b9ed5c83685abc11f6.m3u8/seg-11-v1-a1.ts
REM set dirname=%url:~0,-15%
REM for /F "delims=" %%i in (%url%) do set dirname="%%~dpi"

echo.
echo [INFO] - dirname = %dirname%
echo.

set out=D:\Download_video_script\

D:
cd %out%

mkdir %namefolder%
cd %namefolder%
mkdir audio
mkdir video


:: --------------------- VIDEO ------------------------

cd %out%%namefolder%
cd video

REM https://www.linuxquestions.org/questions/programming-9/any-ideas-to-pass-the-error-400-bad-request-of-wget-720215/
REM Need to use --user-agent Mozilla/4.0 to avoid ERROR 400: Bad Request.
REM Need to use NUL to avoid print of SYSTEM_WGETRC = c:/progra~1/wget/etc/wgetrc



FOR /L %%p IN (0, 1, 2000) DO (
	set p2=00000%%p
    set p2=!p2:~-5!
	if NOT EXIST "!p2!.m4s" (
		curl "%dirnameV%/segment-%%p.m4s" --output "!p2!.m4s"
		echo.
		echo [DEBUG] - curl "%dirnameV%/segment-%%p.m4s" --output "!p2!.m4s"
		echo curl "%dirnameV%/segment-%%p.m4s" --output "!p2!.m4s" >> logfile_video.txt
		FOR /F %%A IN ("!p2!.m4s") DO set size=%%~zA
		echo.
		echo [DEBUG] - !p2!.m4s size: !size!
		if NOT %%p==0 (
			if !size! LSS 500 (
				echo [DEBUG] - delete !p2!.m4s size: !size!
				echo [DEBUG] - delete !p2!.m4s size: !size! >> logfile_video.txt
				del "!p2!.m4s"
				goto :next
			)
		)	 
		echo.
		echo.
		echo.
		echo ----------------------------------------------------------------------------------------------------------------------
	)
)



:next
del all_video.m4s
del video.mp4
echo.
echo [DEBUG] - Start the merging Video
for %%i in (*.m4s) do (cat %%i>>all_video.m4s)
REM for %i in (*.m4s) do (cat %i>>all_video.m4s)
echo [DEBUG] - Finish the merging Video



echo [DEBUG] - Start convert Video
ffmpeg -i all_video.m4s -c copy video.mp4
echo [DEBUG] - Finish convert Video
REM DOES not work with m4s : https://stackoverflow.com/questions/52705023/ffmpeg-converting-m4s-to-mp4
REM (for %%i in (*.ts) do @echo file '%%i') > list.txt
REM ffmpeg -f concat -i list.txt -c copy "C:\Users\doria\Downloads\%name%.mp4"




: --------------------- AUDIO ------------------------

cd D:\Download_video_script\%namefolder%
cd audio

REM curl "%dirnameA%/segment-0.m4s" --output "0000.m4s"

FOR /L %%p IN (0, 1, 2000) DO (
	set p2=00000%%p
    set p2=!p2:~-5!
	if NOT EXIST "!p2!.m4s" (
		curl "%dirnameA%/segment-%%p.m4s" --output "!p2!.m4s"
		echo.
		echo [DEBUG] - curl "%dirnameV%/segment-%%p.m4s" --output "!p2!.m4s"
		echo curl "%dirnameA%/segment-%%p.m4s" --output "!p2!.m4s" >> logfile_audio.txt
		FOR /F %%A IN ("!p2!.m4s") DO set size=%%~zA
		echo.
		echo [DEBUG] - !p2!.m4s size: !size!
		if NOT %%p==0 (
			if !size! LSS 500 (
				echo [DEBUG] - delete !p2!.m4s size: !size!
				echo [DEBUG] - delete !p2!.m4s size: !size! >> logfile_audio.txt
				del "!p2!.m4s"
				goto :next
			)	
		) 
		echo.
		echo.
		echo.
		echo ----------------------------------------------------------------------------------------------------------------------
	)
)

:next
del all_audio.m4s
del output.aac
echo [DEBUG] - Start the merging Audio
for %%i in (*.m4s) do (cat %%i>>all_audio.m4s)
REM for %i in (*.m4s) do (cat %i>>all_audio.m4s)

echo [DEBUG] - Finish the merging Audio

echo [DEBUG] - Start convert Audio
ffmpeg -i all_audio.m4s -acodec copy output.aac
echo [DEBUG] - Start convert Audio

:: --------------------- MERGE ------------------------

cd %out%
REM ffmpeg -stats -loglevel error -i "C:\Users\doria\Downloads\The_Dodos_Ep_2_Basecamp__temp\video\video.mp4" -i "C:\Users\doria\Downloads\The_Dodos_Ep_2_Basecamp__temp\audio\output.aac" -acodec copy -vcodec copy -map 0:v:0 -map 1:a:0 the-dodos-episode-2.mp4
ffmpeg -stats -loglevel error -i "%out%%namefolder%\video\video.mp4" -i "%out%%namefolder%\audio\output.aac" -acodec copy -vcodec copy -map 0:v:0 -map 1:a:0 %name%.mp4
REM ffmpeg -stats -loglevel error -i "C:\Users\doria\Downloads\%namefolder%\video\video.mp4" -i "C:\Users\doria\Downloads\%namefolder%\audio\output.aac" -acodec copy -vcodec copy -map 0:v:0 -map 1:a:0 %name%.mp4

echo.
echo [INFO] - 'temp' directory will be remove, quit if you do not want, type enter if ok
REM pause 
::rmdir temp /s /q





