@echo off
SetLocal EnableDelayedExpansion


:: Edit the line below to match your path to the ffmpeg executable.

echo Put your video in 1 folder, order with names, put your mp3 inside (not matter the name, also ordered if needed).



:: ---------- Setup ----------

	if EXIST music.txt (
		del music.txt
	)
	if EXIST output_720_crf25_temp.mp4 (
		del output_720_crf25_temp.mp4
	)
	if EXIST output_720_crf25.mp4 (
		del output_720_crf25.mp4
	)
	if EXIST output_high.mp4 (
		del output_high.mp4
	)




	set /p wd="Where are your mp4 ? (E.g. C:\Users\DGrv\Downloads\test)  "
	for %%a in (%wd%) do (
		set pathh=%%~dpa
		set filename=%%~nxa
		set filenamenoext=%%~na
		set filepathnoext=%%~dpna
		set ext=%%~xa
		set drive=%%~da
	)  
	%drive%
	cd %wd%


	set /p title="Which title: "
	set title2=%title: =_%
	set title2=%title2:-=%
	set title2=%title2:__=_%
	

	:: Music
	set /p temp="[INFO] - Rename correctlty your mp3, the music title at the end will be written based on your filenames"
	for %%i in (*.mp3) do (
		if NOT %%~ni==input (
			@echo %%~ni >> music.txt
		)
	)
	echo.
	
	set /p tbdefault=Do you wanna use simple configuration for fps (24) and audio frequence (48Hz) [y/n] ? :
	
	if %tbdefault%==y (
		set tbs=24000
		set tbs2=1/!tbs!
		set tbsa=48000
		set tbsa2=1/!tbsa!
	) else (
		set /p tb=Do you wanna see the time base of your video/audio to be able to have a feeling and select only one or just select one [y/n] ? : 
		:: get time_base
		echo Time_base of your videos:
		:: if the variable tb is set in a if else you have to use 'if !tb!==y' if it is outside you can use 'if %tb%==y'
		if !tb!==y (
			for %%i in (*.mp4) DO (
				ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%i
			)
		) else (
			echo here the first mp4 to give you a hint
			(for %%i in (*.mp4) do @echo %%i) > listmp4.txt
			set /p firstmp4=<listmp4.txt
			ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 !firstmp4!
		)
		set /p tbs="Which tbs (if 1/30000, choose 30000): "
		set tbs2=1/%tbs%
		
		echo Time_base of your audios:
		if !tb!==y (
			for %%i in (*.mp4) DO (
				ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%i
			)
		) else (
			ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 !firstmp4!
			del listmp4.txt
		)
		set /p tbsa="Which tbs (if 1/48000, choose 48000): "
		set tbsa2=1/%tbsa%
	)

	echo.
	echo -------------------------------------------------
	echo INFO - Start
	echo.
	

:: ---------- Music ----------

	echo.
	echo -------------------------------------------------
	echo INFO - Start Music
	echo.
	
	
	if NOT EXIST input.mp3 (
		(for %%i in (*.mp3) do @echo file '%%i') > listmp3.txt
		ffmpeg -stats -loglevel error -safe 0 -f concat -i listmp3.txt -c copy input_temp.mp3
		ffmpeg -stats -loglevel error -i input_temp.mp3 -ar %tbsa% input.mp3
		del input_temp.mp3
		del listmp3.txt
	)

	
	:: use - safe 0 before i to avoid problem with filename : https://stackoverflow.com/questions/38996925/ffmpeg-concat-unsafe-file-name
	


:: ---------- Create Title ----------

	
	echo.
	echo -------------------------------------------------
	echo INFO - Start title
	echo.

	copy /V C:\Users\gravier\Downloads\GitHub\dorian.gravier.github.io\files\FFmpeg\ARIAL.TTF
	
	
	if NOT EXIST 00000_title.mp4 (
		ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=2704x1520:d=5 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:text='| %title% |'" -video_track_timescale %tbs% 000_temp.mp4
		:: add audio
		ffmpeg -stats -loglevel error -i 000_temp.mp4 -f lavfi -i aevalsrc=0 -shortest -y 000_temp2.mp4
		del 000_temp.mp4
		:: change parameters audio
		ffmpeg -stats -loglevel error -i 000_temp2.mp4 -ar %tbsa% -video_track_timescale %tbs% 00000_title.mp4
		del 000_temp2.mp4
	)
	::  -f lavfi -i aevalsrc=0 -shortest 
	:: Generate the minimum silence required
	:: https://superuser.com/questions/1096921/concatenating-videos-with-ffmpeg-produces-silent-video-when-the-first-video-has
	
	
	echo.
	echo -------------------------------------------------
	echo INFO - Start music title
	echo.
	

	if NOT EXIST zzzzzz_music.mp4 (
		set /a x=1
		set /a lines=0
		for /f %%a in ('type "music.txt"^|find "" /v /c') do set /a lines=%%a
		for /F "usebackq tokens=*" %%a in ("music.txt") do (
			set music=%%a
			set /a before=!x!-1
			set /a high=!lines!+1
			set /a high=!high!/2
			set /a high=!x!-!high!
			set /a high=!high!*75
			if !x!==1 (	
				set /a hightitle=!high!-150
				ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=2704x1520:d=5 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!hightitle!:text='| Music |'" -video_track_timescale %tbs% zzz.mp4
				ffmpeg -stats -loglevel error -i zzz.mp4 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!high!:text='%%a'" -video_track_timescale %tbs% zzz!x!.mp4
				del zzz.mp4
			) else (
				ffmpeg -stats -loglevel error -i zzz!before!.mp4 -vf drawtext="fontfile=arial.ttf:fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!high!:text='%%a'" -video_track_timescale %tbs% zzz!x!.mp4
				del zzz!before!.mp4
			)
			set last=zzz!x!.mp4
			set /a x=!x!+1
		)
		ffmpeg -stats -loglevel error -i !last! -f lavfi -i aevalsrc=0 -shortest -y zzzb.mp4
		ffmpeg -stats -loglevel error -i zzzb.mp4 -ar %tbsa% -video_track_timescale %tbs% zzzzzz_music.mp4
		del !last!
		del zzzb.mp4
	)

	del arial.ttf




:: ---------- Modification ----------

	echo.
	echo -------------------------------------------------
	echo INFO - Start tbs
	echo.



	:: change tbs to have all the same - audio tbs
	for %%i in (*.mp4) DO (
		ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%i > tempfile
		set /p tbna=<tempfile
		:: check if no audio and add one, needed to bind all audio later, especially with music
		for %%a in (tempfile) do (
			:: check if filesize == 0 
			if %%~za==0 (
				rename %%i %%~ni_temp.mp4
				ffmpeg -stats -loglevel error -i %%~ni_temp.mp4 -f lavfi -i aevalsrc=0 -shortest -y %%i
				del %%~ni_temp.mp4
				ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%i > tempfile
				set /p tbna=<tempfile
				del tempfile
			) 
		)
		if NOT "!tbna!"=="%tbsa2%" (
			rename %%i %%~ni_temp.mp4
			ffmpeg -stats -loglevel error -i %%~ni_temp.mp4 -ar %tbsa% %%i
			del %%~ni_temp.mp4
		)
	)
	
	echo.
	echo -------------------------------------------------
	echo INFO - Start tbsa
	echo.

	:: change tbs to have all the same - video tbs
	for %%i in (*.mp4) DO (
		ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%i > tempfile
		set /p tbn=<tempfile
		del tempfile
		if NOT "!tbn!"=="%tbs2%" (
			rename %%i %%~ni_temp.mp4
			ffmpeg -stats -loglevel error -i %%~ni_temp.mp4 -video_track_timescale %tbs% %%i
			:: change to recycle once reboot
			del %%~ni_temp.mp4
		)
	)






:: ---------- End ----------

	REM echo.
	REM echo -------------------------------------------------
	REM echo INFO - Start error times
	REM echo.

	REM :: remove error time
	REM :: remove duplicated frames (losslesscut error sometimes or with increase speed)
	REM for %%i in (*.mp4) do (
		REM rename %%i %%~ni_temp.mp4
		REM ffmpeg -stats -loglevel error -err_detect ignore_err -i %%~ni_temp.mp4 -c copy %%i
		REM del %%~ni_temp.mp4
	REM )
	

	echo.
	echo -------------------------------------------------
	echo INFO - Start bind
	echo.

	(for %%i in (*.mp4) do @echo file '%%i') > listmp4.txt
	ffmpeg -stats -loglevel error -f concat -i listmp4.txt -c copy output.mp4
	::del listmp4.txt
	
	echo.
	echo -------------------------------------------------
	echo INFO - Start bind music
	echo.

	:: audio replace
	::ffmpeg -stats -loglevel error -i output.mp4 -i inputfinal.mp3 -c copy -map 0:0 -map 1:0 -shortest output2.mp4
	:: audio mixen
	if EXIST input.mp3 (
		::ffmpeg -stats -loglevel error -i output.mp4 -i input.mp3 -filter_complex "[0:a]volume=2[a1];[1:a]volume=0.5[a2];[a1][a2]amerge=inputs=2[a]" -map 0:v -map "[a]" -c:v copy -c:a libvorbis -ac 2 -shortest output_high.mp4 :: 20191224 was not working on the samsung TV because of the vorbis codec
		ffmpeg -stats -loglevel error -i output.mp4 -i input.mp3 -filter_complex "[0:a]volume=2[a1];[1:a]volume=0.5[a2];[a1][a2]amerge=inputs=2[a]" -map 0:v -map "[a]" -c:v copy -ac 2 -shortest output_high.mp4
	) else (
		rename output.mp4 output_high.mp4
	)
	del output.mp4
	
	echo.
	echo -------------------------------------------------
	echo INFO - Start convert low
	echo.
	
	ffmpeg -stats -loglevel error -i output_high.mp4 -vcodec libx264 -vbr 3 -vf "scale=1920:-2" -preset slow -crf 25 output_1920_crf25_temp.mp4
	ffmpeg -stats -loglevel error -i output_high.mp4 -vcodec libx264 -vbr 3 -vf "scale=720:-2" -preset slow -crf 25 output_720_crf25_temp.mp4
	ffmpeg -stats -loglevel error -i output_720_crf25_temp.mp4 -vcodec libx264 -vbr 3 -vf "scale=iw*sar:ih" -preset slow -crf 25 output_720_crf25.mp4	
	del output_720_crf25_temp.mp4
	rename output_1920_crf25_temp.mp4 %title2%_TV.mp4
	rename output_720_crf25.mp4 %title2%_low.mp4
	rename output_high.mp4 %title2%_raw.mp4

	pause
	