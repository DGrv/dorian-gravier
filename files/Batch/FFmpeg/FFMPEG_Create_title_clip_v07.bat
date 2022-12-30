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
set /a sec+=(fadesec*2)

if "%2"=="" (
	set /p ali="Do you wanna align text in the center [y/n] : "
) else (
	set ali=%2
)

if "%3"=="" (
	set /p fontsize="Give me your fontsize (Try big first, maybe 70, nothing will be 70): "
) else (
	set fontsize=%3
) 
if [%fontsize%]==[] (
	set fontsize=70
)

if "%4"=="" (
	set /p lines="How many lines do you want: "
) else (
	set lines=%4
)

REM echo sec %sec%
REM echo ali %ali%
REM echo lines %lines%
set /a lines=%lines%


:: ---------- Title ----------



if '%4'=='' (
	FOR /l %%x IN (1, 1, %lines%) DO (
		set /p title%%x="Line %%x which title: "
		echo|set /p=!title%%x!>temp%%x.txt
		REM set title%%x=!title%%x::=\\\:!
		REM To be able to print ::
	)
) else (	
	set title1=%4
	set title1=!title1:"=!
)


:: add the option to get them on the right
	:: could use (w-wtext)/2 but the parenthesis makes problem in a batch
if "%ali%" == "y" (
	set xpos=w*0.5-text_w*0.5
) else (
	set xpos=1/10*w
)


set /a W=1920
set /a H=1080
set /a fontsize2=fontsize/5
set /a fontsize3=fontsize2+fontsize
set /a lines2=lines/2
set /a H2=H-fontsize3
set /a H2/=2

echo.
echo.
echo [95m[DEBUG] ---------------------
echo H = %H%
echo H2 = %H2%
echo W = %W%
echo fontsize = %fontsize%
echo fontsize2 = %fontsize2%
echo fontsize3 = %fontsize3%
echo lines = %lines%
echo lines2 = %lines2%
echo ----------------------[0m

FOR /l %%x IN (1, 1, %lines%) DO (
	set /a before=%%x-1
	set /a x2=%%x
	set /a x2-=lines2
	set /a high=H2+fontsize3*x2
	echo [95m[DEBUG] ---------------------
	echo x = %%x
	echo high = !high!
	echo ----------------------[0m
	if %%x==1 (
		ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=%W%x%H%:d=%sec% -vf drawtext="fontfile='Arial':fontsize=%fontsize%:fontcolor=white:x=%xpos%:y=!high!:textfile=temp%%x.txt" -video_track_timescale 24000 0000000%%x.mp4
	) else (
		ffmpeg -stats -loglevel error -i 0000000!before!.mp4 -vf drawtext="fontfile='Arial':fontsize=%fontsize%:fontcolor=white:x=%xpos%:y=!high!:textfile=temp%%x.txt" -video_track_timescale 24000 0000000%%x.mp4
		del 0000000!before!.mp4
		set last=0000000%%x.mp4
	)
	del temp%%x.txt
)



IF %lines%==1 (
	rename 00000001.mp4 Title_new.mp4
	set last=Title_new.mp4
)


:: fade in and out
set /a fadesec=1
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 %last% > tempfile2
set /p lengthvideo=<tempfile2
set /a lengthvideo2=lengthvideo
set /a lengthvideo3=lengthvideo2-fadesec
del tempfile2
ffmpeg -stats -loglevel error -i %last% -vf "fade=t=in:st=0:d=%fadesec%,fade=t=out:st=!lengthvideo3!:d=%fadesec%" -c:a copy temp.mp4
del %last%
ffmpeg -stats -loglevel error -i temp.mp4 -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -video_track_timescale 24000 -shortest -y "Title_clip.mp4"
del temp.mp4



::  -f lavfi -i aevalsrc=0 -shortest 
:: Generate the minimum silence required
	:: https://superuser.com/questions/1096921/concatenating-videos-with-ffmpeg-produces-silent-video-when-the-first-video-has

