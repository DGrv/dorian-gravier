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
echo Youcan also use bold by using markdown syntax (*here will be in bold*).
echo.


if "%1"=="" (
	set /p sec="How many seconds should be the clip: "
) else (
	set sec=%1
)

if "%2"=="" (
	set /p ali="Do you wanna align text in the center [y/n] : "
) else (
	set ali=%2
)

if "%3"=="" (
	set /p lines="How many lines do you want: "
) else (
	set lines=%3
)

REM echo sec %sec%
REM echo ali %ali%
REM echo lines %lines%
set /a lines=%lines%


:: ---------- Title ----------

copy /V C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\FFmpeg\ARIAL.TTF
copy /V C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\FFmpeg\ARIALBD.TTF


if EXIST Title_new.mp4 (
	set /p info=Title_new.mp4 exits !!!! I will delete it. Please rename or copy ...
	del Title_new.mp4
)

if '%4'=='' (
	FOR /l %%x IN (1, 1, %lines%) DO (
		set /p title%%x="Line %%x which title: "
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


FOR /l %%x IN (1, 1, %lines%) DO (
	set /a before=%%x-1
	set /a high=%lines%+1
	set /a high=!high!/2
	set /a high=%%x-!high!
	set /a high=!high!*75
	if %%x==1 (
		if "!title%%x:~0,1!"=="*" (
			ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=2704x1520:d=%sec% -vf drawtext="fontfile=ARIALBD.TTF:fontsize=70:fontcolor=white:x=%xpos%:y=((h-text_h)/2)+!high!:text='!title%%x:~1,-1!'" -video_track_timescale 24000 0000000%%x.mp4
		) else (
			ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=2704x1520:d=%sec% -vf drawtext="fontfile=ARIAL.TTF:fontsize=70:fontcolor=white:x=%xpos%:y=((h-text_h)/2)+!high!:text='!title%%x!'" -video_track_timescale 24000 0000000%%x.mp4
		)
	) else (
		if "!title%%x:~0,1!"=="*" (
			ffmpeg -stats -loglevel error -i 0000000!before!.mp4 -vf drawtext="fontfile=ARIALBD.TTF:fontsize=70:fontcolor=white:x=%xpos%:y=((h-text_h)/2)+!high!:text='!title%%x:~1,-1!'" -video_track_timescale 24000 0000000%%x.mp4
		) else (
			ffmpeg -stats -loglevel error -i 0000000!before!.mp4 -vf drawtext="fontfile=ARIAL.TTF:fontsize=70:fontcolor=white:x=%xpos%:y=((h-text_h)/2)+!high!:text='!title%%x!'" -video_track_timescale 24000 0000000%%x.mp4
		)
		del 0000000!before!.mp4
		set last=0000000%%x.mp4
	)
)


REM ffmpeg -stats -loglevel error  -i %last% -f lavfi -i aevalsrc=0 -shortest -y 0000000b.mp4
REM ffmpeg -stats -loglevel error  -i 0000000b.mp4 -ar 48000 -video_track_timescale 24000 Title_new.mp4

IF %lines%==1 (
	rename 00000001.mp4 Title_new.mp4
	set last=Title_new.mp4
)
:: fade in and out
pause
set /a sec2=1
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 %last% > tempfile2
set /p lengthvideo=<tempfile2
set /a lengthvideo2=%lengthvideo%
set /a lengthvideo3=%lengthvideo2%-%sec2%
del tempfile2
ffmpeg -stats -loglevel error -i %last% -vf "fade=t=in:st=0:d=%sec2%,fade=t=out:st=!lengthvideo3!:d=%sec2%" -c:a copy temp.mp4
del %last%
ffmpeg -stats -loglevel error -i temp.mp4 -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -video_track_timescale 24000 -shortest -y "Title_clip.mp4"
del temp.mp4


if "%CD%" NEQ "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\FFmpeg" (
	del ARIAL.TTF
	del ARIALBD.TTF
)

::  -f lavfi -i aevalsrc=0 -shortest 
:: Generate the minimum silence required
	:: https://superuser.com/questions/1096921/concatenating-videos-with-ffmpeg-produces-silent-video-when-the-first-video-has

