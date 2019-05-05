@echo off
SetLocal EnableDelayedExpansion
echo Will create a title clip for your video

set /p lines="How many lines for your Music clip (at the end): "
set /a lines=%lines%

copy /V C:\Users\DGrv\Downloads\Software\FFmpeg_Dorian\ARIAL.TTF
if %lines%==1 (
	set /p music="Music: "
	ffmpeg -f lavfi -i color=c=black:s=2704x1520:d=5 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:text='Music - %music%'" -video_track_timescale 30000 zzzzzzz.mp4
	ffmpeg -i zzzzzzz.mp4 -f lavfi -i aevalsrc=0 -shortest -y zzzzzzzb.mp4
	ffmpeg -i zzzzzzzb.mp4 -ar %tbsa% -video_track_timescale %tbs% zzzzzzzc.mp4
	del zzzzzzz.mp4
	del zzzzzzzb.mp4
) else (
	set /p temp="Be sure you have a music.txt files and that you gave the right number of lines"
	set /a x=1
	for /F "usebackq tokens=*" %%A in ("music.txt") do (
		set music=%%a
		set /a before=!x!-1
		set /a high=%lines%+1
		set /a high=!high!/2
		set /a high=!x!-!high!
		set /a high=!high!*75
		if !x!==1 (	
			set /a hightitle=!high!-75
			ffmpeg -f lavfi -i color=c=black:s=2704x1520:d=5 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!hightitle!:text='| Music |'" -video_track_timescale 30000 zzzzzzz.mp4
			ffmpeg -i zzzzzzz.mp4 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!high!:text='%%A'" -video_track_timescale 30000 zzzzzzz!x!.mp4
			del zzzzzzz.mp4
		) else (
			ffmpeg -i zzzzzzz!before!.mp4 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!high!:text='%%A'" -video_track_timescale 30000 zzzzzzz!x!.mp4
			del zzzzzzz!before!.mp4
			set last=zzzzzzz!x!.mp4
		)
		set /a x=!x!+1
	)
	ffmpeg -i %last% -f lavfi -i aevalsrc=0 -shortest -y zzzzzzzb.mp4
	ffmpeg -i zzzzzzzb.mp4 -ar 48000 -video_track_timescale 30000 zzzzzzzc.mp4
	del %last%
	del zzzzzzzb.mp4
)

