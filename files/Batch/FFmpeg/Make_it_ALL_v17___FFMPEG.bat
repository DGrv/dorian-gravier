@echo off
SetLocal EnableDelayedExpansion


:: Edit the line below to match your path to the ffmpeg executable.




echo "[37m--------------------------------------------------------------------------------"
echo "[91m   _____             _                _____                 _                   "
echo "  |  __ \           (_)              / ____|               (_)                  "
echo "[92m  | |  | | ___  _ __ _  __ _ _ __   | |  __ _ __ __ ___   ___  ___ _ __         "
echo "[93m  | |  | |/ _ \| '__| |/ _` | '_ \  | | |_ | '__/ _` \ \ / / |/ _ \ '__|        "
echo "[94m  | |__| | (_) | |  | | (_| | | | | | |__| | | | (_| |\ V /| |  __/ |           "
echo "[95m  |_____/ \___/|_|  |_|\__,_|_| |_|  \_____|_|  \__,_| \_/ |_|\___|_|           "
echo "                                                                                "
echo "[37m--------------------------------------------------------------------------------"
REM http://www.network-science.de/ascii/
echo.

echo INFO development things to do:
echo.
echo.

:: to change the encoding utf8 is 65001 and ansi windows 1252, Maybe change it if problems
REM chcp 1252 

echo "Put your video in 1 folder, order with names, put your mp3 inside (no matter the name, also ordered if needed)."



:: ---------- Setup ----------



	:: get timestamp
	REM FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET time=%%A
	REM set TIMESTAMP=%time:~0,8%-%time:~8,6%
	for /f %%p in ('bash -c "date +"%%Y%%m%%d-%%H%%M%%S""') do set TIMESTAMP=%%p

	

	echo. [90m
	WHERE ffmpeg
	IF %ERRORLEVEL% NEQ 0 (
		echo "[91m[DEBUG] - FFMPEG is missing !!!!!!!!" [37m
		pause
	)
	WHERE Perl
	IF %ERRORLEVEL% NEQ 0 (
		echo "[91m[DEBUG] - perl is missing !!!!!!!!" [37m
		pause
	)
	WHERE git
	IF %ERRORLEVEL% NEQ 0 (
		echo "[91m[DEBUG] - git is missing for tools (ls, awk, xargs ....) !!!!!!!!" [37m
		pause
	)
	WHERE exiftool
	IF %ERRORLEVEL% NEQ 0 (
		echo "[91m[DEBUG] - exiftool is missing  !!!!!!!!" [37m
		pause
	)
	if exist "*.gpx" (
		WHERE gpsbabel
		IF %ERRORLEVEL% NEQ 0 (
			echo "[91m[DEBUG] - GPSBabel is missing, Take care you need also gpx-animator !!!!!!!!" [37m
			pause
		)
	)
	echo. [37m
	
	echo [93mExplanation: ---------------------------------------------------------------------------------------------------
	echo You will find a file created after your first run MakeItAll_temp.config
	echo This one will keep all parameters you setted during the first run in order to redo it rapidly without typing them.
	echo Meaning that if you wanna start from scratch you need either to modify or delete this file
	echo --------------------------------------------------------------------------------------------------------------------[37m
	echo.

	if "%1"=="" (
		set /p wd="Where are your mp4 ? (E.g. C:\Users\DGrv\Downloads\test)  "
		set wd=!wd:"=!
	) else (
		set wd=%1
		set wd=!wd:"=!
		REM set wd=!wd:~,-1!
		REM set wd=!wd:~1!
	) 

	echo [91m[DEBUG] - wd: %wd% [37m


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


	REM set /p tbdefault=Do you wanna use simple configuration for fps (24) and audio frequence (48Hz) [y/n] ? :
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	set simplemode=n
	REM to have the tools slides at the end
	set ltools=n
	set tbdefault=y
	set biketrip=n
	set pathout=D:\Pictures\2024\Video
	set fadeinout=y
	set audionorma=n
	set docodec=y
	set doreso=y
	set docheck=y
	REM if simplemode not y does not care about this
	set javapath="C:\Program Files\gpx-animator\jre\bin\java.exe"
	set gpxanimatorpath="C:\Program Files\gpx-animator\gpx-animator-1.8.2-all.jar"
	
					REM ToDo
					REM check if add songs empty in check seems not
					
					
	if %simplemode%==y (
		set dooverlaymusic=n
		set dofiligrane=n
		goto next1
	) else (
		set dooverlaymusic=y
		set dofiligrane=y
	)
	
	
	

	echo.
	REM echo [91m
	REM set /p temp="Did you add the date in your video ?"
	REM echo [37m
	
	:next1
	
	:: rename MP$ to mp4
	bash -c "source ~/.bashrc;renamemp4ext"
	
	
	if not exist BU ( 
		mkdir BU
		REM Avoid overwriting
		echo No | copy /-Y * BU\
	) 
	:: config file and BU
	if exist MakeItAll_temp.config (
		set /p title=<MakeItAll_temp.config
	) else (
		set /p title="Which title: "
		echo !title! > MakeItAll_temp.config
	)
	
	if %docheck%==n (echo Check_done >> MakeItAll_temp.config)

	set title2=%title:\n\n= %
	set title2=%title2:\n= %
	set title2=%title2:'=%
	set title2=%title2: =_%
	set title2=%title2:-=_%
	set title2=%title2:,=%
	set title2=%title2:(=%
	set title2=%title2:)=%
	set title2=%title2:/=%
	set title2=%title2::=%
	
	
	echo %title2%
	echo title2=%title2% >> MakeItAll_temp.config

	:: Music
	echo [INFO] - Rename correctlty your mp3, the music title at the end will be written based on your filenames
	ls -1 | grep mp3 | grep -Ev "^begin|^end|^input|^List" | sed "s/.mp3//" | perl -pe "s/^x - |^y - |^z - //g" > Music_list_temp.txt
	
	bash -c "[ -e 'Test_youtube_copy.mp4' ] && rm 'Test_youtube_copy.mp4'"
	bash -c "[ -e 'output_temp.mp4' ] && rm 'output_temp.mp4'"


echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start [37m
echo.


:: ---------- Music ----------

echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start Music input_temp.mp3 [37m
echo.
	
	set "mp3found=0"
	for %%f in (*.mp3) do set "mp3found=1"

	if %mp3found%==1 (
		if NOT EXIST input_temp.mp3 (
			if exist Listmp3_temp.txt (
				rm Listmp3_temp.txt
			)
			for %%i in (*mp3) do (
				set filename=%%~ni
				set filenamenew=!filename:'=!
				if NOT !filename!==!filenamenew! rename "%%i" "!filenamenew!%%~xi"
			)
			bash -c "source ~/.bashrc;normamp3"
			ls -1 | grep mp3 | grep -Ev "^begin.mp3|^end.mp3|^input|List" | sed "s/^/file '/" | sed "s/$/'/" > Listmp3_temp.txt
			if exist Listmp3_temp.txt (
				ffmpeg -stats -loglevel error -safe 0 -f concat -i Listmp3_temp.txt -c copy -y input_temp.mp3
				del Listmp3_temp.txt
			)
		)
	)
	
	
	:: use - safe 0 before i to avoid problem with filename : https://stackoverflow.com/questions/38996925/ffmpeg-concat-unsafe-file-name
	
	
:: ---------- Fade in and out video ----------
	
	
	if %fadeinout%==y (
	
		echo.
		echo [94m------------------------------------------------- [37m
		echo [94mINFO - Start Fade in and out, need re-encoding [37m
		echo.
		
		for /f %%p in ('bash -c "ls -1 | grep mp4 | grep -Ev 'zzz_gpx_temp.mp4|zzz|zzz_lsub_v01.mp4|zzz_ko-fi.mp4|zzz_music_temp.mp4|00000_title.mp4'| head -1"') do set firstfile=%%p
		for /f %%p in ('bash -c "ls -1 | grep mp4 | grep -Ev 'zzz_gpx_temp.mp4|zzz|zzz_lsub_v01.mp4|zzz_ko-fi.mp4|zzz_music_temp.mp4|00000_title.mp4'| tail -1"') do set lastfile=%%p

		for /f %%i in ('grep fadein_done MakeItAll_temp.config ^| wc -l') do set check=%%i
		if !check!==0 (
			REM copy "!firstfile!" "%wd%\BU\!firstfile!"
			echo --- Create fadein on !firstfile!
			ffmpeg -stats -loglevel error -i "%wd%\BU\!firstfile!" -vf "fade=t=in:st=0:d=3" -af "afade=t=in:st=0:d=3" -y "!firstfile!"
			echo fadein_done >> MakeItAll_temp.config
		)
		for /f %%i in ('grep fadeout_done MakeItAll_temp.config ^| wc -l') do set check=%%i
		if !check!==0 (
			REM copy "!lastfile!" "%wd%\BU\!lastfile!"
			echo --- Create fadeout on !lastfile!
			for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "%wd%\BU\!lastfile!"') do set lengthvideo=%%i
			set /a lengthvideo2=lengthvideo
			set /a lengthvideo3=lengthvideo2-3
			if !lengthvideo2! gtr 3 (
				ffmpeg -stats -loglevel error -i "BU\!lastfile!" -vf "fade=t=out:st=!lengthvideo3!:d=3" -af "afade=t=out:st=!lengthvideo3!:d=3" -y "!lastfile!"
			)
			echo fadeout_done >> MakeItAll_temp.config
		)
	)
	
	
echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start title [37m
echo.


	if %simplemode%==n (
		if %ltools%==y (
			if not exist zzz_ltools.mp4 ( copy "D:\Pictures\Youtube\tools\zzz_ltools.mp4" "zzz_ltools.mp4" )
		)
		if %biketrip%==y ( 
			if not exist zzz_ko-fi.mp4 ( copy "D:\Pictures\Youtube\Ko-fi\v02\Ko-fi_v02.mp4" "zzz_ko-fi.mp4" )
		)
	)
	
	set "title=%title:"=%"
	if exist "temptitle" rm temptitle

	if NOT EXIST 00000_title.mp4 (
		
		bash -c "echo -e '%title%' > temptitle"
		call C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\FFmpeg\Create_title_clip_v08___FFMPEG.bat 2 y 70 temptitle 00000_title.mp4
		del temptitle
	)
	::  -f lavfi -i aevalsrc=0 -shortest 
	:: Generate the minimum silence required
	:: https://superuser.com/questions/1096921/concatenating-videos-with-ffmpeg-produces-silent-video-when-the-first-video-has
	
	
	
	
echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start music title [37m
echo.
	
	
	if %mp3found%==1 (
		if NOT EXIST zzz_music_temp.mp4 (
			echo Music:> Music_temp
			echo. >> Music_temp
			cat Music_list_temp.txt >> Music_temp
			call C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\FFmpeg\Create_title_clip_v08___FFMPEG.bat 2 y 70 Music_temp zzz_music_temp.mp4
			del Music_temp
		)
	)
		


if %simplemode%==n goto gpxanipass

echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Gpx-animator [37m
echo.

for /f %%a in ('ls ^| grep gpx ^| wc -l') do set gpxhere=%%a
if NOT %gpxhere%==0 (
	if not exist zzz_gpx_temp.mp4 (
		if not exist Merge.gpx (
			set f=
			for %%f in (*.gpx) do set f=!f! -f "%%f"
			gpsbabel -i gpx !f! -x duplicate,location,shortname -o gpx -F Merge.gpx	
		)
		%javapath% -jar %gpxanimatorpath% --input "Merge.gpx" --output "zzz_gpx_temp.mp4" --tms-url-template "https://{switch:a,b,c}.tile-cyclosm.openstreetmap.fr/cyclosm/{zoom}/{x}/{y}.png" --width 1920 --height 1080 --speedup 10000 --fps 24 --keep-last-frame 7000 --keep-first-frame 3000 --font Monospaced-BOLD-22 --margin 0 --tail-duration 0 --color "#FF0000" --flashback-duration 0 --background-map-visibility 1
		
		for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 zzz_gpx_temp.mp4') do set lengthvideo=%%i
		set /a lengthvideo2=lengthvideo
		set /a lengthvideo3=lengthvideo2-3
		if !lengthvideo2! gtr 3 (
			rename zzz_gpx_temp.mp4 zzz_gpx_temp_temp.mp4
			ffmpeg -stats -loglevel error -i zzz_gpx_temp_temp.mp4 -vf "fade=t=in:st=1:d=3,fade=t=out:st=!lengthvideo3!:d=3" -c:a copy zzz_gpx_temp.mp4
			del zzz_gpx_temp_temp.mp4
		)
	)
)

:gpxanipass


echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start duration [37m
echo.

	
	REM for /f %%i in ('grep Duration_done MakeItAll_temp.config ^| wc -l') do set check=%%i
	REM if %check%==0 (
	
		for /f %%j in ('bash -c "source ~/.bashrc;check_duration"') do (
		   set durationok=%%j
		   echo [95m%%j[37m
		)
		
		IF "%durationok%"=="0"  (
			echo.
			echo [91m[DEBUG] - input_temp.mp3 and output_temp.mp4 will be deleted, please check if necessary [37m
			pause
			echo.
			del input_temp.mp3 output_temp.mp4 Music_list_temp.txt
			goto eof
		) 
		
		echo Duration_done >> MakeItAll_temp.config
	REM )




echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Add music title overlay [37m
echo.

	if %mp3found%==1 (
		for /f %%i in ('grep Overlay_done MakeItAll_temp.config ^| wc -l') do set check=%%i
		if %dooverlaymusic%==y (
			if %check%==0 (
				if not exist Video_list_overlay_temp.txt (
					(for %%i in (*.mp4) do @echo %%i) > Video_list_overlay_temp.txt
				)
				if exist Music_list_overlay_duration_temp.txt del Music_list_overlay_duration_temp.txt
				ls -1 | grep mp3 | grep -Ev "begin.mp3|end.mp3|input|List" > Music_list_overlay_temp.txt
				for /F "delims=" %%b in (Music_list_overlay_temp.txt) do (
					ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%%b" >> Music_list_overlay_duration_temp.txt
				)
				
				
				set xpos=0.95
				set ypos=0.95
				
				set /a duraTT=5
				set /a videoTT = 0
				set /a videoTTbefore = 0
				set /a n=0
				if not exist BU_Music_overlay ( mkdir BU_Music_overlay )
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
								
								echo [32mOK ---- %%b gtr !musicn! ------ !videoTT! gtr !duraTT! ----- posmusic = !duraTT!-!videoTTbefore! = !posmusic! [37m
								
								rename Music_list_overlay_duration_temp.txt musicduration.temp
								more +1 musicduration.temp > Music_list_overlay_duration_temp.txt
								del musicduration.temp
								
								rename Music_list_overlay_temp.txt music.temp
								more +1 music.temp > Music_list_overlay_temp.txt
								del music.temp
								
								
								move %%b !rename!
								ffmpeg -stats -loglevel error -i !rename! -vf "drawtext=text='!musicn!': fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf':fontfile='C\:\\Windows\\Fonts\\calibri.ttf':fontsize=30: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,!posmusic!,!posmusic2!)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -c:a copy %%b
								move !rename! BU_Music_overlay\!rename!
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
				REM touch Overlay_done.txt
				echo Overlay_done >> MakeItAll_temp.config
				sed -i /Check2_done/d MakeItAll_temp.config
				if exist tempfile del tempfile
				if exist Music_list_overlay_duration_temp.txt del Music_list_overlay_duration_temp.txt
			)
		)
	)
	
	
	

	
REM echo.
REM echo [94m------------------------------------------------- [37m
REM echo [94mINFO - Add filigrane [37m
REM echo.

	REM if %biketrip%==y (
		REM if %dofiligrane%==y (
			REM for /f %%i in ('grep Filigrane_done MakeItAll_temp.config ^| wc -l') do set check=%%i
			REM if !check!==0 (
				REM for /f %%p in ('ls -1 ^| grep mp4 ^| grep -Ev "zzz|title"') do (
					REM set filenamenoext=%%~np
					REM set ext=%%~xp
					REM set name=!filenamenoext!_temp!ext!
					REM rename %%p !name!
					REM echo [93m--- Add filigrane to %%p[37m
					REM REM ffmpeg -stats -loglevel error -y -i "!name!" -stream_loop -1 -i "D:\Pictures\Tatoo_FIX_v01.png" -filter_complex "[0]overlay=enable:x=0:y=0:shortest=1[out]" -map [out] -map 0:a "%%p"
					REM :: new test from https://video.stackexchange.com/questions/12105/add-an-image-overlay-in-front-of-video-using-ffmpeg
					REM ffmpeg -stats -loglevel error -y -i "!name!" -i "D:\Pictures\Youtube\Tatoo\Tatoo_FIX_v01_crop.png" -filter_complex "[0:v][1:v] overlay=W-w:H-h" -pix_fmt yuv420p -c:a copy "%%p"
					REM del "!name!"
				REM )
				
				REM (for %%i in (*.mp4) do @echo file '%%i') > Listmp4_temp.txt
				REM ffmpeg -stats -loglevel error -f concat -i Listmp4_temp.txt -c copy output_temp.mp4
				REM del Listmp4_temp.txt
				
				REM for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 output_temp.mp4') do set /a durav=%%i
				REM del output_temp.mp4
				REM set /a durav2=durav/3
				
				REM for /f %%p in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "D:\Pictures\Youtube\Subscribe\Subscribe_v02.mp4"') do set /a timesub=%%p
				REM set /a tt=0
				REM for %%b in ("*mp4") do (
					REM for /f %%h in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "%%b"') do set /a timev=%%h
					REM set /a tt+=timev
					REM if !tt! GTR !durav2! (
						REM if !timev! GTR !timesub! (
							REM set filenamenoext=%%~nb
							REM set ext=%%~xb
							REM set name=!filenamenoext!_temp!ext!
							REM rename %%b !name!
							REM echo [93m--- Add filigrane subscribe to %%b[37m
							REM ffmpeg -stats -loglevel error -y -i !name! -i "D:\Pictures\Youtube\Subscribe\Subscribe_v02.mp4" -filter_complex "[1:v]colorkey=black:similarity=0.4[1v2];[0:v][1v2]overlay[v]" -map "[v]" -map 0:a "%%b"
							REM del "!name!"
							REM goto endsub
						REM )
					REM )
				REM )
				REM :endsub
				REM echo Filigrane_done >> MakeItAll_temp.config
				REM sed -i /Check2_done/d MakeItAll_temp.config
			REM )
		REM )
	REM )
	

echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start format check [37m
echo.


		echo [95m Audio ----------------- [37m
		bash -c "source ~/.bashrc;check_audio"
		echo.
		bash -c "source ~/.bashrc;check_AR"
	
		:: Video
		echo.
		echo [95m Video ----------------- [37m
		
		bash -c "source ~/.bashrc;reducefr30"
		echo.
		bash -c "source ~/.bashrc;check_reso"
		echo.
		bash -c "source ~/.bashrc;check_codec"
		echo.
		REM Desactivate check_timescale30 because it is making problems with rmdf
		REM bash -c "source ~/.bashrc;check_timescale30"
		
		
		REM bash -c "source ~/.bashrc;check_starttime"
	
		REM for /f %%i in ('grep Check_done MakeItAll_temp.config ^| wc -l') do set check1=%%i
		REM if !check1!==0 (
			REM echo Check_done >> MakeItAll_temp.config
		REM ) else (
			REM echo Check2_done >> MakeItAll_temp.config
			REM goto check2end
		REM )

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
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start bind [37m
echo.

	REM (for %%i in (*.mp4) do @echo file '%%i') > Listmp4_temp.txt
	REM ffmpeg -stats -loglevel error -f concat -i Listmp4_temp.txt -c copy output_BIND.mp4
	REM del Listmp4_temp.txt
	bash -c "source ~/.bashrc;concatmp4"
	
	rename concat.mp4 output_BIND.mp4
	
	
	if EXIST input_temp.mp3 (
		bash -c "ffmpeg -stats -loglevel error -y -i output_BIND.mp4 -async 1 audio.mp3"
		ffmpeg -stats -loglevel error -i audio.mp3 -i input_temp.mp3 -filter_complex "[0]volume=2[a1];[1]volume=0.4[a2];[a1][a2]amix=duration=shortest" audio_music.mp3
		ffmpeg -stats -loglevel error -i output_BIND.mp4 -i audio_music.mp3 -c:v copy -map 0:v:0 -map 1:a:0 output_temp.mp4
		del output_BIND.mp4
	) else (
		rename output_BIND.mp4 output_temp.mp4
	)

	:: check youtube copyright
	if EXIST audio_music.mp3 (
		for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "audio_music.mp3"') do set lengthaudio=%%i
		if %simplemode%==n (
			ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=480x270:d=%lengthaudio% temp.mp4
			ffmpeg -stats -loglevel error -i temp.mp4 -i audio_music.mp3 -c:v copy -map 0:v:0 -map 1:a:0 Test_youtube_copy.mp4
		)
		del temp.mp4 temp2.mp4
	)
	
echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start convert low [37m
echo.
	

	rename output_temp.mp4 %title2%_TV.mp4
	rename audio.mp3 %title2%_AUDIO.mp3
	if exist audio_norma.mp3 ( rename audio_norma.mp3 %title2%_AUDIO-NORMA.mp3 )
	

	echo ffmpeg -stats -loglevel error -i %title2%_TV.mp4 -vbr 3 -vf "scale=720:-2" -preset slow -crf 25 -c:a copy -y %title2%_low.mp4 > CONVERT_in_LOW.bat

	if %simplemode%==n (
		REM echo Sous-titres français disponibles. > Music_list_temp2.txt
		REM echo. >> Music_list_temp2.txt
		echo **Music:** >> Music_list_temp2.txt
		cat Music_list_temp.txt >> Music_list_temp2.txt
		REM echo. >> Music_list_temp2.txt
		REM echo You can find all other video here : https://www.youtube.com/playlist?list=PLWaLsaDTITnN2taIj2q8KIhdulM1xcveL >> Music_list_temp2.txt
		echo. >> Music_list_temp2.txt
		echo To subscribe: https://www.youtube.com/@DoriGrv?sub_confirmation=1 >> Music_list_temp2.txt
		REM echo. >> Music_list_temp2.txt
		REM echo 🚲 *The track* : https://dorian-gravier.com/bt >> Music_list_temp2.txt
		rename Music_list_temp2.txt %title2%_MUSIC-TITLE.txt
	)

	if exist Music_list_temp.txt ( del Music_list_temp.txt	)

	
	echo del %title2%_TV.mp4 > DEL_end_files_MP4.bat
	echo del %title2%_low.mp4  >> DEL_end_files_MP4.bat
	echo del %title2%_AUDIO.mp3 >> DEL_end_files_MP4.bat
	echo del %title2%_AUDIO-NORMA.mp3 >> DEL_end_files_MP4.bat
	echo del %title2%_MUSIC-TITLE.txt >> DEL_end_files_MP4.bat
	echo del audio_music.mp3 >> DEL_end_files_MP4.bat
	echo del Test_youtube_copy.mp4 >> DEL_end_files_MP4.bat
	echo sed -i /Duration/d MakeItAll_temp.config >> DEL_end_files_MP4.bat
	echo sed -i /Check/d MakeItAll_temp.config >> DEL_end_files_MP4.bat
	echo set /p dooverlay="Do you want restore the overlaid video (music titles) [y/n - or nothing]: ">> DEL_end_files_MP4.bat
	echo	if "%dooverlay%"=="y" (>> DEL_end_files_MP4.bat
	echo sed -i /Overlay/d MakeItAll_temp.config >> DEL_end_files_MP4.bat
	echo bash -c "source ~/.bashrc;restoreBUoverlay" >> DEL_end_files_MP4.bat

	
	echo move %title2%_TV.mp4 %pathout%\High\ > IF_OK_MOVE_READY_MP4.bat
	echo move %title2%_low.mp4 %pathout%\Low\ >> IF_OK_MOVE_READY_MP4.bat
	echo move %title2%_AUDIO.mp3 %pathout%\Audio\ >> IF_OK_MOVE_READY_MP4.bat
	echo move %title2%_AUDIO-NORMA.mp3 %pathout%\Audio\ >> IF_OK_MOVE_READY_MP4.bat
	echo move %title2%_MUSIC-TITLE.txt %pathout%\Music_txt\ >> IF_OK_MOVE_READY_MP4.bat
	if exist input_temp.mp3 (del input_temp.mp3 )
	REM xcopy /Y *.mp3 %pathout%\Music\
	ls | grep mp3 | grep -vE "AUDIO|input_temp|audio.mp3|audio_music" | xargs -I # cp "#" %pathout%\Music
	echo.

	echo [32m-------------- Finish ------------- [37m
	echo [32mDo not forget to convert it in low if it is fine [37m
	echo [32m----------------------------------- [37m
	:eof
	
	