@echo off
SetLocal EnableDelayedExpansion


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

if exist list.txt del list.txt

echo.
echo Your ffmpeg is here:
WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffmpeg command is unknown, please add it to the PATH
)
echo.



FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET time=%%A
set TIMESTAMP=%time:~0,8%-%time:~8,6%



set file=%1
for %%i in (%file%) do (
	set dir=%%~dpi
	set drive=%%~di
	%%~di
	cd %%~dpi
	REM echo %%i >> list.txt
	set filepathnoext=%%~dpni
    set filename=%%~nxi
	set filenamenoext=%%~ni
	set ext=%%~xi
	set filenamenew=!filenamenoext!_old_%TIMESTAMP%!ext!
)
cd %dir%

echo. 
echo [95m[DEBUG] ---------------------
echo drive=%drive%
echo dir=%dir%
echo file=%file% 
echo filepathnoext=%filepathnoext%
echo filename=%filename%
echo filenamenoext=%filenamenoext%
echo ext=%ext%
echo filenamenew=%filenamenew%
echo ----------------------[0m
echo. 

if "%2"=="" (
	set /p speed=How much do you wanna speed up: 
) else (
	set speed=%2
) 
 
set speed1=%speed:~0,1%
set speed2=%speed:~2,1%
set /a speed2=speed2


:: check rate video
for /f %%i in ('ffprobe -v error -select_streams v:0 -show_entries stream^=time_base -of default^=noprint_wrappers^=1:nokey^=1 "%file%"') do set RVdt=%%i
set RVfile=!RVdt:1/=!
rename "%file%" "%filenamenew%"
if %speed1%==0 (
	if %speed2% LSS 5 (
		echo.
		echo [91mRemove audio because speed less than 0.5, does not work with audio[37m
		echo.
		ffmpeg -stats -loglevel error -y -i "%filenamenew%" -an -vf "setpts=PTS/%speed%" -video_track_timescale %RVfile% "%filenamenoext%_f%speed%%ext%"
	) else (
		ffmpeg -stats -loglevel error -y -i "%filenamenew%" -af "atempo=%speed%" -vf "setpts=PTS/%speed%" -video_track_timescale %RVfile% "%filenamenoext%_f%speed%%ext%"
	)
) else (
	ffmpeg -stats -loglevel error -y -i "%filenamenew%" -af "atempo=%speed%" -vf "setpts=PTS/%speed%" -video_track_timescale %RVfile% "%filenamenoext%_f%speed%%ext%"
)

 
 
 
 
 
 
 