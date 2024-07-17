@echo off
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION


REM DOSKEY gpopen=curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=1
REM DOSKEY gpclose=curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=0
REM DOSKEY gpstart=curl --request GET   --url http://172.28.124.51:8080/gopro/camera/shutter/start
REM DOSKEY gpstop=curl --request GET   --url http://172.28.124.51:8080/gopro/camera/shutter/stop
REM DOSKEY gpka=curl --request GET  --url http://172.28.124.51:8080/gopro/camera/keep_alive

curl --request GET   --url http://172.28.124.51:8080/gopro/camera/shutter/stop
curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=0
curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=1
curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=0

REM echo.[92mPress enter to start recording[37m
REM set /p info=""


curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=1
REM curl --request GET  --url http://172.28.124.51:8080/gopro/camera/keep_alive
curl --request GET   --url http://172.28.124.51:8080/gopro/camera/shutter/start

FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO SET time=%%A
set TSd=%time:~0,8%
set TS1=%time:~8,2%-%time:~10,2%-%time:~12,2%


echo.
echo.[92mRecording[37m

:start
echo [94mStarted at %TS1%[37m --- Press Y to stop recording !!!
curl --request GET  --url http://172.28.124.51:8080/gopro/camera/keep_alive
CHOICE /D N /T 3 /N /C YN > nul
IF !ERRORLEVEL!==1 GOTO :END
IF !ERRORLEVEL!==2 goto :start
:END

curl --request GET   --url http://172.28.124.51:8080/gopro/camera/shutter/stop


FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO SET timeb=%%A
set TS2=%timeb:~8,2%-%timeb:~10,2%-%timeb:~12,2%
echo [94mStopped at %TS2%[37m

set /p Continue=Do you want to continue to record ? [Y/N]   


curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=1

REM curl --request GET   --url http://172.28.124.51:8080/gopro/media/list | jq ".media[].fs[].n"
for /f %%p in ('curl --request GET   --url http://172.28.124.51:8080/gopro/media/list ^| jq ".media[].fs[].n" ^| tail -1') do set lastfile=%%p


set nameoutmp4=%TSd%____%TS1%__-__%TS2%____%lastfile%
set nameoutpng=%TSd%__%TS1%_%TS2%.png


REM curl -O --request GET  --url http://172.28.124.51:8080/videos/DCIM/100GOPRO/%lastfile%
curl -o "%nameoutmp4%" --request GET  --url http://172.28.124.51:8080/videos/DCIM/100GOPRO/%lastfile%



for /f %%p in ('curl --request GET   --url http://172.28.124.51:8080/gopro/media/list ^| jq ".media[].fs[].n" ^| tail -3 ^| head -1') do set lastfile3=%%p
curl --request GET --url http://172.28.124.51:8080/gopro/media/delete/file?path=100GOPRO/%lastfile3%


if "%Continue%"=="Y" (
	start Photofinish4.bat
)

ffmpeg -stats -loglevel error -i %nameoutmp4% -vf "crop=2:1080:957:0" -start_number 1 -c:v pam -f image2pipe pipe:1 | magick - -crop 1x+0+0 +append %nameoutpng%

REM qimgv %nameoutpng%

exit 0

REM OLD CODE
REM mkdir temp
REM ffmpeg -stats -loglevel error -i %lastfile% -vf "crop=2:1080:627:0" -c:v libx264 -crf 0 -c:a copy -y output.mp4
REM ffmpeg -i output.mp4 -start_number 1 %cd%\temp\%%09d.png
REM magick convert +append %cd%\temp\*.png out.png
REM del /f /s /q temp 1>nul
REM rmdir /s /q temp



