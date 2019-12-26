@echo off
SetLocal EnableDelayedExpansion
echo Created by Dorian Gravier
echo Will create a title clip for your video depending on how many lines you wish.

set /p lines="How many lines do you want: "
set /a lines=%lines%


:: ---------- Title ----------

copy /V C:\Users\gravier\Downloads\GitHub\dorian.gravier.github.io\files\FFmpeg\ARIAL.TTF

if EXIST Title_new.mp4 (
	set /p info=Title_new.mp4 exits !!!! I will delete it. Please rename or copy ...
	del Title_new.mp4
)

FOR /l %%x IN (1, 1, %lines%) DO (
	set /p title%%x="Line %%x which title: "
)

FOR /l %%x IN (1, 1, %lines%) DO (
	set /a before=%%x-1
	set /a high=%lines%+1
	set /a high=!high!/2
	set /a high=%%x-!high!
	set /a high=!high!*75
	::echo high !high!
	if %%x==1 (
		ffmpeg -stats -loglevel error  -f lavfi -i color=c=black:s=2704x1520:d=5 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!high!:text='| !title%%x! |'" -video_track_timescale 30000 0000000%%x.mp4
	) else (
		ffmpeg -stats -loglevel error  -i 0000000!before!.mp4 -vf drawtext="fontfile=arial.ttf:fontsize=50:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!high!:text='!title%%x!'" -video_track_timescale 30000 0000000%%x.mp4
		del 0000000!before!.mp4
		set last=0000000%%x.mp4
	)
)

ffmpeg -stats -loglevel error  -i %last% -f lavfi -i aevalsrc=0 -shortest -y 0000000b.mp4
ffmpeg -stats -loglevel error  -i 0000000b.mp4 -ar 48000 -video_track_timescale 30000 Title_new.mp4
del %last%
del 0000000b.mp4
::  -f lavfi -i aevalsrc=0 -shortest 
:: Generate the minimum silence required
	:: https://superuser.com/questions/1096921/concatenating-videos-with-ffmpeg-produces-silent-video-when-the-first-video-has

