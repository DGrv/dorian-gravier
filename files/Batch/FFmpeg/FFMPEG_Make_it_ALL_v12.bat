@echo off
SetLocal EnableDelayedExpansion


:: Edit the line below to match your path to the ffmpeg executable.




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

echo INFO development things to do:
echo.
echo.

echo Put your video in 1 folder, order with names, put your mp3 inside (not matter the name, also ordered if needed).



:: ---------- Setup ----------

	echo.
	echo Your ffmpeg is here:
	WHERE ffmpeg
	IF %ERRORLEVEL% NEQ 0 (
		echo "[DEBUG] - FFMPEG is missing !!!!!!!!"
		pause
	)
	echo.






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





	if exist temp_MakeItAll.config (
		set /p title=<temp_MakeItAll.config
	) else (
		set /p title="Which title: "
		echo !title! > temp_MakeItAll.config
	)
	set title2=%title: =_%
	set title2=%title2:-=%
	set title2=%title2:__=_%

	

	:: Music
	if not exist music.txt (
		echo [INFO] - Rename correctlty your mp3, the music title at the end will be written based on your filenames
		set /p temp="If you wanna use a jiggle beginning and at the end use files named 'begin.mp3' and-or 'end.mp3'"
		for %%i in (*.mp3) do (
			set Test=T
			if "%%i"=="input.mp3" set Test=F
			if "%%i"=="begin.mp3" set Test=F
			if "%%i"=="end.mp3" set Test=F
			IF "!Test!"=="T" (
				@echo %%~ni >> music.txt
				@echo %%i >> musictemp.txt
			)
		)
	)
	
	echo.
	
	
	
	REM set /p tbdefault=Do you wanna use simple configuration for fps (24) and audio frequence (48Hz) [y/n] ? :
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	set tbdefault=y
	
	
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
		set /p tbs="Which tbs (if 1/24000, choose 24000): "
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
	REM set /p fadeinout="Do you want a fade IN and OUT on your video, first and last [y/n] ? :"
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	set fadeinout=y

	echo.
	REM set /p audionorma="Do you want to normalize audio (can make problem sometimes) [y/n] ? :"
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	set audionorma=n



	if EXIST output_720_crf25_temp.mp4 GOTO convertion3
	if EXIST output_1920_crf25_temp.mp4 GOTO convertion2
	if EXIST output_1024_crf25_temp.mp4 GOTO convertion1









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
		for %%i in (*.mp3) do (
			set Test=T
			if "%%i"=="begin.mp3" set Test=F
			if "%%i"=="end.mp3" set Test=F
			IF "!Test!"=="T" (
				@echo file '%%i' >> listmp3.txt
			)
		)
		if exist listmp3.txt (
			ffmpeg -stats -loglevel error -safe 0 -f concat -i listmp3.txt -c copy input_temp.mp3
			ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 input_temp.mp3 > tempfile
			set /p tbna=<tempfile
			if NOT "!tbna!"=="%tbsa2%" (
				rename %%i %%~ni_temp.mp4
				ffmpeg -stats -loglevel error -i input_temp.mp3 -ar %tbsa% input.mp3
				del %%~ni_temp.mp4
			) ELSE (
				rename input_temp.mp3 input.mp3
			)
			if exist input_temp.mp3 (
				del input_temp.mp3
			)
				del listmp3.txt
		)
	)

	
	:: use - safe 0 before i to avoid problem with filename : https://stackoverflow.com/questions/38996925/ffmpeg-concat-unsafe-file-name
	





:: ---------- Fade in and out video ----------


	if not exist zzzzzz_music.mp4 (
		if %fadeinout%==y (
		
			echo.
			echo -------------------------------------------------
			echo INFO - Start Fade in and out, need re-encoding
			echo.
			
			(for %%i in (*.mp4) do @echo %%i) > tempfile
			for /F "delims=" %%a in (tempfile) do (
				set last=%%a
			)
			set /p first=<tempfile
			REM echo last !last!
			REM echo first !first!
			del tempfile
			ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 !last! > tempfile2
			set /p lengthvideo=<tempfile2
			set /a lengthvideo2=!lengthvideo!
			set /a lengthvideo3=!lengthvideo2!-3
			REM echo lengthvideo !lengthvideo!
			REM echo lengthvideo2 !lengthvideo2!
			REM echo lengthvideo3 !lengthvideo3!
			del tempfile2
			rename !first! first.mp4
			rename !last!	last.mp4
			ffmpeg -stats -loglevel error -i first.mp4 -vf "fade=t=in:st=0:d=3" -c:a copy !first!
			if !lengthvideo2! gtr 3 (
				echo sup 3
				ffmpeg -stats -loglevel error -i last.mp4 -vf "fade=t=out:st=!lengthvideo3!:d=3" -c:a copy !last!
			)
			if exist !first! (
				del first.mp4
			) else (
				rename first.mp4 !first!
			)
			if exist !last! (
				del last.mp4
			) else (
				rename last.mp4 !last!
			)
		)
	)



:: ---------- Create Title ----------

	
echo.
echo -------------------------------------------------
echo INFO - Start title
echo.

	REM copy /V C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\FFmpeg\ARIAL.TTF
	
	echo|set /p="| ">temptitle
	echo|set /p=%title%>>temptitle
	echo|set /p=" |">>temptitle

	if NOT EXIST 00000_title.mp4 (
		ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=2704x1520:d=8 -vf drawtext="fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:textfile=temptitle" -video_track_timescale %tbs% 000_temp.mp4
		:: add audio
		ffmpeg -stats -loglevel error -i 000_temp.mp4 -f lavfi -i aevalsrc=0 -shortest -y 000_temp2.mp4
		del 000_temp.mp4
		:: change parameters audio
		ffmpeg -stats -loglevel error  -i 000_temp2.mp4 -vf "fade=t=in:st=1:d=4" -c:a copy 000_temp3.mp4
		del 000_temp2.mp4
		ffmpeg -stats -loglevel error -i 000_temp3.mp4 -ar %tbsa% -video_track_timescale %tbs% 00000_title.mp4
		del 000_temp3.mp4

	)
	del temptitle
	::  -f lavfi -i aevalsrc=0 -shortest 
	:: Generate the minimum silence required
	:: https://superuser.com/questions/1096921/concatenating-videos-with-ffmpeg-produces-silent-video-when-the-first-video-has
	
	
	
	
echo.
echo -------------------------------------------------
echo INFO - Start music title
echo.
	
	
	
	if not exist music.txt (
		ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=2704x1520:d=12 -video_track_timescale %tbs% zzzb.mp4
	)

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
				ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=2704x1520:d=12 -vf drawtext="fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!hightitle!:text='| Music |'" -video_track_timescale %tbs% zzz.mp4
				ffmpeg -stats -loglevel error -i zzz.mp4 -vf drawtext="fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!high!:text='%%a'" -video_track_timescale %tbs% zzz!x!.mp4
				del zzz.mp4
			) else (
				ffmpeg -stats -loglevel error -i zzz!before!.mp4 -vf drawtext="fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!high!:text='%%a'" -video_track_timescale %tbs% zzz!x!.mp4
				del zzz!before!.mp4
			)
			set last=zzz!x!.mp4
			set /a x=!x!+1
		)
		
		ffmpeg -stats -loglevel error -i !last! -f lavfi -i aevalsrc=0 -shortest -y zzzb.mp4
		del !last!
	)
	
		
	if exist zzzb.mp4 (
		ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 zzzb.mp4 > tempfile2
		set /p lengthvideo=<tempfile2
		set /a lengthvideo2=%lengthvideo%
		set /a lengthvideo3=%lengthvideo2%-3
		del tempfile2
		ffmpeg -stats -loglevel error -i zzzb.mp4 -ar %tbsa% -video_track_timescale %tbs% zzzc.mp4
		ffmpeg -stats -loglevel error -i zzzc.mp4 -vf "fade=t=in:st=1:d=3,fade=t=out:st=%lengthvideo2%:d=3" -c:a copy zzzzzz_music.mp4

		del zzzb.mp4
		del zzzc.mp4
	)

	REM del arial.ttf




:: ---------- Modification ----------


	REM powercfg /hibernate off


echo.
echo -------------------------------------------------
echo INFO - Start tbsa
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
			echo --- Reencode %%i, tbsa was !tbna! instead of %tbsa2%
			ffmpeg -stats -loglevel error -i %%~ni_temp.mp4 -ar %tbsa% %%i
			del %%~ni_temp.mp4
		)
	)
	REM :: fade in and out 1 to avoid to rash transition
	REM for %%i in (*.mp4) do (
		REM ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 %%i > tempfile2
		REM set /p lengthvideo=<tempfile2
		REM set /a lengthvideo2=!lengthvideo!
		REM set /a lengthvideo3=!lengthvideo2!-1
		REM del tempfile2
		REM rename %%i %%~ni_temp
		REM if 1 LSS !lengthvideo2! (
			REM ffmpeg -stats -loglevel error -i %%~ni_temp -af "afade=t=in:st=0:d=1,afade=t=out:st=!lengthvideo3!:d=1" -c:v copy %%i
		REM ) else (
			REM echo [DEBUG] - Your video is too short to have a fade of 1sec
		REM )
		REM del %%~ni_temp
	REM )
			

	
echo.
echo -------------------------------------------------
echo INFO - Start tbs
echo.

	:: change tbs to have all the same - video tbs
	for %%i in (*.mp4) DO (
		ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%i > tempfile
		set /p tbn=<tempfile
		del tempfile
		if NOT "!tbn!"=="%tbs2%" (
			rename %%i %%~ni_temp.mp4
			echo --- Reencode %%i, tbsa was !tbn! instead of %tbs2%
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
echo INFO - Add music title overlay
echo.

	REM if not exist video_duration.txt (
		REM set /a duraTT=0
		REM for %%i in (*.mp4) do (
			REM ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%%i" > tempfile
			REM set /p dura=<tempfile
			REM set /a dura=!dura!
			REM set /a duraTT=!dura!+!duraTT!
			REM echo !duraTT! >> video_duration.txt
		REM )
	REM )
	
	if not exist video.txt (for %%i in (*.mp4) do @echo %%i >> video.txt)
	
	
	set xpos=0.95
	set ypos=0.95
	Rem First file is read with FOR /F command
	Rem Second file is read via standard handle 3
	REM Source : https://stackoverflow.com/questions/14521799/combining-multiple-text-files-into-one/14523100#14523100
	
	REM for %%i in (*.mp3) do (
		REM set Test=T
		REM if "%%i"=="input.mp3" set Test=F
		REM if "%%i"=="begin.mp3" set Test=F
		REM if "%%i"=="end.mp3" set Test=F
		REM IF "!Test!"=="T" (			
			REM ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%%i" > tempfile
			REM set /p duraTT=<tempfile
			REM set /a duraTT=!duraTT!
			REM set /a duraTT=!duraTT!-5-!duraTT!
			REM goto nextmusic
		REM )
	REM )
	REM :nextmusic
	
	
		REM for %%i in (*.mp3) do (
			REM set Test=T
			REM if "%%i"=="input.mp3" set Test=F
			REM if "%%i"=="begin.mp3" set Test=F
			REM if "%%i"=="end.mp3" set Test=F
			REM IF "!Test!"=="T" (
				REM ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%%i" > tempfile
				REM set /p dura=<tempfile
				REM set /a dura=!dura!
				REM set /a duraTT=!dura!+!duraTT!
				REM echo !duraTT! >> music_duration.txt
			REM )
		REM )
	
	
	
	set /a duraTT=5
	set /a videoTT = 0
	set /a videoTTbefore = 0
	for /F "delims=" %%b in (video.txt) do (
		ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%%b" > tempfile
		set /p videotime=<tempfile
		set /a videotime=!videotime!
		set /a videoTT=!videotime!+!videoTT!

		for /F "delims=" %%a in (musictemp.txt) do (
			set musicn=%%a
			ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%%a" > tempfile
			set /p dura=<tempfile
			set /a dura=!dura!
			if !videoTT! GTR !duraTT! (
				set /a posmusic=!duraTT!-!videoTTbefore!
				set /a posmusic2=!posmusic!+5
				echo OK ---- %%b gtr !musicn! ------ !videoTT! gtr !duraTT! ----- posmusic = !duraTT!-!videoTTbefore! = !posmusic!
				rename musictemp.txt music.temp
				more +1 music.temp > musictemp.txt
				del music.temp
				rename %%b %%~nb_temp.mp4
				ffmpeg -stats -loglevel error -i %%~nb_temp.mp4 -vf "drawtext=text='Music: !musicn:~0,-5!': fontcolor=white: fontsize=20: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*%xpos%-text_w:y=h*%ypos%:enable='between(t,!posmusic!,!posmusic2!)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -c:a copy %%b
				del %%~nb_temp.mp4
				set /a duraTT=!dura!+!duraTT!
			)
		)
		set /a videoTTbefore=!videotime!+!videoTTbefore!
	)
	del musictemp.txt

echo.
echo -------------------------------------------------
echo INFO - Start bind
echo.

	(for %%i in (*.mp4) do @echo file '%%i') > listmp4.txt
	
	
	
	ffmpeg -stats -loglevel error -f concat -i listmp4.txt -c copy output.mp4
	del listmp4.txt
	
	ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 input.mp3 > tempfile
	set /p duraa=<tempfile
	ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 output.mp4 > tempfile
	set /p durav=<tempfile
	del tempfile
	set /a duraa=%duraa%
	set /a durav=%durav%
	
	IF %duraa% LSS %durav% (
		echo.
		echo [DEBUG] - Your music is not long enough for your video ...
		echo [DEBUG] - Your music is not long enough for your video ...
		echo [DEBUG] - Your music is not long enough for your video ...
		echo [DEBUG] - Length Video is %durav%
		echo [DEBUG] - Length Audio is %duraa%
		echo [DEBUG] - Input.mp3 and ouput.mp4 will be deleted, please check if necessary
		pause
		echo.
		del input.mp3 output.mp4 music.txt
		goto eof
	)
	
echo.
echo -------------------------------------------------
echo INFO - Start bind music
echo.

	:: audio replace
	::ffmpeg -stats -loglevel error -i output.mp4 -i inputfinal.mp3 -c copy -map 0:0 -map 1:0 -shortest output2.mp4
	:: audio mixen
	if EXIST input.mp3 (
		::ffmpeg -stats -loglevel error -i output.mp4 -i input.mp3 -filter_complex "[0:a]volume=2[a1];[1:a]volume=0.5[a2];[a1][a2]amerge=inputs=2[a]" -map 0:v -map "[a]" -c:v copy -c:a libvorbis -ac 2 -shortest output_high.mp4 :: 20191224 was not working on the samsung TV because of the vorbis codec
		ffmpeg -stats -loglevel error -i output.mp4 -i input.mp3 -filter_complex "[0:a]volume=4[a1];[1:a]volume=0.3[a2];[a1][a2]amerge=inputs=2[a]" -map 0:v -map "[a]" -c:v copy -ac 2 -shortest output_high_temp.mp4
	) 
	if NOT EXIST output_high_temp.mp4 (
		rename output.mp4 output_high_temp.mp4
	)
	if exist output.mp4 (
		del output.mp4
	)
	
	
echo.
echo -------------------------------------------------
echo INFO - Start bind jingle if exist
echo.
	
	REM BECAREFUL superposition de jinge et music I think
	REM BECAREFUL superposition de jinge et music I think
	REM BECAREFUL superposition de jinge et music I think
	REM BECAREFUL superposition de jinge et music I think
	REM BECAREFUL superposition de jinge et music I think
	
	if EXIST begin.mp3 (
		ffmpeg -stats -loglevel error -i output_high_temp.mp4 -i begin.mp3 -filter_complex amix=inputs=2:duration=longest -c:v copy -ac 2 output_high_jiggle_start.mp4
	) 
	if NOT EXIST output_high_jiggle_start.mp4 (
		rename output_high_temp.mp4 output_high_jiggle_start.mp4
	)
	if exist output_high_temp.mp4 (
		del output_high_temp.mp4
	)
	
	REM https://ourcodeworld.com/articles/read/1484/how-to-get-the-information-and-metadata-of-a-media-file-audio-or-video-in-json-format-with-ffprobe
	REM Get all info available ffprobe : ffprobe -hide_banner -loglevel fatal -show_error -show_format -show_streams -show_programs -show_chapters -show_private_data -print_format json file.mp4
	
	if EXIST end.mp3 (
		ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 output_high_jiggle_start.mp4 > tempfile
		set /p dura=<tempfile
		del tempfile
		set /a dura2=!dura!
		ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 end.mp3 > tempfile
		set /p duraend=<tempfile
		del tempfile
		set /a duraend2=!duraend!
		SET /A mark = !dura2! - !duraend2!
		ffmpeg -stats -loglevel error -i output_high_jiggle_start.mp4 -itsoffset !mark!s -i end.mp3  -filter_complex amix=inputs=2:duration=longest -c:v copy -ac 2 -async 1 output_high.mp4
	) 
	if NOT EXIST output_high.mp4 (
		rename output_high_jiggle_start.mp4 output_high.mp4
	)
	if exist output_high_jiggle_start.mp4 (
		del output_high_jiggle_start.mp4
	)
	
	
	if %audionorma%==y (
		WHERE ffmpeg-normalize
		IF %ERRORLEVEL% EQU 0 (
			rename output_high.mp4 output_high_temp_ffmpeg-normalize.mp4
			echo.
			echo [INFO] - use ffmpeg-normlize
			echo [INFO] - use ffmpeg-normlize
			echo [INFO] - use ffmpeg-normlize
			echo [INFO] - use ffmpeg-normlize
			echo [INFO] - use ffmpeg-normlize
			echo.
			ffmpeg-normalize output_high_temp_ffmpeg-normalize.mp4 -c:a aac -b:a 192k -o output_high.mp4
		)	
		if exist output_high_temp_ffmpeg-normalize.mp4 (
			del output_high_temp_ffmpeg-normalize.mp4
		)
	)
	

	
	
	
echo.
echo -------------------------------------------------
echo INFO - Start convert low
echo.
	
	:convertion1
	ffmpeg -stats -loglevel error -i output_high.mp4 -vcodec libx264 -vbr 3 -vf "scale=1024:-2" -preset slow -crf 25 output_1024_crf25_temp.mp4
	:convertion2
	ffmpeg -stats -loglevel error -i output_high.mp4 -vcodec libx264 -vbr 3 -vf "scale=1920:-2" -preset slow -crf 25 output_1920_crf25_temp.mp4
	:convertion3
	ffmpeg -stats -loglevel error -i output_1024_crf25_temp.mp4 -vcodec libx264 -vbr 3 -vf "scale=720:-2" -preset slow -crf 25 output_720_crf25_temp.mp4
	REM ffmpeg -stats -loglevel error -i output_720_crf25_temp.mp4 -vcodec libx264 -vbr 3 -vf "scale=480:-2" -preset slow -crf 25 output_480_crf25_temp.mp4
	REM ffmpeg -stats -loglevel error -i output_480_crf25_temp.mp4 -vcodec libx264 -vbr 3 -vf "scale=360:-2" -preset slow -crf 25 output_360_crf25_temp.mp4
	REM Was use before for Handy because the format was not passing ...
	REM ffmpeg -stats -loglevel error -i output_720_crf25_temp.mp4 -vcodec libx264 -vbr 3 -vf "scale=iw*sar:ih" -preset slow -crf 25 output_720_crf25.mp4	
	
	REM if exist output_720_crf25_temp.mp4 (
		REM del output_720_crf25_temp.mp4
	REM )
	rename output_1024_crf25_temp.mp4 %title2%_youtube.mp4
	rename output_1920_crf25_temp.mp4 %title2%_TV.mp4
	rename output_720_crf25_temp.mp4 %title2%_low.mp4
	del output_high.mp4

	REM powercfg /hibernate on
	
	echo.
	echo.
	echo Finish :)
	
	echo move %title2%_youtube.mp4 C:\Users\doria\Downloads\Pictures\2022\Video\Youtube > IF_OK_MOVE_READY_MP4.bat
	echo move %title2%_TV.mp4 C:\Users\doria\Downloads\Pictures\2022\Video\High >> IF_OK_MOVE_READY_MP4.bat
	echo move %title2%_low.mp4 C:\Users\doria\Downloads\Pictures\2022\Video\Low >> IF_OK_MOVE_READY_MP4.bat

	:eof
	pause
	
	