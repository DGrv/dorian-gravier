@echo off
SetLocal EnableDelayedExpansion

:: Edit the line below to match your path to the ffmpeg executable.

echo Put your video in 1 folder, order with names, put your mp3 inside (not matter the name, also ordered if needed).



:: ---------- Setup ----------


set /p wd="Where are your mp4 ? (E.g. C:\Users\DGrv\Downloads\test)  "
cd %wd%

set /p title="Which title: "
if EXIST music.txt (
	set /p temp="You have a music.txt in your folder. The music clip will be created depending on this one"
) else (
	set /p music="Music: "
)

:: get time_base
echo Time_base of your videos:

for %%i in (*.mp4) DO (
	ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%i
)
set /p tbs="Which tbs (if 1/30000, choose 30000): "
set tbs2=1/%tbs%

echo Time_base of your audios:
for %%i in (*.mp4) DO (
	ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%i
)
set /p tbsa="Which tbs (if 1/48000, choose 48000): "
set tbsa2=1/%tbsa%



:: ---------- Create Title ----------

copy /V C:\Users\DGrv\Downloads\Software\FFmpeg_Dorian\ARIAL.TTF

ffmpeg -f lavfi -i color=c=black:s=2704x1520:d=5 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:text='|%title%|'" -video_track_timescale %tbs% 000.mp4
ffmpeg -i 000.mp4 -f lavfi -i aevalsrc=0 -shortest -y 000b.mp4
ffmpeg -i 000b.mp4 -ar %tbsa% -video_track_timescale %tbs% 000000000_title.mp4
del 000.mp4
del 000b.mp4
::  -f lavfi -i aevalsrc=0 -shortest 
:: Generate the minimum silence required
:: https://superuser.com/questions/1096921/concatenating-videos-with-ffmpeg-produces-silent-video-when-the-first-video-has


if EXIST music.txt (
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
			ffmpeg -f lavfi -i color=c=black:s=2704x1520:d=5 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!hightitle!:text='| Music |'" -video_track_timescale 30000 zzz.mp4
			ffmpeg -i zzz.mp4 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!high!:text='%%A'" -video_track_timescale 30000 zzz!x!.mp4
			del zzz.mp4
		) else (
			ffmpeg -i zzz!before!.mp4 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!high!:text='%%A'" -video_track_timescale 30000 zzz!x!.mp4
			del zzz!before!.mp4
			set last=zzz!x!.mp4
		)
		set /a x=!x!+1
	)
	ffmpeg -i !last! -f lavfi -i aevalsrc=0 -shortest -y zzzb.mp4
	ffmpeg -i zzzb.mp4 -ar 48000 -video_track_timescale 30000 zzz_music.mp4
	del !last!
	del zzzb.mp4
) else (
	ffmpeg -f lavfi -i color=c=black:s=2704x1520:d=5 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:text='Music - %music%'" -video_track_timescale %tbs% zzz.mp4
	ffmpeg -i zzz.mp4 -f lavfi -i aevalsrc=0 -shortest -y zzzb.mp4
	ffmpeg -i zzzb.mp4 -ar %tbsa% -video_track_timescale %tbs% zzz_music.mp4
	del zzz.mp4
	del zzzb.mp4
)

del arial.ttf


:: ---------- Modification ----------


:: change tbs to have all the same - audio tbs
for %%i in (*.mp4) DO (
	ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%i > tempfile
	set /p tbna=<tempfile
	:: check if no audio and add one, needed to bind all audio later, especially with music
	for %%a in (tempfile) do (
		:: check if filesize == 0 
		if %%~za==0 (
			ffmpeg -i %%i -f lavfi -i aevalsrc=0 -shortest -y %%~nio.mp4
			set file=%%~nio.mp4
			del %%i
			ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 !file! > tempfile
			set /p tbna=<tempfile
			del tempfile
		) else (set file=%%i)
	)
	if NOT "!tbna!"=="%tbsa2%" (
		ffmpeg -i !file! -ar %tbsa% !file:~0,-4!o.mp4
		del !file!
	)
)

:: change tbs to have all the same - video tbs
for %%i in (*.mp4) DO (
	ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%i > tempfile
	set /p tbn=<tempfile
	del tempfile
	if NOT "!tbn!"=="%tbs2%" (
		ffmpeg -i %%i -video_track_timescale %tbs% %%~nio.mp4
		:: change to recycle once reboot
		del %%i 		
	)
)



:: ---------- Music ----------


(for %%i in (*.mp3) do @echo file '%%i') > listmp3.txt
ffmpeg -f concat -i listmp3.txt -c copy input.mp3
ffmpeg -i input.mp3 -ar %tbsa% Music_bind.mp3
del input.mp3
del listmp3.txt



:: ---------- Video ----------

:: remove error time
for %%i in (*.mp4) do (
	ffmpeg -err_detect ignore_err -i %%i -c copy %%i.mp4
	del %%i
)


(for %%i in (*.mp4) do @echo file '%%i') > listmp4.txt
ffmpeg -f concat -i listmp4.txt -c copy output.mp4
::del listmp4.txt

if EXIST Music_bind.mp3 (
	:: audio replace
	::ffmpeg -i output.mp4 -i inputfinal.mp3 -c copy -map 0:0 -map 1:0 -shortest output2.mp4
	:: audio mixen
	ffmpeg -i output.mp4 -i Music_bind.mp3 -filter_complex "[0:a][1:a]amerge=inputs=2[a]" -map 0:v -map "[a]" -c:v copy -c:a libvorbis -ac 2 -shortest output_high.mp4
) else (
	copy output.mp4 output_high.mp4
)
del output.mp4
ffmpeg -i output_high.mp4 -vcodec libx264 -vbr 3 -vf "scale=720:-2" -preset slow -crf 18 output_low.mp4
::ffmpeg -i output_low_temp.mp4 -vcodec libx264 -vbr 3 -vf "scale=iw*sar:ih" -preset slow -crf 18 output_low_handy.mp4		
