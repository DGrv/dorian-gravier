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


echo Batch file for changing the speed of a video (remove audio as well). Value range is 0 to n (btw 0 and 1 it will slow down your video). mpv will be used to check but you will not be able to go higher than 100 during checking (use [ or ] to increase speed during reading). Will create a new file where the video is with a extra 'f'.
echo.
echo Choose your files to speed up:  


if "%1"=="" (
	set listfiles=powershell -NoP -C "[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms')|Out-Null;$OFD = New-Object System.Windows.Forms.OpenFileDialog;$OFD.Multiselect = $True;$OFD.InitialDirectory = '%mypath%';$OFD.ShowDialog()|out-null;$OFD.FileNames"
	rem exec commands powershell and get result in FileName variable
	for /f "delims=" %%i in ('!listfiles!') do (
		set dir=%%~dpi
		set drive=%%~di
		%%~di
		cd %%~dpi
		echo %%i >> list.txt
	)
) else (
	set file=%1
	for %%i in (!file!) do (
		set dir=%%~dpi
		set drive=%%~di
		%%~di
		cd %%~dpi
		echo %%i >> list.txt
	)
)

echo. 
echo [95m[DEBUG] ---------------------
%drive%
cd %dir%
set file=%dir%list.txt
echo file %file% 
cat %file%
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


REM FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET time=%%A
REM set TIMESTAMP=%time:~0,8%-%time:~8,6%
for /f %%p in ('bash -c "date +"%%Y%%m%%d-%%H%%M%%S""') do set TIMESTAMP=%%p






for /F "usebackq tokens=*" %%p in (%file%) do (
	set filepathnoext=%%~dpnp
    set filename=%%~nxp
	set filenamenoext=%%~np
	set ext=%%~xp
	set filenamenew=!filenamenoext!_old_%TIMESTAMP%!ext!
	:: check rate video
	for /f %%i in ('ffprobe -v error -select_streams v:0 -show_entries stream^=time_base -of default^=noprint_wrappers^=1:nokey^=1 "%%p"') do set RVdt=%%i
	REM ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 %%p > tempfile
	REM set /p RVdt=<tempfile
	set RVfile=!RVdt:1/=!
	REM del tempfile
	rename "%%p" "!filenamenew!"
	REM ffmpeg -stats -loglevel error -y -i "!filenamenew!" -af "atempo=%speed%" -vf "setpts=PTS/%speed%" "!filenamenoext!__temp!ext!"
	REM ffmpeg -stats -loglevel error -i "!filenamenoext!__temp!ext!" -video_track_timescale !RVfile! "%%~np_f%speed%%%~xp"
	if %speed1%==0 (
		if %speed2% LSS 5 (
			echo.
			echo [91mRemove audio because speed less than 0.5, does not work with audio[37m
			echo.
			REM ffmpeg -stats -loglevel error -y -i "!filenamenew!" -f lavfi -i aevalsrc=0 -ac 2 -shortest -vf "setpts=PTS/%speed%" -video_track_timescale !RVfile! "%%~np_f%speed%%%~xp"
			ffmpeg -stats -loglevel error -y -i "!filenamenew!" -an -vf "setpts=PTS/%speed%" -video_track_timescale !RVfile! "%%~np_f%speed%%%~xp"
		) else (
			ffmpeg -stats -loglevel error -y -i "!filenamenew!" -af "atempo=%speed%" -vf "setpts=PTS/%speed%" -video_track_timescale !RVfile! "%%~np_f%speed%%%~xp"
		)
	) else (
		ffmpeg -stats -loglevel error -y -i "!filenamenew!" -af "atempo=%speed%" -vf "setpts=PTS/%speed%" -video_track_timescale !RVfile! "%%~np_f%speed%%%~xp"
	)
	REM del "!filenamenoext!__temp!ext!"
	REM ffmpeg -i "%%p" -af "atempo=%speed%" -vf "setpts=PTS/%speed%" -r 24 "%%~np_f%speed%%%~xp"
)

REM ffmpeg -y -i 105.mp4 -an  -filter:v "setpts=PTS/6" new.mp4
REM ffmpeg -y -i 105.mp4 -af "atempo=6" -vf "setpts=PTS/6,fps=24" new.mp4
REM ffmpeg -y -i 105.mp4 -vf "minterpolate='mi_mode=mci:mc_mode=aobmc:vsbmc=1:fps=24*6'" new.mp4


del list.txt

REM echo.
REM echo All DONE :)
REM echo.

REM pause
 
 
 
 
 
 
 