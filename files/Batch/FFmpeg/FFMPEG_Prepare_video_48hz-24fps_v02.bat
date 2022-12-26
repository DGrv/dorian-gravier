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


set tbs=24000
set tbs2=1/!tbs!
set tbsa=48000
set tbsa2=1/!tbsa!



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


echo.
echo -----------------------------
echo Audio
echo.

:: change tbs to have all the same - audio tbs
WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - FFMPEG is missing !!!!!!!!"
	pause
) else (
	for %%i in (*.mp4) DO (
		for /f %%c in ('ffprobe -v error -select_streams a:0 -show_entries stream^=time_base -of default^=noprint_wrappers^=1:nokey^=1 %%i') do set tbna=%%c
		:: check if no audio and add one, needed to bind all audio later, especially with music
		echo --- File %%i - tbna = !tbna!
		if NOT "!tbna!"=="%tbsa2%" (
			if "!tbna!"=="" (
				echo --- Add sound null
				rename %%i %%~ni_temp.mp4
				ffmpeg -stats -loglevel error -i %%~ni_temp.mp4 -f lavfi -i aevalsrc=0 -shortest -y "%%i"
				if exist "%%i" ( del "%%~ni_temp.mp4" )
			)
			rename %%i %%~ni_temp.mp4
			ffmpeg -stats -loglevel error -i %%~ni_temp.mp4 -ar %tbsa% "%%i"
			if exist "%%i" ( del "%%~ni_temp.mp4" )
		)
	)
)
		


echo.
echo -----------------------------
echo Video
echo.
:: change tbs to have all the same - video tbs
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - FFMPEG is missing !!!!!!!!"
	pause
) else (
	for %%i in (*.mp4) DO (
		for /f %%c in ('ffprobe -v error -select_streams v:0 -show_entries stream^=time_base -of default^=noprint_wrappers^=1:nokey^=1 %%i') do set tbn=%%c
		echo --- File %%i - tbn = !tbn!
		if NOT "!tbn!"=="%tbs2%" (
			rename "%%i" "%%~ni_temp.mp4"
			ffmpeg -stats -loglevel error -i "%%~ni_temp.mp4" -video_track_timescale %tbs% "%%i"
			:: change to recycle once reboot
			if exist "%%i" ( del "%%~ni_temp.mp4" )
		)
	)
)


