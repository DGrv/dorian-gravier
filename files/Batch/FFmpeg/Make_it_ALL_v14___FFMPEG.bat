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

	:: get timestamp
	set /a check=%DATE:~0,1%
	set check2=%DATE:~0,1%
	if "%check%"=="%check2%" (
		set TIMESTAMP=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%-%TIME:~0,2%%TIME:~3,2%
	) else (
		set TIMESTAMP=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%-%TIME:~0,2%%TIME:~3,2%
	)

	echo.
	echo Your ffmpeg is here:
	WHERE ffmpeg
	IF %ERRORLEVEL% NEQ 0 (
		echo "[91m[DEBUG] - FFMPEG is missing !!!!!!!!" [37m
		pause
	)
	if exist "*.gpx" (
		WHERE gpsbabel
		IF %ERRORLEVEL% NEQ 0 (
			echo "[91m[DEBUG] - GPSBabel is missing, Take care you need also gpx-animator !!!!!!!!" [37m
			pause
		)
	)
	echo.

	set javapath="C:\Program Files\gpx-animator\jre\bin\java.exe"
	set gpxanimatorpath="C:\Program Files\gpx-animator\gpx-animator-1.7.0-all.jar"




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





	if exist MakeItAll_temp.config (
		set /p title=<MakeItAll_temp.config
	) else (
		set /p title="Which title: "
		echo !title! > MakeItAll_temp.config
		if not exist BU ( 
			mkdir BU
			:: Avoid overwriting
			echo N | copy /-Y * BU\
		) 

	)
	set title2=%title: =_%
	set title2=%title2:-=%
	set title2=%title2:__=_%
	
	

	:: Music
	if not exist Music_list_temp.txt (
		echo [INFO] - Rename correctlty your mp3, the music title at the end will be written based on your filenames
		set /p temp="If you wanna use a jiggle beginning and at the end use files named 'begin.mp3' and-or 'end.mp3'"
		for %%i in (*.mp3) do (
			set Test=T
			if "%%i"=="input_temp.mp3" set Test=F
			if "%%i"=="begin.mp3" set Test=F
			if "%%i"=="end.mp3" set Test=F
			IF "!Test!"=="T" (
				@echo %%~ni >> Music_list_temp.txt
				REM @echo %%i >> Music_list_overlay_temp.txt
			)
		)
	)
	
	echo.
	echo [91m
	set /p temp="Did you add the date in your video ?"
	echo [0m
	
	REM set /p tbdefault=Do you wanna use simple configuration for fps (24) and audio frequence (48Hz) [y/n] ? :
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	set tbdefault=y
	set biketrip=y
	
	if %tbdefault%==y (
		set RV=24000
		set RVd=1/!RV!
		set RA=48000
		set RAd=1/!RA!
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
			(for %%i in (*.mp4) do @echo %%i) > Listmp4_temp.txt
			set /p firstmp4=<Listmp4_temp.txt
			ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 !firstmp4!
		)
		set /p RV="Which RV (if 1/24000, choose 24000): "
		set RVd=1/%RV%
		
		echo Time_base of your audios:
		if !tb!==y (
			for %%i in (*.mp4) DO (
				ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%i
			)
		) else (
			ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 !firstmp4!
			del Listmp4_temp.txt
		)
		set /p RA="Which RV (if 1/48000, choose 48000): "
		set RAd=1/%RA%
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
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start [37m
echo.


:: ---------- Music ----------

echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start Music input_temp.mp3 [37m
echo.
	
	
	if NOT EXIST input_temp.mp3 (
		if exist Listmp3_temp.txt (rm Listmp3_temp.txt)
		ls -1 | grep mp3 | grep -Ev "begin|end|input|List" | sed "s/^/file '/" | sed "s/$/'/" > Listmp3_temp.txt
		if exist Listmp3_temp.txt (
			ffmpeg -stats -loglevel error -safe 0 -f concat -i Listmp3_temp.txt -c copy -y input_temp.mp3
			del Listmp3_temp.txt
		)
	)

	
	:: use - safe 0 before i to avoid problem with filename : https://stackoverflow.com/questions/38996925/ffmpeg-concat-unsafe-file-name
	

:: ---------- Fade in and out video ----------

	if %fadeinout%==y (
	
		echo.
		echo [94m------------------------------------------------- [37m
		echo [94mINFO - Start Fade in and out, need re-encoding [37m
		echo.
		
		for /f %%p in ('ls -1 ^| grep mp4 ^| grep -Ev "zzz_gpx_temp.mp4|zzz_ko-fi.mp4|zzz_music_temp.mp4|00000_title.mp4" ^| head -1') do set firstfile=%%p
		for /f %%p in ('ls -1 ^| grep mp4 ^| grep -Ev "zzz_gpx_temp.mp4|zzz_ko-fi.mp4|zzz_music_temp.mp4|00000_title.mp4" ^| tail -1') do set lastfile=%%p
		
		
		for /f %%i in ('grep fadein_done MakeItAll_temp.config ^| wc -l') do set check=%%i
		if !check!==0 (
			echo --- Create fadein on !firstfile!
			ffmpeg -stats -loglevel error -i "BU\!firstfile!" -vf "fade=t=in:st=0:d=3" -c:a copy -y "!firstfile!"
			echo fadein_done >> MakeItAll_temp.config
		)
		for /f %%i in ('grep fadeout_done MakeItAll_temp.config ^| wc -l') do set check=%%i
		if !check!==0 (
			echo --- Create fadeout on !lastfile!
			ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "BU\!lastfile!" > tempfile
			set /p lengthvideo=<tempfile
			del tempfile
			set /a lengthvideo2=lengthvideo
			set /a lengthvideo3=lengthvideo2-3
			if !lengthvideo2! gtr 3 (
				ffmpeg -stats -loglevel error -i "BU\!lastfile!" -vf "fade=t=out:st=!lengthvideo3!:d=3" -c:a copy -y "!lastfile!"
			)
			echo fadeout_done >> MakeItAll_temp.config
		)
	)
	



:: ---------- Create Title ----------

	
echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start title [37m
echo.



	copy "C:\Users\doria\Downloads\Pictures\Ko-fi.mp4" "zzz_ko-fi.mp4"
	
	
	REM copy /V C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\FFmpeg\ARIAL.TTF
	
	echo|set /p="| ">temptitle
	echo|set /p=%title%>>temptitle
	echo|set /p=" |">>temptitle

	if NOT EXIST 00000_title.mp4 (
		REM ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=1920x1080:d=8 -vf drawtext="fontfile='Arial':fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:textfile=temptitle" -video_track_timescale %RV% 000_temp.mp4
		if not %biketrip%==y (
			ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=1920x1080:d=10 -vf drawtext="fontfile='Arial':fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:textfile=temptitle" -video_track_timescale %RV% 000_temp.mp4
			ffmpeg -stats -loglevel error -i 000_temp.mp4 -f lavfi -i aevalsrc=0 -shortest -y 000_temp2.mp4
		) else (
			ffmpeg -stats -loglevel error -i "C:\Users\doria\Downloads\Pictures\Tatoo_v02.mp4" -vf drawtext="fontfile='Arial':fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:textfile=temptitle" -video_track_timescale %RV% 000_temp.mp4
			ffmpeg -stats -loglevel error -i 000_temp.mp4 -f lavfi -i aevalsrc=0 -shortest -y 000_temp2.mp4
		)
		:: add audio
		:: change parameters audio
		ffmpeg -stats -loglevel error  -i 000_temp2.mp4 -vf "fade=t=in:st=1:d=3,fade=t=out:st=7:d=3" -c:a copy 000_temp3.mp4
		ffmpeg -stats -loglevel error -i 000_temp3.mp4 -ar %RA% -video_track_timescale %RV% 00000_title.mp4
		del 000_temp.mp4 000_temp2.mp4 000_temp3.mp4

	)
	del temptitle
	::  -f lavfi -i aevalsrc=0 -shortest 
	:: Generate the minimum silence required
	:: https://superuser.com/questions/1096921/concatenating-videos-with-ffmpeg-produces-silent-video-when-the-first-video-has
	
	
	
	
echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start music title [37m
echo.
	
	
	
	if not exist Music_list_temp.txt (
		ffmpeg -stats -loglevel error -f lavfi -i "color=c=black:s=1920x1080:d=12" -video_track_timescale %RV% zzz.mp4
		ffmpeg -stats -loglevel error -i zzz.mp4 -f lavfi -i aevalsrc=0 -shortest -y zzza.mp4
		ffmpeg -stats -loglevel error -i zzza -ar %RA% zzzb.mp4
		del zzz.mp4 zzza.mp4
	)

	if NOT EXIST zzz_music_temp.mp4 (
		set /a x=1
		REM for /f %%a in ('type "Music_list_temp.txt" ^| find "" /v /c') do set /a lines=%%a
		for /f %%a in ('cat Music_list_temp.txt ^| wc -l') do set /a lines=%%a
		for /F "usebackq tokens=*" %%a in ("Music_list_temp.txt") do (
			set music=%%a
			echo [93m!music! [37m
			set /a before=x-1
			set /a high=lines+1
			set /a high/=2
			set /a high=x-high
			set /a high*=75
			if !x!==1 (	
				set /a hightitle=high-150
				ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=1920x1080:d=12 -vf drawtext="fontfile='Arial':fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!hightitle!:text='| Music |'" -video_track_timescale %RV% zzz.mp4
				ffmpeg -stats -loglevel error -i zzz.mp4 -f lavfi -i aevalsrc=0 -shortest -y zzza.mp4
				ffmpeg -stats -loglevel error -i zzza.mp4 -vf drawtext="fontfile='Arial':fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!high!:text='%%a'" -video_track_timescale %RV% zzz!x!.mp4
				del zzz.mp4 zzza.mp4
			) else (
				ffmpeg -stats -loglevel error -i zzz!before!.mp4 -vf drawtext="fontfile='Arial':fontsize=60:fontcolor=white:x=(w-text_w)/2:y=((h-text_h)/2)+!high!:text='%%a'" -video_track_timescale %RV% zzz!x!.mp4
				del zzz!before!.mp4
			)
			set last=zzz!x!.mp4
			set /a x+=1
		)
		ffmpeg -stats -loglevel error -i !last! -ar %RA% zzzd.mp4
		ffmpeg -stats -loglevel error -i zzzd.mp4 -video_track_timescale %RV% zzzb.mp4
		del !last! zzzd.mp4
	)
	
		
	if exist zzzb.mp4 (
		ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 zzzb.mp4 > tempfile
		set /p lengthvideo=<tempfile
		set /a lengthvideo2=lengthvideo
		set /a lengthvideo3=lengthvideo2-3
		del tempfile
		ffmpeg -stats -loglevel error -i zzzb.mp4 -vf "fade=t=in:st=1:d=3,fade=t=out:st=!lengthvideo3!:d=3" -c:a copy zzz_music_temp.mp4
		del zzzb.mp4
	)



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
		%javapath% -jar %gpxanimatorpath% --input "Merge.gpx" --output "%wd%\zzz_gpx_temp.mp4" --tms-url-template "https://{switch:a,b,c}.tile-cyclosm.openstreetmap.fr/cyclosm/{zoom}/{x}/{y}.png" --width 1920 --height 1080 --speedup 10000 --fps 24 --keep-last-frame 7000 --font Monospaced-BOLD-22 --margin 0 --tail-duration 0 --color "#FF0000" --flashback-duration 0 --background-map-visibility 1
		ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 zzz_gpx_temp.mp4 > tempfile
		set /p lengthvideo=<tempfile
		set /a lengthvideo2=lengthvideo
		set /a lengthvideo3=lengthvideo2-3
		if !lengthvideo2! gtr 3 (
			rename zzz_gpx_temp.mp4 zzz_gpx_temp_temp.mp4
			ffmpeg -stats -loglevel error -i zzz_gpx_temp_temp.mp4 -vf "fade=t=in:st=1:d=3,fade=t=out:st=!lengthvideo3!:d=3" -c:a copy zzz_gpx_temp.mp4
			del zzz_gpx_temp_temp.mp4
		)
		rename zzz_gpx_temp.mp4 zzz_gpx_temp_temp.mp4
		ffmpeg -stats -loglevel error -i zzz_gpx_temp_temp.mp4 -video_track_timescale %RV% -ar %RA% zzz_gpx_temp.mp4
		del zzz_gpx_temp_temp.mp4
	)
)




echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start RA and RV [37m
echo.



	:: change RV to have all the same - audio RV
	set /a n=0
	for /f %%i in ('ls ^| grep ".mp4" ^| wc -l') do set all=%%i
	
	for /f %%i in ('grep Rate_done MakeItAll_temp.config ^| wc -l') do set check=%%i
	if %check%==0 (
		for %%i in (*.mp4) DO (
			set /a n+=1
			ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%i > tempfile
			set /p RAdt=<tempfile
			:: check if no audio and add one, needed to bind all audio later, especially with music
			for %%a in (tempfile) do (
				:: check if filesize == 0 
				if %%~za==0 (
					rename %%i %%~ni_temp.mp4
					ffmpeg -stats -loglevel error -i %%~ni_temp.mp4 -f lavfi -i aevalsrc=0 -shortest -y %%i
					del %%~ni_temp.mp4
					ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%i > tempfile
					set /p RAdt=<tempfile
				) 
			)
			ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%i > tempfile
			set /p RVdt=<tempfile
			if "!RAdt!"=="" (
				rename %%i %%~ni_temp.mp4
				ffmpeg -stats -loglevel error -i %%~ni_temp.mp4 -f lavfi -i aevalsrc=0 -shortest -y "%%i"
				del %%~ni_temp.mp4
			)
			if NOT "!RAdt!"=="%RAd%" (
				if NOT "!RVdt!"=="%RVd%" (
					rename %%i %%~ni_temp.mp4
					echo [93m--- Reencode %%i, RV was !RVdt! instead of %RVd% -  RA was !RAdt! instead of %RAd% [37m
					ffmpeg -stats -loglevel error -i %%~ni_temp.mp4 -video_track_timescale %RV% -ar %RA% %%i
					:: change to recycle once reboot
					del %%~ni_temp.mp4
				) else (
					rename %%i %%~ni_temp.mp4
					echo [93m--- Reencode %%i, RA was !RAdt! instead of %RAd% [37m
					ffmpeg -stats -loglevel error -i %%~ni_temp.mp4 -ar %RA% %%i
					del %%~ni_temp.mp4
				)
			) else (
				if NOT "!RVdt!"=="%RVd%" (
					rename %%i %%~ni_temp.mp4
					echo [93m--- Reencode %%i, RV was !RVdt! instead of %RVd% [37m
					ffmpeg -stats -loglevel error -i %%~ni_temp.mp4 -video_track_timescale %RV% %%i
					del %%~ni_temp.mp4
				)
			)
			echo [32m!n!/%all% -- RA and RV OK -- %%i  [37m
		)
		REM touch RA_RV_Done
		echo Rate_done >> MakeItAll_temp.config
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
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start bind for checking duration [37m
echo.

	
	for /f %%i in ('grep Duration_done MakeItAll_temp.config ^| wc -l') do set check=%%i
	if %check%==0 (
	
		(for %%i in (*.mp4) do @echo file '%%i') > Listmp4_temp.txt
		ffmpeg -stats -loglevel error -f concat -i Listmp4_temp.txt -c copy output_temp.mp4
		del Listmp4_temp.txt
		
		for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 input_temp.mp3') do set duraa^=%%i
		for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 output_temp.mp4') do set durav=%%i
		del tempfile
		set /a duraa=duraa
		set /a durav=durav
		
		IF !duraa! LSS !durav! (
			echo.
			echo [91m[DEBUG] - Your music is not long enough for your video ... [37m
			echo [91m[DEBUG] - Your music is not long enough for your video ... [37m
			echo [91m[DEBUG] - Your music is not long enough for your video ... [37m
			echo [91m[DEBUG] - Length Video is !durav! [37m
			echo [91m[DEBUG] - Length Audio is !duraa! [37m
			echo [91m[DEBUG] - Length Video is !durav! >> MakeItAll_temp.config  [37m
			echo [91m[DEBUG] - Length Audio is !duraa! >> MakeItAll_temp.config  [37m
			echo [91m[DEBUG] - input_temp.mp3 and output_temp.mp4 will be deleted, please check if necessary [37m
			pause
			echo.
			del input_temp.mp3 output_temp.mp4 Music_list_temp.txt
			goto eof
		) else (
			del output_temp.mp4
		)
		if not defined duraa (
			echo [91m[ERROR] - could not check duration, variable duraa does not exist [37m
			pause
			goto eof
		)
		if not defined durav (
			echo [91m[ERROR] - could not check duration, variable durav does not exist [37m
			pause
			goto eof
		)
		REM touch dura_Done
		echo Duration_done >> MakeItAll_temp.config
	)
	
	

	REM del output_temp0.mp4



:: ---------- Modification ----------


	REM powercfg /hibernate off
	
	
	
	
	
	
	
echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Add music title overlay [37m
echo.

	for /f %%i in ('grep Overlay_done MakeItAll_temp.config ^| wc -l') do set check=%%i
	if %check%==0 (
		if not exist Video_list_overlay_temp.txt (
			(for %%i in (*.mp4) do @echo %%i) > Video_list_overlay_temp.txt
		)
		if exist Music_list_overlay_duration_temp.txt del Music_list_overlay_duration_temp.txt
		for %%i in (*.mp3) do (
			set Test=T
			if "%%i"=="input_temp.mp3" set Test=F
			if "%%i"=="begin.mp3" set Test=F
			if "%%i"=="end.mp3" set Test=F
			IF "!Test!"=="T" (
				@echo %%i >> Music_list_overlay_temp.txt
				ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%%i" >> Music_list_overlay_duration_temp.txt
			)
		)
	
		
		set xpos=0.90
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
						set musicn2=!musicn:~0,-5!
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
						REM echo ffmpeg -stats -loglevel error -i !rename! -vf "drawtext=textfile=tempfilemusic: fontcolor=white: fontfile='Arial':fontfile='Arial':fontsize=20: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,!posmusic!,!posmusic2!)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -c:a copy -video_track_timescale %RV% %%b
						ffmpeg -stats -loglevel error -i !rename! -vf "drawtext=text='!musicn!': fontcolor=white: fontfile='Arial':fontfile='Arial':fontsize=30: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,!posmusic!,!posmusic2!)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -c:a copy -video_track_timescale %RV% %%b
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
	)

echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start bind [37m
echo.

	(for %%i in (*.mp4) do @echo file '%%i') > Listmp4_temp.txt
	
	ffmpeg -stats -loglevel error -f concat -i Listmp4_temp.txt -c copy output_temp.mp4
	del Listmp4_temp.txt
	
	
	for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 output_temp.mp4') do set durav=%%i
	set /a durav2=durav/3
	set /a durav3=durav-45
	if "%biketrip%"=="y" (
		:: add subscribe to support
		REM rename output_temp.mp4 output_temp0.mp4
		rename output_temp.mp4 output_temp1.mp4
		ffmpeg -stats -loglevel error -y -i output_temp1.mp4 -i "C:\Users\doria\Downloads\Pictures\Subscribe_v02.mp4" -filter_complex "[1:v]setpts=PTS-STARTPTS+%durav2%/TB[1v1];[1v1]colorkey=black:similarity=0.4[1v2];[0:v][1v2]overlay[v]" -map "[v]" -map 0:a output_temp2.mp4
		ffmpeg -stats -loglevel error -y -i output_temp2.mp4 -stream_loop -1 -i "C:\Users\doria\Downloads\Pictures\Tatoo_FIX_v01.png" -filter_complex "[0]overlay=enable='between(t,13,%durav3%)':x=0:y=0:shortest=1[out]" -map [out] -map 0:a output_temp.mp4
		del output_temp1.mp4 output_temp2.mp4
	)
	
	
echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start bind music [37m
echo.

	:: check this https://stackoverflow.com/a/11783474/2444948
	:: check this https://stackoverflow.com/a/11783474/2444948
	:: check this https://stackoverflow.com/a/11783474/2444948


	:: audio replace
	::ffmpeg -stats -loglevel error -i output_temp.mp4 -i inputfinal.mp3 -c copy -map 0:0 -map 1:0 -shortest output2.mp4
	:: audio mixen
	if EXIST input_temp.mp3 (
		::ffmpeg -stats -loglevel error -i output_temp.mp4 -i input_temp.mp3 -filter_complex "[0:a]volume=2[a1];[1:a]volume=0.5[a2];[a1][a2]amerge=inputs=2[a]" -map 0:v -map "[a]" -c:v copy -c:a libvorbis -ac 2 -shortest output_high.mp4 :: 20191224 was not working on the samsung TV because of the vorbis codec
		ffmpeg -stats -loglevel error -i output_temp.mp4 audio.mp3
		ffmpeg -stats -loglevel error -i output_temp.mp4 -i input_temp.mp3 -filter_complex "[0:a]volume=4[a1];[1:a]volume=0.3[a2];[a1][a2]amerge=inputs=2[a]" -map 0:v -map "[a]" -c:v copy -ac 2 -shortest output_high_temp.mp4
		REM ffmpeg -stats -loglevel error -i output_temp.mp4 -i input_temp.mp3 -filter_complex "[0:a]volume=4[a1];[1:a]volume=0.3[a2]" -map 0:v -map "[a1]" -map "[a2]" -c:v copy -ac 2 -shortest output_high_temp.mp4 :: does not work

	) 
	if NOT EXIST output_high_temp.mp4 (
		rename output_temp.mp4 output_high_temp.mp4
	)
	if exist output_temp.mp4 (
		del output_temp.mp4
	)
	
	
echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start bind jingle if exist [37m
echo.
	
	REM BECAREFUL superposition de jinge et music I think
	REM BECAREFUL superposition de jinge et music I think
	REM BECAREFUL superposition de jinge et music I think
	REM BECAREFUL superposition de jinge et music I think
	REM BECAREFUL superposition de jinge et music I think
	
	if EXIST begin.mp3 (
		ffmpeg -stats -loglevel error -i output_high_temp.mp4 -i begin.mp3 -filter_complex "amix=inputs=2:duration=longest" -c:v copy -ac 2 output_high_jiggle_start.mp4
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
		set /a dura2=dura
		ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 end.mp3 > tempfile
		set /p duraend=<tempfile
		del tempfile
		set /a duraend2=duraend
		SET /A mark = dura2 - duraend2
		ffmpeg -stats -loglevel error -i output_high_jiggle_start.mp4 -itsoffset !mark!s -i end.mp3  -filter_complex "amix=inputs=2:duration=longest" -c:v copy -ac 2 -async 1 output_high.mp4
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
			echo [93m[INFO] - use ffmpeg-normlize [37m
			echo [93m[INFO] - use ffmpeg-normlize [37m
			echo [93m[INFO] - use ffmpeg-normlize [37m
			echo [93m[INFO] - use ffmpeg-normlize [37m
			echo [93m[INFO] - use ffmpeg-normlize [37m
			echo.
			ffmpeg-normalize output_high_temp_ffmpeg-normalize.mp4 -c:a aac -b:a 192k -o output_high.mp4
		)	
		if exist output_high_temp_ffmpeg-normalize.mp4 (
			del output_high_temp_ffmpeg-normalize.mp4
		)
	)
	

	
	
	
echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start convert low [37m
echo.
	
	rename output_high.mp4 output_high_temp.mp4
	ffmpeg -stats -loglevel error -i output_high_temp.mp4 output_high.mp4
	del output_high_temp.mp4
	:convertion1
	ffmpeg -stats -loglevel error -i output_high.mp4 -vcodec libx264 -vbr 3 -vf "scale=1024:-2" -preset slow -crf 25 output_1024_crf25_temp.mp4
	:convertion2
	ffmpeg -stats -loglevel error -i output_high.mp4 -vcodec libx264 -vbr 3 -vf "scale=1920:-2" -preset slow -crf 25 output_1920_crf25_temp.mp4
	:convertion3
	ffmpeg -stats -loglevel error -i output_1024_crf25_temp.mp4 -vcodec libx264 -vbr 3 -vf "scale=720:-2" -preset slow -crf 25 output_720_crf25_temp.mp4
	
	rename output_1024_crf25_temp.mp4 %title2%_youtube.mp4
	rename output_1920_crf25_temp.mp4 %title2%_TV.mp4
	rename output_720_crf25_temp.mp4 %title2%_low.mp4
	rename audio.mp3 %title2%_AUDIO.mp3
	del output_high.mp4

	REM powercfg /hibernate on
	
	echo.
	echo.
	echo [32mFinish :) [37m
	
	echo move %title2%_youtube.mp4 C:\Users\doria\Downloads\Pictures\2023\Video\Youtube > IF_OK_MOVE_READY_MP4.bat
	echo move %title2%_TV.mp4 C:\Users\doria\Downloads\Pictures\2023\Video\High >> IF_OK_MOVE_READY_MP4.bat
	echo move %title2%_low.mp4 C:\Users\doria\Downloads\Pictures\2023\Video\Low >> IF_OK_MOVE_READY_MP4.bat
	echo move %title2%_AUDIO.mp3 C:\Users\doria\Downloads\Pictures\2023\Video\Audio >> IF_OK_MOVE_READY_MP4.bat

	:eof
	pause
	
	