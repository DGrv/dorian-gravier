@echo on
SetLocal EnableDelayedExpansion
echo Will create a title clip for your video

set /p lines="How many lines do you want: "
set /a lines=%lines%


:: ---------- Title ----------

FOR /l %%x IN (1, 1, %lines%) DO (
	echo %%x
	set /p title="Line %%x which title: "
	set /a before=%%x-1
	set /a high=%lines%+1
	set /a high=!high!/2
	set /a high=%%x-!high!
	set /a high=!high!*75
	echo high !high!
	if %%x==1 (
		ffmpeg -f lavfi -i color=c=black:s=2704x1520:d=5 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!high!:text='|!title!|'" -video_track_timescale 30000 0000000%%x.mp4
	) else (
		ffmpeg -i 0000000!before!.mp4 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!high!:text='|!title!|'" -video_track_timescale 30000 0000000%%x.mp4
		del 0000000!before!.mp4
		set last=0000000%%x.mp4
	)
)

ffmpeg -i %last% -f lavfi -i aevalsrc=0 -shortest -y 0000000b.mp4
ffmpeg -i 0000000b.mp4 -ar 48000 -video_track_timescale 30000 0000000c.mp4
del %last%
del 0000000b.mp4
::  -f lavfi -i aevalsrc=0 -shortest 
:: Generate the minimum silence required
	:: https://superuser.com/questions/1096921/concatenating-videos-with-ffmpeg-produces-silent-video-when-the-first-video-has

