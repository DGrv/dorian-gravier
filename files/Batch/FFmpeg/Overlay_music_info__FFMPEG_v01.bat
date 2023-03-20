@echo off
SetLocal EnableDelayedExpansion

echo Batch file to check when the music is coming.
set /p input=Give me the path of the folder with the videos: 


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



echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Add music title overlay [37m
echo.

		echo . > List_video_music.txt

		if not exist Video_list_overlay_temp.txt (
			(for %%i in (*.mp4) do @echo %%i) > Video_list_overlay_temp.txt
		)
		if exist Music_list_overlay_duration_temp.txt del Music_list_overlay_duration_temp.txt
		ls -1 | grep mp3 | grep -Ev "begin|end|input|List" > Music_list_overlay_temp.txt
		for /F "delims=" %%b in (Music_list_overlay_temp.txt) do (
			ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%%b" >> Music_list_overlay_duration_temp.txt
		)
	
		
		set xpos=0.90
		set ypos=0.95
		
		set /a duraTT=5
		set /a videoTT = 0
		set /a videoTTbefore = 0
		set /a n=0
		REM if not exist BU_Music_overlay ( mkdir BU_Music_overlay )
		for /F "delims=" %%b in (Video_list_overlay_temp.txt) do (
			set /a n+=1
			ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%%b" > tempfile
			set /p videotime=<tempfile
			set /a videotime=videotime
			set /a videoTT+=videotime
			set rename=%%~nb_%timestamp%.mp4
			echo [96m!n! - Loop Video - %%b [37m

			if not "%%b"=="00000_title.mp4" (
				set /a na=0
				for /F "delims=" %%a in (Music_list_overlay_temp.txt) do (
					set /a na+=1
					echo [95m!n! - !na! - Loop Audio - %%a [37m
					REM echo !musicn! > tempfilemusic
					REM ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%%a" > tempfile
					set /p dura=<Music_list_overlay_duration_temp.txt
					set /a dura=dura
					if !videoTT! GTR !duraTT! (
						set musicn=%%a
						set musicn2=!musicn:~0,-4!
						set musicn=Music - !musicn2!
						set /a posmusic=duraTT-videoTTbefore
						if !posmusic! LSS 0 (
							set /a posmusic= 1
						)
						set /a posmusic2=!posmusic!+7
						
						REM echo [32mOK ---- %%b gtr !musicn! ------ !videoTT! gtr !duraTT! ----- posmusic = !duraTT!-!videoTTbefore! = !posmusic! [37m
						echo [32mOK ---- %%b gtr !musicn! ------ !videoTT! gtr !duraTT! ----- posmusic = !duraTT!-!videoTTbefore! = !posmusic! [37m
						echo %%b	!musicn! >> List_video_music.txt
						
						rename Music_list_overlay_duration_temp.txt musicduration.temp
						more +1 musicduration.temp > Music_list_overlay_duration_temp.txt
						del musicduration.temp
						
						rename Music_list_overlay_temp.txt music.temp
						more +1 music.temp > Music_list_overlay_temp.txt
						del music.temp
						
						
						REM move %%b !rename!
						REM echo ffmpeg -stats -loglevel error -i !rename! -vf "drawtext=textfile=tempfilemusic: fontcolor=white: fontfile='Arial':fontfile='Arial':fontsize=20: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,!posmusic!,!posmusic2!)'" -vcodec libx265 -x264-params keyint=24:scenecut=0 -c:a copy -video_track_timescale %RV% %%b
						REM ffmpeg -stats -loglevel error -i !rename! -vf "drawtext=text='!musicn!': fontcolor=white: fontfile='Arial':fontfile='Arial':fontsize=30: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,!posmusic!,!posmusic2!)'" -vcodec libx265 -x264-params keyint=24:scenecut=0 -c:a copy -video_track_timescale %RV% %%b
						REM move !rename! BU_Music_overlay\!rename!
						set /a duraTT+=dura
					)
				)
			)
			set /a videoTTbefore+=videotime
		)
		REM del tempfilemusic
		del Music_list_overlay_temp.txt
		del Video_list_overlay_temp.txt
		del tempfile
		del Music_list_overlay_duration_temp.txt
		REM touch Overlay_done.txt
		REM echo Overlay_done >> MakeItAll_temp.config
