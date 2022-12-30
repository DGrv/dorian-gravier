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
echo Will create a title clip for your video depending on how many lines you wish.
echo you can also use parameters, but just for 1 line. E.g :
echo FFMPEG_Create_title_clip_v05.bat 5 y 1 "Tag 1"
echo.
REM echo Youcan also use bold by using markdown syntax (*here will be in bold*).
echo.


if "%1"=="" (
	set /p sec="How many seconds should be the clip: "
) else (
	set sec=%1
)
set /a fadesec=3
set /a sec=sec
set /a sec=+fadesec


if "%2"=="" (
	set /p ali="Do you wanna align text in the center [y/n] : "
) else (
	set ali=%2
)

if "%3"=="" (
	set /p fontsize="Give me your fontsize (Try big first, maybe 50, nothing will be 50): "
) else (
	set fontsize=%3
) 
if [%fontsize%]==[] (
	set fontsize=70
)

if "%~4"=="" (
	echo [91m
	set /p text=Give me you text: You can use \n in your string to create new line !!!! :[0m 
	echo [0m
) else (
	set text=%~4
) 


:: ---------- Title ----------



set /a check=%DATE:~0,1%
set check2=%DATE:~0,1%
if "%check%"=="%check2%" (
	set TIMESTAMP=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%-%TIME:~0,2%%TIME:~3,2%
) else (
	set TIMESTAMP=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%-%TIME:~0,2%%TIME:~3,2%
)

set filename=Title_clip
if EXIST %filename%.mp4 (
	set filename=%filename%_%TIMESTAMP%.mp4
) else (
	set filename=%filename%.mp4
)


set RV=24000
set RA=48000

:: add the option to get them on the right
	:: could use (w-wtext)/2 but the parenthesis makes problem in a batch
if "%ali%" == "y" (
	set xpos=w*0.5-text_w*0.5
) else (
	set xpos=1/10*w
)

set "text=%text:(=^(%"
set "text=%text:)=^)%"
set "text=%text:\n\n= >> temp.txt & echo. >> temp.txt & echo %"
set "text=%text:\n= >> temp.txt & echo %"
set "text=%text:"=%"
if exist "temp.txt" rm temp.txt
echo %text% >> temp.txt
truncate -s -2 temp.txt


echo ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=1920x1080:d=%sec% -vf drawtext="fontfile='Arial': fontsize=%fontsize%: fontcolor=white: x=%xpos%: y=((h-text_h)/2): textfile=temp.txt" -video_track_timescale %RV% -y temp1.mp4
ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=1920x1080:d=%sec% -vf drawtext="fontfile='Arial': fontsize=%fontsize%: fontcolor=white: x=%xpos%: y=((h-text_h)/2): textfile=temp.txt" -video_track_timescale %RV% -y temp1.mp4

:: fade in and out
set /a fadesec=3
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 temp1.mp4 > tempfile
set /p lengthvideo=<tempfile
del tempfile
set /a lengthvideo2=lengthvideo
set /a lengthvideo3=lengthvideo2-fadesec
ffmpeg -stats -loglevel error -i temp1.mp4 -vf "fade=t=in:st=0:d=%fadesec%,fade=t=out:st=!lengthvideo3!:d=%fadesec%" -c:a copy -y temp2.mp4
ffmpeg -stats -loglevel error -i temp2.mp4 -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=%RA% -video_track_timescale %RV% -shortest -y %filename%
del temp1.mp4 temp2.mp4 temp.txt


::  -f lavfi -i aevalsrc=0 -shortest 
:: Generate the minimum silence required
	:: https://superuser.com/questions/1096921/concatenating-videos-with-ffmpeg-produces-silent-video-when-the-first-video-has

