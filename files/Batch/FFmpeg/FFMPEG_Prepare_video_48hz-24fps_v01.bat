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


set tbs=24000
set tbs2=1/!tbs!
set tbsa=48000
set tbsa2=1/!tbsa!


:: change tbs to have all the same - audio tbs
WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - FFMPEG is missing !!!!!!!!"
	pause
) else (
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
)
		


echo.
echo -------------------------------------------------
echo INFO - Start tbsa
echo.

:: change tbs to have all the same - video tbs
WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - FFMPEG is missing !!!!!!!!"
	pause
) else (
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
)


