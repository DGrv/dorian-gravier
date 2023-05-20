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

:: to change the encoding utf8 is 65001 and ansi windows 1252, Maybe change it if problems
REM chcp 1252 

echo "Put your video in 1 folder, order with names, put your mp3 inside (not matter the name, also ordered if needed)."



:: ---------- Setup ----------



	:: get timestamp
	FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET time=%%A
	set TIMESTAMP=%time:~0,8%-%time:~8,6%

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

	REM set /p tbdefault=Do you wanna use simple configuration for fps (24) and audio frequence (48Hz) [y/n] ? :
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	REM ---------------USE HERE DEFAULKT-------------------
	set tbdefault=y
	set biketrip=y
	set fordorian=y
	set pathout=D:\Pictures\2023\Video
	set javapath="C:\Program Files\gpx-animator\jre\bin\java.exe"
	set gpxanimatorpath="C:\Program Files\gpx-animator\gpx-animator-1.7.0-all.jar"
	set fadeinout=y
	set audionorma=n
	set docodec=y
	set doreso=y
	set docheck=y
	
					REM ToDo
					REM check if add songs empty in check seems not
					REM ask for test batch mode to avoid overlay and filigrane
	
	echo.
	echo.
	set /p draft="Do you want to make the [94mdraft[37m version (no filigrane, no overlay) [y/n]: "
	if %draft%==y (
		set dooverlaymusic=n
		set dofiligrane=n
	) else (
		set dooverlaymusic=y
		set dofiligrane=y
	)

	
	echo.
	echo [91m
	set /p temp="Did you add the date in your video ?"
	echo [0m
	
	:: rename MP$ to mp4
	for %%a in (*MP4) do (
		set filenameold=%%~nxa
		rename !filenameold! !filenameold:MP4=mp4!
	)
	
	
	:: config file and BU
	if not exist BU ( 
		mkdir BU
	) 
	if exist MakeItAll_temp.config (
		set /p title=<MakeItAll_temp.config
	) else (
		set /p title="Which title: "
		echo !title! > MakeItAll_temp.config
		REM Avoid overwriting
		echo N | copy /-Y * BU\
	)
	
	REM if %dooverlaymusic%==n (echo Overlay_done >> MakeItAll_temp.config)
	REM if %dofiligrane%==n (echo Filigrane_done >> MakeItAll_temp.config)
	REM if %docodec%==n (echo Codec_done >> MakeItAll_temp.config)
	REM if %doreso%==n (echo Reso_done >> MakeItAll_temp.config)
	if %docheck%==n (echo Check_done >> MakeItAll_temp.config)

	
	
	
	
	
	
	set title2=%title:\n\n= %
	set title2=%title2:\n= %
	set title2=%title2:'=%
	set title2=%title2: =_%
	set title2=%title2: - =___%
	set title2=%title2:,=%
	
	echo %title2%

	:: Music
	REM if not exist Music_list_temp.txt (
		echo [INFO] - Rename correctlty your mp3, the music title at the end will be written based on your filenames
		REM set /p temp="If you wanna use a jiggle beginning and at the end use files named 'begin.mp3' and-or 'end.mp3'"
		REM ls -1 | grep mp3 | grep -Ev "begin|end|input|List" | sed "s/^/file '/" | sed "s/$/'/" > Music_list_temp.txt
		ls -1 | grep mp3 | grep -Ev "begin|end|input|List" | sed "s/.mp3//" > Music_list_temp.txt
	REM )
	

	
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





	REM if EXIST output_720_crf25_temp.mp4 GOTO convertion3
	REM if EXIST output_1920_crf25_temp.mp4 GOTO convertion2
	REM if EXIST output_1024_crf25_temp.mp4 GOTO convertion1
	if EXIST output_720_crf25_temp.mp4 (
		if %draft%==y (
			del output_720_crf25_temp.mp4 output_BIND.mp4 input_temp.mp3 Test_youtube_copy.mp4 Music_list_temp.txt zzz_music_temp.mp4
		) else (
			for /f %%i in ('grep Filigrane_done MakeItAll_temp.config ^| wc -l') do set check=%%i
			if !check!==0 (
				del output_720_crf25_temp.mp4 output_BIND.mp4 input_temp.mp3 Test_youtube_copy.mp4 Music_list_temp.txt zzz_music_temp.mp4
			) else (
				echo.
				echo Going to convertion3 because output_bind.mp4 exist
				echo.
				GOTO convertion3
			)
		)
	)








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
		if exist Listmp3_temp.txt (
			rm Listmp3_temp.txt
		)
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
		
		for /f %%p in ('ls -1 ^| grep mp4 ^| grep -Ev "zzz_gpx_temp.mp4 ^|zzz ^|zzz_lsub_v01.mp4 ^|zzz_ko-fi.mp4 ^|zzz_music_temp.mp4 ^|00000_title.mp4" ^| head -1') do set firstfile=%%p
		for /f %%p in ('ls -1 ^| grep mp4 ^| grep -Ev "zzz_gpx_temp.mp4 ^|zzz ^|zzz_lsub_v01.mp4 ^|zzz_ko-fi.mp4 ^|zzz_music_temp.mp4 ^|00000_title.mp4" ^| tail -1') do set lastfile=%%p
		
		
		for /f %%i in ('grep fadein_done MakeItAll_temp.config ^| wc -l') do set check=%%i
		if !check!==0 (
			copy "!firstfile!" "%wd%\BU\!firstfile!"
			echo --- Create fadein on !firstfile!
			ffmpeg -stats -loglevel error -i "%wd%\BU\!firstfile!" -vf "fade=t=in:st=0:d=3" -c:a copy -y "!firstfile!"
			echo fadein_done >> MakeItAll_temp.config
		)
		for /f %%i in ('grep fadeout_done MakeItAll_temp.config ^| wc -l') do set check=%%i
		if !check!==0 (
			copy "!lastfile!" "%wd%\BU\!lastfile!"
			echo --- Create fadeout on !lastfile!
			for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "%wd%\BU\!lastfile!"') do set lengthvideo=%%i
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



	if not exist zzz_ltools.mp4 ( copy "D:\Pictures\Youtube\tools\zzz_ltools.mp4" "zzz_ltools.mp4" )
	if %biketrip%==y ( 
		if not exist zzz_ko-fi.mp4 ( copy "D:\Pictures\Youtube\Ko-fi\v03\Ko-fi_v03.mp4" "zzz_ko-fi.mp4" )
		if not exist zzz_lsub_v01.mp4 ( copy "D:\Pictures\Youtube\Subscribe\zzz_lsub_v01.mp4" "zzz_lsub_v01.mp4" )
	)
	
	
	REM copy /V C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\FFmpeg\ARIAL.TTF
	
	set "title=%title:(=^(%"
	set "title=%title:)=^)%"
	set "title=%title:\n\n= >> temptitle & echo. >> temptitle & echo %"
	set "title=%title:\n= >> temptitle & echo %"
	set "title=%title:"=%"
	if exist "temptitle" rm temptitle
	echo ^| %title% ^| >> temptitle
	truncate -s -2 temptitle
	
	
	REM echo|set /p="| ">temptitle
	REM echo|set /p=%title%>>temptitle
	REM echo|set /p=" |">>temptitle

	if NOT EXIST 00000_title.mp4 (
		REM ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=1920x1080:d=8 -vf drawtext="fontfile='Arial':fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:textfile=temptitle" -video_track_timescale %RV% 000_temp.mp4
		if %biketrip%==y (
			ffmpeg -stats -loglevel error -i "D:\Pictures\Youtube\Tatoo\Tatoo_v02.mp4" -vf drawtext="fontfile='Arial':fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:textfile=temptitle" -video_track_timescale %RV% 000_temp.mp4
			ffmpeg -stats -loglevel error -i 000_temp.mp4 -f lavfi -i aevalsrc=0 -shortest -y 000_temp2.mp4
		) else (
			ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=1920x1080:d=10 -vf drawtext="fontfile='Arial':fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:textfile=temptitle" -video_track_timescale %RV% 000_temp.mp4
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
		ffmpeg -y -stats -loglevel error -f lavfi -i "color=c=black:s=1920x1080:d=12" -video_track_timescale %RV% zzz.mp4
		ffmpeg -y -stats -loglevel error -i zzz.mp4 -f lavfi -i aevalsrc=0 -shortest -y zzza.mp4
		ffmpeg -y -stats -loglevel error -i zzza -ar %RA% zzzb.mp4
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
		for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 zzzb.mp4') do set lengthvideo=%%i
		set /a lengthvideo2=lengthvideo
		set /a lengthvideo3=lengthvideo2-3
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
		%javapath% -jar %gpxanimatorpath% --input "Merge.gpx" --output "zzz_gpx_temp.mp4" --tms-url-template "https://{switch:a,b,c}.tile-cyclosm.openstreetmap.fr/cyclosm/{zoom}/{x}/{y}.png" --width 1920 --height 1080 --speedup 10000 --fps 24 --keep-last-frame 7000 --font Monospaced-BOLD-22 --margin 0 --tail-duration 0 --color "#FF0000" --flashback-duration 0 --background-map-visibility 1
		for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 zzz_gpx_temp.mp4') do set lengthvideo=%%i
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
echo [94mINFO - Start format check [37m
echo.

	
	for /f %%i in ('grep Check_done MakeItAll_temp.config ^| wc -l') do set check=%%i
	if %check%==0 (
		
		echo.
		:check2
		echo [95m Audio ----------------- [37m
		for %%i in (*.mp4) DO (
			set "RAdt="
			for /f %%c in ('ffprobe -v error -select_streams a:0 -show_entries stream^=time_base -of default^=noprint_wrappers^=1:nokey^=1 "%%i"') do set RAdt=%%c
			if NOT "!RAdt!"=="%RAd%" (
				if not defined RAdt (
					echo [93m--- File %%i	[91mtbna = !RAdt!	Add sound[37m
					rename %%i %%~ni_temp.mp4
					ffmpeg -stats -loglevel error -i %%~ni_temp.mp4 -f lavfi -i aevalsrc=0 -ac 2 -shortest -y -c:v copy "%%i"
					if exist "%%i" ( del "%%~ni_temp.mp4" )
				)
				rename %%i %%~ni_temp.mp4
				ffmpeg -stats -loglevel error -i %%~ni_temp.mp4 -ar %RA% -c:v copy "%%i"
				if exist "%%i" ( del "%%~ni_temp.mp4" )
			) else (
				echo [93m--- File %%i	[92mtbna = !RAdt![37m
			)
		)
	
		:: Video
		echo.
		echo [95m Video ----------------- [37m
		for %%i in (*.mp4) DO (
		
			for /f %%j in ('du "%%i" ^| cut -f -1') do set sizefile=%%j
			for /f %%j in ('ffprobe -v error -select_streams v:0 -show_entries stream_tags^=rotate -of default^=noprint_wrappers^=1:nokey^=1 "%%i"') do set rota=%%j
			if defined rota (
				echo [96m--- File %%i rotated - Add padding[37m
				rename "%%i" "%%~ni_temp.mp4"
				ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,setsar=1" "%%i"
				if exist "%%i" ( del "%%~ni_temp.mp4" )
			)
			for /f %%j in ('ffprobe -v error -select_streams v:0 -show_entries stream^=codec_name -of default^=noprint_wrappers^=1:nokey^=1 "%%i"') do set codec=%%j
			for /f %%j in ('ffprobe -v error -select_streams v:0 -show_entries stream^=width -of default^=noprint_wrappers^=1:nokey^=1 "%%i"') do set reso=%%j
			for /f %%j in ('ffprobe -v error -select_streams v:0 -show_entries stream^=time_base -of default^=noprint_wrappers^=1:nokey^=1 "%%i"') do set RVdt=%%j
			REM ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 
			REM ffprobe -v error -select_streams v:0 -show_entries stream=width -of default=noprint_wrappers=1:nokey=1 
				REM ffprobe -v error -select_streams v:0 -show_entries stream 00005.mp4 | grep -E "width|height"
			REM ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 
			for /f %%k in ('ffprobe -v error -select_streams v:0 -show_entries stream^=width -of default^=noprint_wrappers^=1:nokey^=1 "%%i"') do set reso=%%k
			
			if not !codec!==h264 (
				if not !reso!==1920 (
					if not "!RVdt!"=="%RVd%" (
						echo [93m--- File %%i 	[91mcodec = !codec!	reso = !reso!	RVdt = !RVdt![37m
						ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -vf "scale=1920:-2" -preset slow -video_track_timescale %RV% "%%i"
						if exist "%%i" ( del "%%~ni_temp.mp4" )
					) else (
						echo [93m--- File %%i 	[91mcodec = !codec!	reso = !reso!	[92mRVdt = !RVdt![37m
						rename "%%i" "%%~ni_temp.mp4"
						ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -vf "scale=1920:-2" -preset slow "%%i"
						if exist "%%i" ( del "%%~ni_temp.mp4" )
					)
				) else (
					if not "!RVdt!"=="%RVd%" (
						echo [93m--- File %%i 	[91mcodec = !codec!	[92mreso = !reso!	[91mRVdt = !RVdt![37m
						rename "%%i" "%%~ni_temp.mp4"
						ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -video_track_timescale %RV% "%%i"
						if exist "%%i" ( del "%%~ni_temp.mp4" )
					) else (
						echo [93m--- File %%i 	[91mcodec = !codec!	[92mreso = !reso!	RVdt = !RVdt![37m
						rename "%%i" "%%~ni_temp.mp4"
						ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" "%%i"
						if exist "%%i" ( del "%%~ni_temp.mp4" )
					)
				)
			) else (
				if not !reso!==1920 (
					if not "!RVdt!"=="%RVd%" (
						echo [93m--- File %%i 	[92mcodec = !codec!	[91mreso = !reso!	RVdt = !RVdt![37m
						rename "%%i" "%%~ni_temp.mp4"
						ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -vf "scale=1920:-2" -preset slow -video_track_timescale %RV% "%%i"
						if exist "%%i" ( del "%%~ni_temp.mp4" )
					) else (
						echo [93m--- File %%i 	[92mcodec = !codec!	[91mreso = !reso!	[92mRVdt = !RVdt![37m
						rename "%%i" "%%~ni_temp.mp4"
						ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -vf "scale=1920:-2" -preset slow "%%i"
						if exist "%%i" ( del "%%~ni_temp.mp4" )
					)
				) else (
					if not "!RVdt!"=="%RVd%" (
						echo [93m--- File %%i 	[92mcodec = !codec!	reso = !reso!	[91mRVdt = !RVdt![37m
						rename "%%i" "%%~ni_temp.mp4"
						ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -c:v copy -video_track_timescale %RV% "%%i"
						if exist "%%i" ( del "%%~ni_temp.mp4" )
					) else (
						echo [92m--- File %%i 	codec = !codec!	reso = !reso!	RVdt = !RVdt![37m
					)
				)
			)
			for /f %%j in ('du "%%i" ^| cut -f -1') do set sizefile2=%%j
			echo [90m--------- !sizefile! to !sizefile2! bits[37m
		)
	
		for /f %%i in ('grep Check_done MakeItAll_temp.config ^| wc -l') do set check1=%%i
		if !check1!==0 (
			echo Check_done >> MakeItAll_temp.config
		) else (
			echo Check2_done >> MakeItAll_temp.config
			goto check2end
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
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start bind for checking duration [37m
echo.

	
	for /f %%i in ('grep Duration_done MakeItAll_temp.config ^| wc -l') do set check=%%i
	if %check%==0 (
	
		(for %%i in (*.mp4) do @echo file '%%i') > Listmp4_temp.txt
		ffmpeg -stats -loglevel error -f concat -i Listmp4_temp.txt -c copy output_temp.mp4
		del Listmp4_temp.txt
		
		for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 input_temp.mp3') do set /a duraa=%%i
		for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 output_temp.mp4') do set /a durav=%%i
		:: to avoid missing operator
		set /a duraa=!duraa!
		set /a durav=!durav!
		
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
		REM touch dura_done
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
	if %dooverlaymusic%==y (
		if %check%==0 (
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
			sed -i /Check2_done/d MakeItAll_temp.config
			if exist tempfile del tempfile
			if exist Music_list_overlay_duration_temp.txt del Music_list_overlay_duration_temp.txt
		)
	)
	
	
echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Add filigrane [37m
echo.

	if %biketrip%==y (
		if %dofiligrane%==y (
			for /f %%i in ('grep Filigrane_done MakeItAll_temp.config ^| wc -l') do set check=%%i
			if !check!==0 (
				for /f %%p in ('ls -1 ^| grep mp4 ^| grep -Ev "zzz|title"') do (
					set filenamenoext=%%~np
					set ext=%%~xp
					set name=!filenamenoext!_temp!ext!
					rename %%p !name!
					echo [93m--- Add filigrane to %%p[37m
					REM ffmpeg -stats -loglevel error -y -i "!name!" -stream_loop -1 -i "D:\Pictures\Tatoo_FIX_v01.png" -filter_complex "[0]overlay=enable:x=0:y=0:shortest=1[out]" -map [out] -map 0:a -video_track_timescale %RV% "%%p"
					:: new test from https://video.stackexchange.com/questions/12105/add-an-image-overlay-in-front-of-video-using-ffmpeg
					ffmpeg -stats -loglevel error -y -i "!name!" -i "D:\Pictures\Youtube\Tatoo\Tatoo_FIX_v01_crop.png" -filter_complex "[0:v][1:v] overlay=W-w:H-h" -pix_fmt yuv420p -video_track_timescale %RV% -c:a copy "%%p"
					del "!name!"
				)
				
				(for %%i in (*.mp4) do @echo file '%%i') > Listmp4_temp.txt
				ffmpeg -stats -loglevel error -f concat -i Listmp4_temp.txt -c copy output_temp.mp4
				del Listmp4_temp.txt
				
				for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 output_temp.mp4') do set /a durav=%%i
				del output_temp.mp4
				set /a durav2=durav/3
				
				for /f %%p in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "D:\Pictures\Youtube\Subscribe\Subscribe_v02.mp4"') do set /a timesub=%%p
				set /a tt=0
				for %%b in ("*mp4") do (
					for /f %%h in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "%%b"') do set /a timev=%%h
					set /a tt+=timev
					if !tt! GTR !durav2! (
						if !timev! GTR !timesub! (
							set filenamenoext=%%~nb
							set ext=%%~xb
							set name=!filenamenoext!_temp!ext!
							rename %%b !name!
							echo [93m--- Add filigrane subscribe to %%b[37m
							ffmpeg -stats -loglevel error -y -i !name! -i "D:\Pictures\Youtube\Subscribe\Subscribe_v02.mp4" -filter_complex "[1:v]colorkey=black:similarity=0.4[1v2];[0:v][1v2]overlay[v]" -map "[v]" -video_track_timescale %RV% -map 0:a "%%b"
							del "!name!"
							goto endsub
						)
					)
				)
				:endsub
				echo Filigrane_done >> MakeItAll_temp.config
				sed -i /Check2_done/d MakeItAll_temp.config
			)
		)
	)
	
	for /f %%i in ('grep Check2_done MakeItAll_temp.config ^| wc -l') do set check=%%i
	if !check!==0 ( goto check2 )
	:check2end

echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start bind [37m
echo.

	(for %%i in (*.mp4) do @echo file '%%i') > Listmp4_temp.txt
	
	ffmpeg -stats -loglevel error -f concat -i Listmp4_temp.txt -c copy output_temp.mp4
	del Listmp4_temp.txt
	if %draft%==n ( 	ffmpeg -stats -loglevel error -y -i output_temp.mp4 audio.mp3 )

	:: check youtube copyright
	for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "input_temp.mp3"') do set lengthaudio=%%i
	ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=480x270:d=%lengthaudio% -video_track_timescale %RV% temp.mp4
	ffmpeg -stats -loglevel error -i temp.mp4 -f lavfi -i aevalsrc=0 -ac 2 -shortest -y -c:v copy temp2.mp4
	ffmpeg -stats -loglevel error -i temp2.mp4 -i input_temp.mp3 -filter_complex "[0:a]volume=4[a1];[1:a]volume=0.3[a2];[a1][a2]amerge=inputs=2[a]" -map 0:v -map "[a]" -c:v copy -ac 2 -shortest Test_youtube_copy.mp4
	del temp.mp4 temp2.mp4


	if %audionorma%==y (
		WHERE ffmpeg-normalize
		IF %ERRORLEVEL% EQU 0 (
			echo.
			echo [93m[INFO] - use ffmpeg-normlize [37m
			echo.
			ffmpeg-normalize audio.mp3 -pr -c:a mp3 -o audio_norma.mp3
			rename output_temp.mp4 output_temp2.mp4
			ffmpeg-normalize output_temp2.mp4 -pr -c:a mp3 -o output_temp.mp4
			del output_temp2.mp4
		)	
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
		rename output_temp.mp4 output_temp2.mp4
		ffmpeg -stats -loglevel error -i output_temp2.mp4 -i input_temp.mp3 -filter_complex "[0:a]volume=4[a1];[1:a]volume=0.3[a2];[a1][a2]amerge=inputs=2[a]" -map 0:v -map "[a]" -c:v copy -ac 2 -shortest output_temp.mp4
		REM ffmpeg -stats -loglevel error -i output_temp.mp4 -i input_temp.mp3 -filter_complex "[0:a]volume=4[a1];[1:a]volume=0.3[a2]" -map 0:v -map "[a1]" -map "[a2]" -c:v copy -ac 2 -shortest output_high_temp.mp4 :: does not work
		del output_temp2.mp4

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
		rename output_temp.mp4 output_temp2.mp4
		ffmpeg -stats -loglevel error -i output_temp2.mp4 -i begin.mp3 -filter_complex "amix=inputs=2:duration=longest" -c:v copy -ac 2 output_temp.mp4
	) 
	
	REM https://ourcodeworld.com/articles/read/1484/how-to-get-the-information-and-metadata-of-a-media-file-audio-or-video-in-json-format-with-ffprobe
	REM Get all info available ffprobe : ffprobe -hide_banner -loglevel fatal -show_error -show_format -show_streams -show_programs -show_chapters -show_private_data -print_format json file.mp4
	
	if EXIST end.mp3 (
		for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 output_temp.mp4') do set duraa=%%i
		set /a dura=dura
		for /f %%i in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 end.mp3') do set duraend=%%i
		set /a duraend=duraend
		SET /a mark = dura - duraend
		rename output_temp.mp4 output_temp2.mp4
		ffmpeg -stats -loglevel error -i output_temp2.mp4 -itsoffset !mark!s -i end.mp3  -filter_complex "amix=inputs=2:duration=longest" -c:v copy -ac 2 -async 1 output_temp.mp4
		del output_temp2.mp4
	) 
	
	


	
	
	
echo.
echo [94m------------------------------------------------- [37m
echo [94mINFO - Start convert low [37m
echo.
	
	rename output_temp.mp4 output_BIND.mp4
	:convertion0
	REM ffmpeg -stats -loglevel error -i output_BIND.mp4 output_BIND_lowKF.mp4
	REM del output_BIND.mp4
	:convertion1
	REM ffmpeg -stats -loglevel error -i output_BIND.mp4 -vbr 3 -vf "scale=1024:-2" -preset slow -crf 25 output_1024_crf25_temp.mp4
	:convertion2
	REM ffmpeg -stats -loglevel error -i output_BIND.mp4 -vbr 3 -vf "scale=1920:-2" -preset slow -crf 25 output_1920_crf25_temp.mp4
	:convertion3
	
	if %draft%==n (
		ffmpeg -stats -loglevel error -i output_BIND.mp4 -vbr 3 -vf "scale=720:-2" -preset slow -crf 25 -c:a copy -y output_720_crf25_temp.mp4
		rename output_BIND.mp4 %title2%_TV.mp4
		rename output_720_crf25_temp.mp4 %title2%_low.mp4
		rename audio.mp3 %title2%_AUDIO.mp3
		if exist audio_norma.mp3 ( rename audio_norma.mp3 %title2%_AUDIO-NORMA.mp3 )
		rename Music_list_temp.txt %title2%_MUSIC-TITLE.txt
		echo move %title2%_TV.mp4 %pathout%\High\ > IF_OK_MOVE_READY_MP4.bat
		echo move %title2%_low.mp4 %pathout%\Low\ >> IF_OK_MOVE_READY_MP4.bat
		echo move %title2%_AUDIO.mp3 %pathout%\Audio\ >> IF_OK_MOVE_READY_MP4.bat
		echo move %title2%_AUDIO-NORMA.mp3 %pathout%\Audio\ >> IF_OK_MOVE_READY_MP4.bat
		echo move %title2%_MUSIC-TITLE.txt %pathout%\Music_txt\ >> IF_OK_MOVE_READY_MP4.bat
		del input_temp.mp3
		REM xcopy /Y *.mp3 %pathout%\Music\
		ls | grep mp3 | grep -vE "AUDIO|input_temp|audio.mp3" | xargs -I # cp "#" %pathout%\Music
		echo.
		echo [32m-------------- Finish ------------- [37m
	)

	:eof
	pause
	
	