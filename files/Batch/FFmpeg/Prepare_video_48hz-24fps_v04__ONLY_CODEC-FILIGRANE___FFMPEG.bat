@echo off
SetLocal EnableDelayedExpansion
setlocal enableextensions

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

:: rename extension
for %%a in (*.MP4) do (
	rename "%%~nxa" "%%~na.mp4"
)  


		set RV=30000
		set RVd=1/!RV!
		set RA=48000
		set RAd=1/!RA!



REM USELESS you loose the key frames ------------
REM USELESS you loose the key frames ------------
REM USELESS you loose the key frames ------------
REM USELESS you loose the key frames ------------
REM echo.
REM echo -----------------------------
REM echo Size
REM echo.

REM WHERE ffmpeg
REM IF %ERRORLEVEL% NEQ 0 (
	REM echo "[DEBUG] - FFMPEG is missing !!!!!!!!"
	REM pause
REM ) else (
	REM for %%i in (*.mp4) DO (
		REM for /F %%j in ('ffprobe -v quiet -select_streams v:0 -show_entries stream_tags^=creation_time -of default^=noprint_wrappers^=1 "%%i" ^| wc -l') do set /a cline=%%j
		REM :: check if no audio and add one, needed to bind all audio later, especially with music
		REM echo --- File %%i - Lines = !cline!
		REM if !cline!==1 (
			REM rename %%i %%~ni_temp.mp4
				REM ffmpeg -stats -loglevel error -i %%~ni_temp.mp4 -vcodec libx264 -x264-params keyint=24:scenecut=0 -acodec copy "%%i"
			REM if exist "%%i" ( del "%%~ni_temp.mp4" )
		REM )
	REM )
REM )


:: change tbs to have all the same - audio tbs
WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - FFMPEG is missing !!!!!!!!"
	pause
) 
:: audio 
	:: audio 
		echo.
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
			:: TBS
			for /f %%j in ('du "%%i" ^| cut -f -1') do set /a sizefile=%%j
			
			for /f %%j in ('ffprobe -v error -select_streams v:0 -show_entries stream_tags^=rotate -of default^=noprint_wrappers^=1:nokey^=1 "%%i"') do set rota=%%j
			REM for /f %j in ('ffprobe -v error -select_streams v:0 -show_entries stream_tags^=rotate -of default^=noprint_wrappers^=1:nokey^=1 "00004.mp4"') do set rota=%j
			
			REM if defined rota (
				REM echo [96m--- File %%i rotated - Add padding[37m
				REM rename "%%i" "%%~ni_temp.mp4"
				REM ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,setsar=1" "%%i"
				REM if exist "%%i" ( del "%%~ni_temp.mp4" )
			REM )
			for /f %%j in ('ffprobe -v error -select_streams v:0 -show_entries stream^=codec_name -of default^=noprint_wrappers^=1:nokey^=1 "%%i"') do set codec=%%j
			for /f %%j in ('ffprobe -v error -select_streams v:0 -show_entries stream^=width -of default^=noprint_wrappers^=1:nokey^=1 "%%i"') do set reso=%%j
			for /f %%j in ('ffprobe -v error -select_streams v:0 -show_entries stream^=time_base -of default^=noprint_wrappers^=1:nokey^=1 "%%i"') do set RVdt=%%j
			REM ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 
			REM ffprobe -v error -select_streams v:0 -show_entries stream=width -of default=noprint_wrappers=1:nokey=1 
				REM ffprobe -v error -select_streams v:0 -show_entries stream 00005.mp4 | grep -E "width|height"
			REM ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 
			for /f %%k in ('ffprobe -v error -select_streams v:0 -show_entries stream^=width -of default^=noprint_wrappers^=1:nokey^=1 "%%i"') do set reso=%%k
			
			if not !codec!==h264 (
				REM if not !reso!==1920 (
					REM if not "!RVdt!"=="%RVd%" (
						REM echo [93m--- File %%i 	[91mcodec = !codec!	reso = !reso!	RVdt = !RVdt![37m
						REM ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -vf "scale=1920:-2" -preset slow -video_track_timescale %RV% "%%i"
						REM if exist "%%i" ( del "%%~ni_temp.mp4" )
					REM ) else (
						REM echo [93m--- File %%i 	[91mcodec = !codec!	reso = !reso!	[92mRVdt = !RVdt![37m
						REM rename "%%i" "%%~ni_temp.mp4"
						REM ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -vf "scale=1920:-2" -preset slow "%%i"
						REM if exist "%%i" ( del "%%~ni_temp.mp4" )
					REM )
				REM ) else (
					if not "!RVdt!"=="%RVd%" (
						echo [93m--- File %%i 	[91mcodec = !codec!	[92mreso = !reso!	[91mRVdt = !RVdt![37m
						rename "%%i" "%%~ni_temp.mp4"
						REM ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -vcodec libx264 -x264-params keyint=12:scenecut=0 -video_track_timescale %RV% "%%i"
						ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -i "D:\Pictures\Youtube\Tatoo\Tatoo_FIX_v01_crop.png" -filter_complex "[0:v][1:v] overlay=W-w:H-h" -pix_fmt yuv420p -vcodec libx264 -x264-params keyint=12:scenecut=0 -video_track_timescale %RV% "%%i"
						if exist "%%i" ( del "%%~ni_temp.mp4" )
					) else (
						echo [93m--- File %%i 	[91mcodec = !codec!	[92mreso = !reso!	RVdt = !RVdt![37m
						rename "%%i" "%%~ni_temp.mp4"
						REM ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -vcodec libx264 -x264-params keyint=12:scenecut=0 "%%i"
						ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4"  -i "D:\Pictures\Youtube\Tatoo\Tatoo_FIX_v01_crop.png" -filter_complex "[0:v][1:v] overlay=W-w:H-h" -pix_fmt yuv420p -vcodec libx264 -x264-params keyint=12:scenecut=0 "%%i"
						if exist "%%i" ( del "%%~ni_temp.mp4" )
					)
				REM )
			) else (
				REM if not !reso!==1920 (
					REM if not "!RVdt!"=="%RVd%" (
						REM echo [93m--- File %%i 	[92mcodec = !codec!	[91mreso = !reso!	RVdt = !RVdt![37m
						REM rename "%%i" "%%~ni_temp.mp4"
						REM ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -vf "scale=1920:-2" -preset slow -video_track_timescale %RV% "%%i"
						REM if exist "%%i" ( del "%%~ni_temp.mp4" )
					REM ) else (
						REM echo [93m--- File %%i 	[92mcodec = !codec!	[91mreso = !reso!	[92mRVdt = !RVdt![37m
						REM rename "%%i" "%%~ni_temp.mp4"
						REM ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -vf "scale=1920:-2" -preset slow "%%i"
						REM if exist "%%i" ( del "%%~ni_temp.mp4" )
					REM )
				REM ) else (
					if not "!RVdt!"=="%RVd%" (
						echo [93m--- File %%i 	[92mcodec = !codec!	reso = !reso!	[91mRVdt = !RVdt![37m
						rename "%%i" "%%~ni_temp.mp4"
						REM ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -c:v copy -video_track_timescale %RV% "%%i"
						ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -i "D:\Pictures\Youtube\Tatoo\Tatoo_FIX_v01_crop.png" -filter_complex "[0:v][1:v] overlay=W-w:H-h" -pix_fmt yuv420p -video_track_timescale %RV% "%%i"
						if exist "%%i" ( del "%%~ni_temp.mp4" )
					) else (
						echo [92m--- File %%i 	codec = !codec!	reso = !reso!	RVdt = !RVdt![37m
					)
				REM )
			)
			for /f %%j in ('du "%%i" ^| cut -f -1') do set /a sizefile2=%%j
			echo [90m--------- !sizefile! to !sizefile2! bits[37m
		)
	
pause